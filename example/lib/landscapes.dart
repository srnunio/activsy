import 'package:flutter/material.dart';

class LandscapesPage extends StatefulWidget {
  @override
  State<LandscapesPage> createState() => _LandscapesPageState();
}

class _LandscapesPageState extends State<LandscapesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landscapes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
