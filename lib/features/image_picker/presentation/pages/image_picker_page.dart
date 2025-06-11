import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chili_disease_detection/core/result/result.dart';
import 'package:chili_disease_detection/core/router/route_path.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/injector.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';
import 'package:chili_disease_detection/shared/widgets/card/card_container.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    if (mounted) context.pop();
  }

  void _showImageSourceActionSheet() {
    context.showBottomSheet(
      isScrollControlled: false,
      child: SafeArea(
        child: Padding(
          padding: AppPadding.all,
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera, color: Colors.blue),
                title: Text('Pilih gambar dari kamera'),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.green),
                title: Text('Pilih gambar dari galery'),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapAnalize(File file) async {
    context.showLoadingDialog(isDismissible: false);
    await Future.delayed(Duration(seconds: 1));
    final result = await getTensorflow.analyzeData(file);
    if (mounted) context.pop();
    if (result is Success) {
      final data = result.resultValue!;
      getRouter.push(RoutePath.analyzedPath, extra: data);
    } else {
      if (mounted) {
        context.showToast(
          context: context,
          position: ToastPosition.top,
          status: ToastStatus.failed,
          title: "Gagal",
          subtitle: result.errorMessage ?? "",
        );
      }
    }
  }

  void _onTapPreview() {
    getRouter.push(RoutePath.fullScreenImageViewPath, extra: _selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pilih Gambar")),
      body: Padding(
        padding: AppPadding.all,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_imageWidget()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showImageSourceActionSheet,

        label: const Text("Pilih Gambar"),
        icon: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _imageWidget() {
    return _selectedImage != null
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _onTapPreview,
              child: Container(
                height: context.fullHeight * 0.4,
                width: context.fullWidth * 0.7,
                padding: AppPadding.all,
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.medium,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(_selectedImage!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Pastikan gambar tidak buram dan rusak",
              style: context.textStyle.subtitle,
            ),
            const SizedBox(height: 20),
            CardContainer(
              height: 60,
              width: context.fullWidth * 0.7,
              onTap: () {
                _onTapAnalize(_selectedImage!);
              },
              borderRadius: AppBorderRadius.smallNumber,
              color: context.themeColors.blackColor,
              child: Text(
                "Analisis Gambar",
                style: context.textStyle.title.copyWith(
                  color: context.themeColors.whiteColor,
                ),
              ),
            ),
          ],
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 100, color: context.themeColors.hintColor),
            const SizedBox(height: 10),
            Text(
              "Belum ada gambar yang terpilih",
              style: context.textStyle.body.copyWith(
                color: context.themeColors.hintColor,
              ),
            ),
          ],
        );
  }
}
