import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SecurePage extends StatefulWidget {
  static const route = '/SecurePage';

  @override
  State<SecurePage> createState() => _SecurePageState();
}

class _SecurePageState extends State<SecurePage> {
  List<String> get NUMBERS =>
      const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', ''];

  String _pin = "- - - - - -";

  /// set up pin
  void setPin(String value) {
    if (value.isEmpty) return;

    var values = _pin.split('');

    var index = values.indexOf('-');

    if (index < 0) return;

    values[index] = value;

    setState(() => _pin = values.join());
    unlock();
  }

  void unlock() {
    if (_pin.contains('-')) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var items = NUMBERS;
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(height: 16.0),
              const Text('Set up PIN',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Expanded(
                  child: Center(
                child: Text(
                  _pin,
                  style: const TextStyle(fontSize: 50.0),
                ),
              )),
              const Text('You can use this PIN to unlock the app.'),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: StaggeredGrid.count(
                    axisDirection: AxisDirection.down,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: List.generate(
                      items.length,
                      (index) {
                        var item = items[index];
                        return StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: item.isEmpty
                                    ? Colors.transparent
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(90)),
                            child: MaterialButton(
                              onPressed: () => setPin(item),
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 24.0),
                              ),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
    );
  }
}
