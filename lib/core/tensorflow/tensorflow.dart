import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:chili_disease_detection/core/local_storage/local_storage.dart';
import 'package:chili_disease_detection/core/result/result.dart';
import 'package:chili_disease_detection/features/history/presentation/bloc/history_bloc.dart';
import 'package:chili_disease_detection/injector.dart';
import 'package:chili_disease_detection/shared/misc/file_paths.dart';
import 'package:chili_disease_detection/shared/misc/local_storage_keys.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:convert';

class Tensorflow {
  static const int _inputSize = 224;
  static const double _confidenceThreshold = 0.5;
  static const double _maxConfidenceThreshold = 0.7;

  double get confidenceThreshold => _confidenceThreshold;
  double get maxConfidenceThreshold => _maxConfidenceThreshold;

  static final int _numClasses = ClassesResult.values.length;

  final LocalStorage _localStorage;
  static const String _key = LocalStorageKeys.historyTensorFlow;

  Interpreter? _interpreter;
  IsolateInterpreter? _isolateInterpreter;
  bool _isInitialized = false;

  Tensorflow(this._localStorage);

  Future<void> loadTFLiteModel() async {
    if (_isInitialized) return;
    _interpreter = await Interpreter.fromAsset(FilePaths.modelTFLite);

    try {
      _isolateInterpreter = await IsolateInterpreter.create(
        address: _interpreter!.address,
      );
    } catch (e) {
      print(
        "Gagal membuat IsolateInterpreter, fallback ke interpreter biasa: $e",
      );
    }

    _isInitialized = true;
  }

  Future<Result<ResultClassModel>> analyzeData(File file) async {
    if (!_isInitialized || _interpreter == null) {
      return Result.failed("Interpreter belum dimuat");
    }

    try {
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return Result.failed("Gagal decode gambar.");

      final resized = img.copyResize(
        image,
        width: _inputSize,
        height: _inputSize,
      );

      final input = List.generate(_inputSize, (y) {
        return List.generate(_inputSize, (x) {
          final pixel = resized.getPixel(x, y);
          final r = pixel.r;
          final g = pixel.g;
          final b = pixel.b;
          return [(r / 127.5) - 1.0, (g / 127.5) - 1.0, (b / 127.5) - 1.0];
        });
      });

      final modelInput = [input];
      final output = List.filled(_numClasses, 0.0).reshape([1, _numClasses]);

      if (_isolateInterpreter != null) {
        await _isolateInterpreter!.run(modelInput, output);
      } else {
        _interpreter!.run(modelInput, output);
      }

      final result = (output[0] as List).cast<double>();

      int maxIndex = 0;
      // int secondIndex = 0;
      double maxConfidence = -1;
      double secondMaxConfidence = -1;

      for (int i = 0; i < result.length; i++) {
        final value = result[i];
        if (value > maxConfidence) {
          secondMaxConfidence = maxConfidence;
          // secondIndex =  maxIndex;
          maxConfidence = value;
          maxIndex = i;
        } else if (value > secondMaxConfidence) {
          secondMaxConfidence = value;
          // secondIndex = i;
        }
      }

      final predictedClass = ClassesResult.values[maxIndex];
      // final secondClass = ClassesResult.values[secondIndex];

      // if (maxConfidence < _maxConfidenceThreshold) {
      //   return Result.failed(
      //     "Confidence terlalu rendah untuk membuat prediksi yang valid: "
      //     "${predictedClass.name} (${(maxConfidence * 100).toStringAsFixed(2)}%)",
      //   );
      // }

      // if ((maxConfidence - secondMaxConfidence).abs() < _confidenceThreshold) {
      //   return Result.failed(
      //     "Prediksi tidak yakin (confidence antar kelas terlalu mirip): "
      //     "${predictedClass.name} (${(maxConfidence * 100).toStringAsFixed(2)}%) "
      //     "vs ${secondClass.name} (${(secondMaxConfidence * 100).toStringAsFixed(2)}%)",
      //   );
      // }

      final analyzedResult = ResultClassModel(
        maxConfidence,
        predictedClass,
        file,
        DateTime.now(),
      );

      await saveHistoryTensorflow(analyzedResult);
      return Result.success(analyzedResult);
    } catch (e) {
      return Result.failed("Inference gagal: $e");
    }
  }

  Future<void> saveHistoryTensorflow(ResultClassModel result) async {
    try {
      final existingData = await _localStorage.getData(_key);
      List<ResultClassModel> history = [];

      if (existingData != null) {
        history =
            (existingData as List)
                .map(
                  (e) => ResultClassModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();
      }

      history.insert(0, result);

      final encodedList = history.map((e) => e.toJson()).toList();
      await _localStorage.setData(_key, encodedList);
      getHistoryBloc.add(AddNewHistory(result));
    } catch (e) {
      print("Error saveHistoryTensorFlow: ${e.toString()}");
    }
  }

  Future<List<ResultClassModel>> loadHistoryData() async {
    try {
      final existingData = await _localStorage.getData(_key);
      if (existingData != null) {
        return (existingData as List)
            .map((e) => ResultClassModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print("Error loadHistoryData: ${e.toString()}");
    }
    return [];
  }

  Future<void> clearHistories() async {
    try {
      await _localStorage.removeData(_key);
    } catch (e) {
      print("Error clearHistories: ${e.toString()}");
    }
  }
}

enum ClassesResult { healthy, leafCurling, leafSpot, leafYellowing }

class ResultClassModel {
  final double accuracy;
  final ClassesResult selected;
  final File imageFile;
  final DateTime lastUpdated;

  const ResultClassModel(
    this.accuracy,
    this.selected,
    this.imageFile,
    this.lastUpdated,
  );

  Map<String, dynamic> toJson() {
    final imageBytes = imageFile.readAsBytesSync();
    return {
      'accuracy': accuracy,
      'selected': selected.name,
      'imageBytes': base64Encode(imageBytes),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory ResultClassModel.fromJson(Map<String, dynamic> json) {
    final imageBytes = base64Decode(json['imageBytes']);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random();
    final randomNumber = random.nextInt(1000000);

    final tempFile = File(
      '${Directory.systemTemp.path}/image_${timestamp}_$randomNumber',
    );
    tempFile.writeAsBytesSync(imageBytes);

    return ResultClassModel(
      (json['accuracy'] as num).toDouble(),
      ClassesResult.values.byName(json['selected']),
      tempFile,
      DateTime.parse(json['lastUpdated']),
    );
  }
}
