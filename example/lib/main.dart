import 'package:activsy/activsy.dart';
import 'package:example/src/authentication.dart';
import 'package:example/src/transactions.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();
  final int _waiTime = 3;

  void onEvent(dynamic _) {
    debugPrint('onEvent');
  }

  void onTimeOut() async {
    debugPrint('onTimeOut :)');
    await _globalKey.currentState!.pushNamed(AuthenticationPage.route);
    Activsy.start();
  }

  @override
  void initState() {
    super.initState();
    Activsy.initialize(waiTime: _waiTime, onTimeOut: onTimeOut);
    Activsy.start();
  }

  @override
  Widget build(BuildContext context) {
    return ActivsyWidget(
      withMouse: true,
      onEvent: onEvent,
      builder: (ctx) {
        return MaterialApp(
          title: 'Activsy',
          navigatorKey: _globalKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          onGenerateRoute: AppRouter.route,
        );
      },
    );
  }
}

abstract class AppRouter {
  static Route<dynamic> route(RouteSettings settings) {
    debugPrint("route:: ${settings.name}");
    switch (settings.name) {
      case AuthenticationPage.route:
        return MaterialPageRoute(builder: (_) => AuthenticationPage());
      default:
        return MaterialPageRoute(builder: (_) => TransactionsPage());
    }
  }
}
