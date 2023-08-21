library activsy;

import 'dart:async';

import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Activsy {
  Activsy._() {
    _instance = this;
  }

  Timer? _timer;

  /// [_waiTime] timer wait time
  int _waiTime = 0;

  static bool _initialized = false;

  static Activsy? _instance;

  late void Function() _callback;

  /// [initialize] Initialize the activity monitor,
  /// all methods threw exception if they are called before this method
  factory Activsy.initialize(
      {required int waiTime, required Function() onTimeOut}) {
    assert(waiTime <= 30, "Standby time should not be more than 30 seconds");

    _initialized = true;
    _instance = _instance ?? Activsy._();
    _instance!._waiTime = waiTime;
    _instance!._callback = onTimeOut;

    return _instance!;
  }

  /// [_trigger] Notify the time exceeded
  /// Note: This method only works when monitoring is active
  static void _trigger() {
    if (!_initialized) {
      throw Exception('this function to be called after the initialize method');
    }
    _instance!._callback();
  }

  /// [start] Activity monitoring start
  /// Note: This method only works when monitoring is nat active
  static void start() {
    if (!_initialized) {
      throw Exception('this function to be called after the initialize method');
    }

    var timer = _instance!._timer;

    if (timer != null && timer.isActive) return;

    _instance!._timer = Timer(Duration(seconds: _instance!._waiTime), _trigger);
  }

  /// [stop] Cancel activity monitoring
  /// Note: This method only works when monitoring is active
  static void stop() {
    if (!_initialized) {
      throw Exception('this function to be called after the initialize method');
    }

    if (_instance!._timer != null) _instance!._timer!.cancel();

    _instance!._timer = null;
  }

  /// restore timer [updateTime]
  /// from the timer reset it can also change the seconds
  /// it must wait before triggering the [onTimeOut]
  /// Note: This method only works when monitoring is active and seconds <= 30
  static void updateTime({required int waiTime}) {
    if (!_initialized) {
      throw Exception('this function to be called after the initialize method');
    }

    assert(waiTime <= 30, "Standby time should not be more than 30 seconds");

    var timer = _instance!._timer;

    if (timer == null || !timer.isActive) return;

    _instance!._waiTime = waiTime;

    stop();

    start();
  }

  /// Restores activity monitoring [reset]
  /// Note: This method only works when monitoring is active
  static void reset() {
    if (!_initialized) {
      throw Exception('this function to be called after the initialize method');
    }

    if (_instance!._timer == null || !_instance!._timer!.isActive) return;

    stop();

    start();
  }

  /// There are several reasons to trigger the [onTimeOut]
  /// method before the stipulated timer [forceTimeOut]
  static void forceTimeOut() => _trigger();

  /// checks if the method has been configured [onTimeOut]
  /// this function to be called after the [initialize] method
  /// otherwise you will throw an exception
  static bool get isInitialized => _initialized;

  /// checks monitoring is active [isActive]
  static bool get isActive =>
      (_instance!._timer != null && _instance!._timer!.isActive);
}
