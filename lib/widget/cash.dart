import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmarker/models/user_model.dart';
import 'package:ungmarker/utility/my_constant.dart';
import 'package:ungmarker/widget/authen.dart';

class Cash extends StatefulWidget {
  final UserModel userModel;
  Cash({Key key, this.userModel}) : super(key: key);

  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  String dateTimeString;
  UserModel userModel;

  List<IconData> iconDatas = [
    Icons.shopping_cart,
    Icons.addchart,
    Icons.account_box,
    Icons.alarm,
    Icons.assignment,
    Icons.settings
  ];

  List<String> titles = [
    'ขายสินค้า',
    'สรุป',
    'หมวดหมู่',
    'สินค้า',
    'Password',
    'Setup'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // userModel = widget.userModel;
    findUserLogin();

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
      body: Column(
        children: [
          buildTitle(),
          buildCash(),
          buildDivider(),
          buildCatigory(),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: buildTitleAppBar(),
        actions: <Widget>[
          Row(
            children: [
              Text(userModel == null ? '' : 'User: ${userModel.username}'),
              SizedBox(
                width: 16,
              ),
              Text(userModel == null ? '' : userModel.fullname),
            ],
          ),
          IconButton(
            tooltip: 'Exit To APP',
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // exit(0);

              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authen(),
                  ),
                  (route) => false);
            },
          )
        ],
      ),
    );
  }

  List<Widget> createCards() {
    List<Widget> lists = List();

    int index = 0;
    for (var title in titles) {
      Widget widget = Card();
      lists.add(widget);
      index++;
    }

    return lists;
  }

  Widget buildCatigory() => GridView.extent(shrinkWrap: true,
        physics: ScrollPhysics(),
        maxCrossAxisExtent: 200,
        children: createCards(),
      );

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Divider(
        thickness: 2.0,
        color: Colors.black45,
      ),
    );
  }

  Widget buildCash() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '5000',
            style: TextStyle(fontSize: 30),
          ),
        ],
      );

  Widget buildTitle() => Container(
        margin: EdgeInsets.only(top: 16, left: 8),
        child: Row(
          children: [
            Text('ยอดขายวันนี้ :'),
          ],
        ),
      );

  Widget buildTitleAppBar() => Column(
        children: [
          Text('Arale Cash'),
          Text(
            dateTimeString,
            style: TextStyle(fontSize: 16),
          ),
        ],
      );

  Future<Null> findUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('Username');
    String url =
        '${MyConstant().domain}/Aimee/getUserWhereUser.php?isAdd=true&Username=$user';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    for (var map in result) {
      setState(() {
        userModel = UserModel.fromJson(map);
      });
    }
  }
}
