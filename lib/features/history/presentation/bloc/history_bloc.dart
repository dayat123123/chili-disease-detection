import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chili_disease_detection/core/tensorflow/tensorflow.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final Tensorflow _tensorflow;

  HistoryBloc(this._tensorflow) : super(HistoryInitial()) {
    on<LoadHistoryData>(_onLoadHistoryData);
    on<AddNewHistory>(_onAddNewHistoryData);
    on<ClearHistories>(_onClearHistories);
  }

  void _onLoadHistoryData(
    LoadHistoryData event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    final result = await _tensorflow.loadHistoryData();
    emit(HistoryLoaded(listData: result));
  }

  void _onAddNewHistoryData(
    AddNewHistory event,
    Emitter<HistoryState> emit,
  ) async {
    if (state is HistoryLoaded) {
      final HistoryLoaded loadedState = (state as HistoryLoaded);
      final currentData = List<ResultClassModel>.from(loadedState.listData);
      currentData.insert(0, event.data);
      emit(loadedState.copyWith(listData: currentData));
    } else {
      emit(HistoryLoaded(listData: [event.data]));
    }
  }

  void _onClearHistories(
    ClearHistories event,
    Emitter<HistoryState> emit,
  ) async {
    await _tensorflow.clearHistories();
    if (state is HistoryLoaded) {
      final HistoryLoaded loadedState = (state as HistoryLoaded);
      emit(loadedState.copyWith(listData: []));
    } else {
      emit(HistoryLoaded(listData: []));
    }
  }
}
