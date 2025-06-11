part of 'result.dart';

class Failed<T> extends Result<T> {
  final String message;
  const Failed(this.message);
}
