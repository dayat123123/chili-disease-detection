part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryLoaded extends HistoryState {
  final List<ResultClassModel> listData;

  const HistoryLoaded({this.listData = const []});

  @override
  List<Object> get props => [listData];

  HistoryLoaded copyWith({List<ResultClassModel>? listData}) {
    return HistoryLoaded(listData: listData ?? this.listData);
  }
}

class HistoryError extends HistoryState {
  final String errorMessage;
  const HistoryError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
