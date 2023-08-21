import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:activsy/activsy.dart';

void main() {

  test('initializeTest', () async {
    Activsy.initialize(waiTime: 3, onTimeOut: ()=> debugPrint("onTimeOut"));

    Activsy.start();

    await Future.delayed(const Duration(seconds: 5));
  });

  test('when not initialized', () async {
    Activsy.start();
  });
}
