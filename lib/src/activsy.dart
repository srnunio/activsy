library activsy;

import 'dart:async';

import 'dart:developer';

class Activsy {
  Timer? _timer;

  /// [_seconds] timer wait time
  late int _seconds;

  bool _showLog = true;

  /// return function that will be invoked when the timer is equals to 0 [_callback]
  void Function()? _callback;

  static final Activsy _instance = Activsy._internal();

  Activsy._internal();

  /// function responsible for setting the return method after the end of the timer [config]
  factory Activsy.config(
      {required int seconds,
      bool showLog = true,
      required Function() noActivity}) {
    assert(seconds >= 2);
    _instance._showLog = showLog;
    _instance._seconds = seconds;
    _instance._callback = noActivity;
    return _instance;
  }

  /// start and set the timer [startTimer]
  /// this function to be called after the [config] method
  /// otherwise you will throw an exception
  static void startTimer() {
    if (_instance._showLog) log('activsy::start', time: DateTime.now());

    if (_instance._callback == null)
      throw Exception('this function to be called after the config method');

    var timer = _instance._timer;

    var seconds = _instance._seconds;

    if (timer != null && timer.isActive) return;

    _instance._timer = Timer(Duration(seconds: seconds), () {
      _instance._callback!();
      _instance._timer = null;
    });
  }

  /// stop the timer [stopTimer]
  static void stopTimer() {
    if (_instance._showLog) log('activsy::stop', time: DateTime.now());

    var timer = _instance._timer;

    if (timer != null && timer.isActive) timer.cancel();
  }

  /// restore timer [reset]
  /// from the timer reset it can also change the seconds it must wait before triggering the [noActivity]
  /// Note: seconds >= 2
  static void reset({int? seconds}) {
    var _seconds = seconds ?? _instance._seconds;

    assert(_seconds >= 2);

    if (_instance._timer == null) return;

    if (_instance._showLog) log('activsy::reset', time: DateTime.now());

    _instance._seconds = _seconds;

    stopTimer();

    startTimer();
  }

  /// There are several reasons to trigger the noActivity method before the stipulated timer [trigger]
  static void trigger() {
    if (_instance._showLog) log('activsy::trigger', time: DateTime.now());

    if (_instance._callback == null)
      throw Exception('this function to be called after the config method');

    stopTimer();

    _instance._callback!();
  }

  /// checks if the method has been configured [noActivity]
  /// this function to be called after the [config] method
  /// otherwise you will throw an exception
  static bool get isInitialized => _instance._callback != null;
}
