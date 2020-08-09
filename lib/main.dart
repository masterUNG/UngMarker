import 'package:flutter/material.dart';
import 'package:ungmarker/widget/authen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authen(),title: 'Ung Market',
    );
  }
}
