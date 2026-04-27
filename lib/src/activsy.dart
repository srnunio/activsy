library activsy;

import 'dart:async';

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
    // assert(waiTime <= 30, "Standby time should not be more than 30 seconds");

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
    if (_instance!._timer == null) return;
    _instance!._callback();
    _instance!._timer!.cancel();
    _instance!._timer = null;
  }

  /// [start] Activity monitoring start
  /// Note: This method only works when monitoring is nat active
  static void start() {
    if (!_initialized) {
      throw Exception('this function to be called after the initialize method');
    }

    var timer = _instance!._timer;

    if (timer != null && timer.isActive) return;

    _instance!._timer =
        Timer.periodic(Duration(seconds: _instance!._waiTime), (timer) {
      _trigger();
      timer.cancel();
    });
    // _instance!._timer = Timer(Duration(seconds: _instance!._waiTime), _trigger);
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

    // assert(waiTime <= 30, "Standby time should not be more than 30 seconds");

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

// class Activsy {
//   static _ActivsyInternal? _internal;
//
//   Activsy._({required int waiTime, required Function() callback}) {
//     _internal =
//         _internal ?? _ActivsyInternal._(waiTime: waiTime, callback: callback);
//   }
//
//   /// [initialize] Initialize the activity monitor,
//   /// all methods threw exception if they are called before this method
//   factory Activsy.initialize(
//       {required int waiTime, required Function() onTimeOut}) {
//     return Activsy._(waiTime: waiTime, callback: onTimeOut);
//   }
//
//   /// [start] Activity monitoring start
//   /// Note: This method only works when monitoring is nat active
//   static void start() {
//     if (_internal == null) {
//       throw Exception('this function to be called after the initialize method');
//     }
//     _internal!._startInternal();
//   }
//
//   /// [stop] Cancel activity monitoring
//   /// Note: This method only works when monitoring is active
//   static void stop() {
//     if (_internal == null) {
//       throw Exception('this function to be called after the initialize method');
//     }
//     _internal!._stopInternal();
//   }
//
//   /// restore timer [update]
//   /// from the timer reset it can also change the seconds
//   /// it must wait before triggering the [onTimeOut]
//   /// Note: This method only works when monitoring is active and seconds <= 30
//   static void update({required int waiTime}) {
//     if (_internal == null) {
//       throw Exception('this function to be called after the initialize method');
//     }
//     _internal!._updateTimeInternal(waiTime: waiTime);
//   }
//
//   /// Restores activity monitoring [reset]
//   /// Note: This method only works when monitoring is active
//   static void reset() {
//     if (_internal == null) {
//       throw Exception('this function to be called after the initialize method');
//     }
//     _internal!._resetInternal();
//   }
//
//   /// There are several reasons to trigger the [onTimeOut]
//   /// method before the stipulated timer [forceTimeOut]
//   static void forceTimeOut() {
//     if (_internal == null) {
//       throw Exception('this function to be called after the initialize method');
//     }
//     _internal!._triggerInternal();
//   }
//
//   /// checks if the method has been configured [onTimeOut]
//   /// this function to be called after the [initialize] method
//   /// otherwise you will throw an exception
//   static bool get isInitialized => (_internal != null);
//
//   /// checks monitoring is active [isActive]
//   static bool get isActive => (isInitialized) ? _internal!.isActive : false;
// }
//
// class _ActivsyInternal {
//   static _ActivsyInternal? instance;
//
//   _ActivsyInternal._({required int waiTime, required Function() callback}) {
//     _waiTime = waiTime;
//     _callback = callback;
//   }
//
//   Timer? _timer;
//
//   /// [_waiTime] timer wait time
//   int _waiTime = 0;
//
//   late void Function() _callback;
//
//   /// [initialize] Initialize the activity monitor,
//   /// all methods threw exception if they are called before this method
//   factory _ActivsyInternal(
//       {required int waiTime, required Function() onTimeOut}) {
//     return instance =
//         instance ?? _ActivsyInternal._(waiTime: waiTime, callback: onTimeOut);
//   }
//
//   /// [_triggerInternal] Notify the time exceeded
//   /// Note: This method only works when monitoring is active
//   void _triggerInternal() {
//     if (_timer == null) return;
//     _callback();
//     _timer!.cancel();
//     _timer = null;
//   }
//
//   /// [_startInternal] Activity monitoring start
//   /// Note: This method only works when monitoring is nat active
//   void _startInternal() {
//     var timer = _timer;
//
//     if (timer != null && timer.isActive) return;
//
//     // _timer = Timer(Duration(seconds: _waiTime), _triggerInternal);
//     _timer = Timer.periodic(Duration(seconds: _waiTime), (timer) {
//       _triggerInternal();
//       timer.cancel();
//     });
//   }
//
//   /// [_stopInternal] Cancel activity monitoring
//   /// Note: This method only works when monitoring is active
//   void _stopInternal() {
//     if (_timer != null) _timer!.cancel();
//
//     _timer = null;
//   }
//
//   /// restore timer [_updateTimeInternal]
//   /// from the timer reset it can also change the seconds
//   /// it must wait before triggering the [onTimeOut]
//   /// Note: This method only works when monitoring is active and seconds <= 30
//   void _updateTimeInternal({required int waiTime}) {
//     var timer = _timer;
//
//     if (timer == null || !timer.isActive) return;
//
//     _waiTime = waiTime;
//
//     _stopInternal();
//
//     _startInternal();
//   }
//
//   /// Restores activity monitoring [_resetInternal]
//   /// Note: This method only works when monitoring is active
//   void _resetInternal() {
//     if (_timer == null || _timer!.isActive) return;
//
//     _stopInternal();
//
//     _startInternal();
//   }
//
//   /// There are several reasons to trigger the [onTimeOut]
//   /// method before the stipulated timer [forceTimeOut]
//   void forceTimeOut() => _triggerInternal();
//
//   bool get isActive => _timer != null && _timer!.isActive;
// }
