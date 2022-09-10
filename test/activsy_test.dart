import 'package:flutter_test/flutter_test.dart';

import 'package:activsy/activsy.dart';

void main() {
  void noActivity() {
    print('noActivity called');
  }

  test('start monitor', () async {
    Activsy.config(seconds: 2, noActivity: noActivity);

    Activsy.start();
    Activsy.reset(seconds: 8);
    Activsy.trigger();

    await Future.delayed(Duration(seconds: 3));
  });

  test('no initialize failure', () async {
    Activsy.start();
  });
}
