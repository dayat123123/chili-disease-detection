import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class GreetingCubit extends Cubit<String> {
  Timer? _timer;

  GreetingCubit() : super(_getGreeting()) {
    _startTimer();
  }
  static String _getGreeting() {
    final jam = DateTime.now().hour;
    if (jam >= 5 && jam < 12) {
      return 'Selamat Pagi';
    } else if (jam >= 12 && jam < 15) {
      return 'Selamat Siang';
    } else if (jam >= 15 && jam < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      final newGreeting = _getGreeting();
      if (state != newGreeting) emit(newGreeting);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
