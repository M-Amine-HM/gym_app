import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _elapsedSeconds = 0;
  late bool timerOn;

  int get elapsedSeconds => _elapsedSeconds;

  //bool get _timerOn => _timerOn;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //if (_elapsedSeconds != 0) {
      // _elapsedSeconds = 0;
      // notifyListeners();
      //} else {
      _elapsedSeconds++;
      notifyListeners();
      //}
    });
  }

  void changeSeconds() {
    _elapsedSeconds = 0;
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _elapsedSeconds = 0;

    notifyListeners();
  }

  String formatTime() {
    int minutes = _elapsedSeconds ~/ 60;
    int remainingSeconds = _elapsedSeconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
