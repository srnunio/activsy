import 'package:activsy/activsy.dart';
import 'package:example/src/authentication.dart';
import 'package:example/src/transactions.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();
  final int _seconds = 10;

  void onEvent(dynamic _) {
    print('onEvent');
  }

  void noActivity() async {
    print('noActivity called :)');
    await _globalKey.currentState!.pushNamed(AuthenticationPage.route);
    Activsy.start();
  }

  @override
  void initState() {
    super.initState();
    Activsy.config(seconds: _seconds, noActivity: noActivity).init();
  }

  @override
  Widget build(BuildContext context) {
    return ActivsyWidget(
      detectedMouseAction: false,
      onEvent: onEvent,
      builder: (ctx) {
        return MaterialApp(
          title: 'Activsy',
          navigatorKey: _globalKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: TransactionsPage.route,
          onGenerateRoute: AppRouter.route,
          home: TransactionsPage(),
        );
      },
    );
  }
}

abstract class AppRouter {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case TransactionsPage.route:
        return MaterialPageRoute(builder: (_) => TransactionsPage());

      case AuthenticationPage.route:
        return MaterialPageRoute(builder: (_) => AuthenticationPage());
      default:
        return MaterialPageRoute(builder: (_) => TransactionsPage());
    }
  }
}
