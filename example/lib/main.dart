import 'package:activsy/activsy.dart';
import 'package:example/src/secure_page.dart';
import 'package:example/src/transactions_page.dart';
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
    await _globalKey.currentState!.pushNamed(SecurePage.route);
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
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case SecurePage.route:
                return MaterialPageRoute(builder: (_) => SecurePage());
              default:
                return MaterialPageRoute(builder: (_) => TransactionsPage());
            }
          },
        );
      },
    );
  }
}