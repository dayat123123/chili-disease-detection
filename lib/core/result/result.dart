part 'success.dart';
part 'failed.dart';

sealed class Result<T> {
  const Result();
  const factory Result.success(T value) = Success;
  const factory Result.failed(String message) = Failed;

  bool get isSuccess => this is Success<T>;
  bool get isFailed => this is Failed<T>;

  T? get resultValue => isSuccess ? (this as Success<T>).value : null;
  String? get errorMessage => isFailed ? (this as Failed<T>).message : null;
}
