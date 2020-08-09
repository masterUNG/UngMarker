import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext context, String _string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(_string),
      children: <Widget>[
        FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
      ],
    ),
  );
}
