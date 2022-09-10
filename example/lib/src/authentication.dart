import 'package:flutter/material.dart';
import 'package:pin_code_view/pin_code_view.dart';

class AuthenticationPage extends StatefulWidget {
  static const route = '/AuthenticationPage';

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  String _pin = '';

  void setPin(String value) {
    setState(() {
      _pin = value;
    });

    if (_pin.length < 6) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Authentication'),
          elevation: 0.0,
          automaticallyImplyLeading: false),
      body: WillPopScope(
        child: PinCode(
          title: "Set up PIN",
          subtitle: "You can use this PIN to unlock the app.",
          keyboardType: KeyboardType.numeric,
          onChange: setPin,
          obscurePin: true,
        ),
        onWillPop: () => Future.value(false),
      ),
    );
  }
}
