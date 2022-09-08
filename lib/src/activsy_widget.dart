import 'package:activsy/activsy.dart';
import 'package:flutter/widgets.dart';

class ActivsyWidget extends StatelessWidget {
  /// [builder]  principal widget
  final Widget Function(BuildContext) builder;

  /// [detectedMouseAction] enable/disable mouse detector
  final bool detectedMouseAction;

  ActivsyWidget({required this.builder, this.detectedMouseAction = false})
      : assert(Activsy.isInitialized, 'activsy no initialized');

  /// sets up the widget to be shown [_builder]
  Widget _builder(BuildContext context) {
    // checks whether mouse event holding has been enabled
    if (detectedMouseAction) {
      return MouseRegion(
        child: builder(context),
        onEnter: (_) => Activsy.reset(),
        onHover: (_) => Activsy.reset(),
        onExit: (_) => Activsy.reset(),
      );
    }
    return builder(context);
  }

  /// Here we hear all the events of gestures in our application
  /// Whenever any gesture event is detected the wait time and restarted
  @override
  Widget build(BuildContext context) => Listener(
        child: _builder(context),
        onPointerDown: (_) => Activsy.reset(),
        onPointerUp: (_) => Activsy.reset(),
        onPointerSignal: (_) => Activsy.reset(),
        onPointerMove: (_) => Activsy.reset(),
        onPointerCancel: (_) => Activsy.reset(),
        onPointerHover: (_) => Activsy.reset(),
      );
}
