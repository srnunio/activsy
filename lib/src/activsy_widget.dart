import 'package:activsy/activsy.dart';
import 'package:flutter/widgets.dart';

class ActivsyWidget extends StatelessWidget {
  /// [builder]  principal widget
  final Widget Function(BuildContext) builder;

  final Function(PointerEvent)? onEvent;

  /// [withMouse] enable/disable mouse detector
  final bool withMouse;

  ActivsyWidget(
      {Key? key, required this.builder, this.withMouse = false, this.onEvent})
      : assert(Activsy.isInitialized, () {
          throw FlutterError(
              'activsy no initialized.\nMust call the Activsy.initialize() before the ActivsyWidget');
        }()),
        super(key: key);

  /// [_onEvent] notify when has event
  void _onEvent(PointerEvent event) {
    Activsy.reset();
    if (onEvent != null && Activsy.isActive) onEvent!(event);
  }

  /// sets up the widget to be shown [_builder]
  Widget _builder(BuildContext context) {
    // checks whether mouse event holding has been enabled
    if (withMouse) {
      return MouseRegion(
        child: builder(context),
        onEnter: _onEvent,
        onHover: _onEvent,
        onExit: _onEvent,
      );
    }
    return builder(context);
  }

  /// Here we hear all the events of gestures in our application
  /// Whenever any gesture event is detected the wait time and restarted
  @override
  Widget build(BuildContext context) {
    return Listener(
      child: _builder(context),
      onPointerDown: _onEvent,
      onPointerUp: _onEvent,
      onPointerSignal: _onEvent,
      onPointerMove: _onEvent,
      onPointerCancel: _onEvent,
      onPointerHover: _onEvent,
    );
  }
}
