part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistoryData extends HistoryEvent {
  const LoadHistoryData();
}

class AddNewHistory extends HistoryEvent {
  final ResultClassModel data;
  const AddNewHistory(this.data);

  @override
  List<Object> get props => [data];
}

class ClearHistories extends HistoryEvent {
  const ClearHistories();
}
