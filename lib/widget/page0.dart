import 'package:flutter/material.dart';

class Page0 extends StatefulWidget {
  @override
  _Page0State createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ขายสินค้า'),
      ),
      body: Column(
        children: [
          buildAddButton(),
          Text('body'),
          Text('body'),
          Text('body'),
          Text('body'),
          Text('body'),
          Text('body'),
        ],
      ),
    );
  }

  Widget buildAddButton() => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.add_circle), onPressed: null),
          IconButton(icon: Icon(Icons.remove_circle), onPressed: null),
        ],
      );
}
