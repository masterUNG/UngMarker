import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmarker/models/user_model.dart';
import 'package:ungmarker/utility/my_constant.dart';
import 'package:ungmarker/utility/normal_dialog.dart';
import 'package:ungmarker/widget/cash.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              buildText(),
              buildTextFieldUser(),
              buildTextFieldPassword(),
              buildOutlineButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOutlineButton() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 200,
        child: OutlineButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () {
            print('user = $user, password = $password');

            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'Please Fill Every Blank');
            } else {
              checkAuthen();
            }
          },
          child: Text('Login'),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/Aimee/getUserWhereUser.php?isAdd=true&Username=$user';
    print('url ==>> $url');

    await Dio().get(url).then((value) {
      if (value.toString() == 'null') {
        normalDialog(context, 'ไม่มี $user ใน ฐานข้อมูลของเรา');
      } else {
        print('value = $value');
        var result = json.decode(value.data);
        print('result = $result');
        for (var map in result) {
          print('map = $map');
          UserModel model = UserModel.fromJson(map);
          if (password == model.password) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Cash(
                    userModel: model,
                  ),
                ),
                (route) => false);
          } else {
            normalDialog(context, 'Password False Please Try Again');
          }
        }
      }
    }).catchError(() {});
  }

  Widget buildTextFieldUser() => Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.pink),
            suffixIcon: Icon(
              Icons.account_box,
              color: Colors.pink,
            ),
            labelText: 'User :',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
        ),
      );

  Widget buildTextFieldPassword() => Container(
        width: 250,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.lock),
            labelText: 'Password :',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      );

  Text buildText() => Text(
        'อึ่ง Marker',
        style: GoogleFonts.sriracha(
            textStyle: TextStyle(
          fontSize: 24,
          color: Colors.pink.shade800,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        )),
      );

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/logo.png'),
    );
  }
}
