import 'package:dairy_newdeskapp/ui/HomeScreen.dart';
import 'package:dairy_newdeskapp/utils/LocaleString.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _userId;

  @override
  Future<void> initState() {
    super.initState();
    setState(() {
      _loadID();
    });
  }

  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      print("login user id" + _userId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: LocaleString(),
        locale: Locale('en','US'),
        home: Scaffold(
            body: HomeScreen()));
  }
}
