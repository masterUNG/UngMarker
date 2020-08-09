import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ungmarker/models/user_model.dart';

class Cash extends StatefulWidget {
  final UserModel userModel;
  Cash({Key key, this.userModel}) : super(key: key);

  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  String dateTimeString;
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userModel = widget.userModel;

    findDataTime();
  }

  void findDataTime() {
    DateTime dateTime = DateTime.now();

    dateTimeString = DateFormat('dd-MM-yyyy').format(dateTime);
    print('dateTimeString = $dateTimeString');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: buildTitleAppBar(),
        actions: <Widget>[
          Row(
            children: [
              Text('User: ${userModel.username}'),
              SizedBox(
                width: 16,
              ),
              Text(userModel.fullname),
            ],
          ),
          IconButton(
            tooltip: 'Exit To APP',
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              exit(0);
            },
          )
        ],
      ),
    );
  }

  Widget buildTitleAppBar() => Column(
        children: [
          Text('Arale Cash'),
          Text(
            dateTimeString,
            style: TextStyle(fontSize: 16),
          ),
        ],
      );
}
