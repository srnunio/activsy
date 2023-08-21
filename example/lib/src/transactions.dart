import 'dart:math';

import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  static const route = '/TransactionsPage';

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final ScrollController _controller = ScrollController();

  List<Map<String, dynamic>> _items = [];

  Map<String, dynamic> createItem() {
    var amount = Random().nextInt(5000);
    var received = (amount % 2) == 0;
    var color = (received) ? Colors.green : Colors.red;
    var status = (Random().nextInt(2) == 0) ? 'Accepted' : 'Rejected';
    return {'amount': amount, 'color': color, 'status': status};
  }

  void fetchData() async {
    await Future.delayed(const Duration(milliseconds: 300));

    var list = List.generate(15, (index) => createItem()).toList();
    setState(() => _items.addAll(list));
  }

  Widget _bodyList() {
    return ListView.separated(
        controller: _controller,
        itemCount: _items.length,
        separatorBuilder: (ctx, index) => const SizedBox(height: 10.0),
        itemBuilder: (ctx, index) {
          var item = _items[index];
          return Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: item['color'],
                  size: 32.0,
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Payment n°:${index + 1}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 2.0),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "\$${item['amount']}",
                          style: const TextStyle(fontSize: 14.0, color: Colors.grey)),
                      const TextSpan(
                          text: " • ",
                          style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                      TextSpan(
                          text: "${item['status']}",
                          style: const TextStyle(fontSize: 14.0, color: Colors.grey))
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

    Future.delayed(const Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('This application will be blocked after 3 '
              'seconds without user interaction ')));
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
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(child: _bodyList())
        ],
      ),
    );
  }
}
