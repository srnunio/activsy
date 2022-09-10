import 'dart:math';

import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  static const route = '/TransactionsPage';

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  ScrollController _controller = ScrollController();

  List<Map<String, dynamic>> _items = [];

  Map<String, dynamic> createItem() {
    var amount = Random().nextInt(5000);
    var received = (amount % 2) == 0;
    var color = (received) ? Colors.green : Colors.red;
    var status = (Random().nextInt(2) == 0) ? 'Accepted' : 'Rejected';
    return {'amount': amount, 'color': color, 'status': status};
  }

  void fetchData() async {
    await Future.delayed(Duration(milliseconds: 300));

    var list = List.generate(15, (index) => createItem()).toList();
    setState(() => _items.addAll(list));
  }

  Widget _bodyList() {
    return ListView.separated(
        controller: _controller,
        itemCount: _items.length,
        separatorBuilder: (ctx, index) {
          return SizedBox(
            height: 10.0,
          );
        },
        itemBuilder: (ctx, index) {
          var item = _items[index];
          return Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: item['color'],
                  size: 32.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Payment n°:${index + 1}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "\$${item['amount']}",
                          style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                      TextSpan(
                          text: " • ",
                          style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                      TextSpan(
                          text: "${item['status']}",
                          style: TextStyle(fontSize: 14.0, color: Colors.grey))
                    ]))
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'This application will be blocked after 10 seconds without user interaction ')));
    });

    _controller.addListener(() {
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent - 50) {
        fetchData();
      }
    });

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(child: _bodyList())
        ],
      ),
    );
  }
}
