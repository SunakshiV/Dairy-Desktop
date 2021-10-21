import 'dart:async';

import 'package:dairy_newdeskapp/ui/HomeScreen.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUser extends StatefulWidget {
  @override
  EditUserState createState() => EditUserState();
}

class EditUserState extends State<EditUser> {
  int select, valueRadio;
  String radioButtonItem = 'Item Purchase';

  // Group Value for Radio Button.
  int id = 1;
  Timer timer;
  SharedPreferences prefs;
  Future<void> initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _loadID());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  _loadID() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: SizeConfig.blockSizeHorizontal * 100,
          decoration: BoxDecoration(color: AppColors.homeblluebg),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              'Edit User',
                              style: TextStyle(
                                  color: AppColors.allaccounttextcolor,
                                  fontSize: 18),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (route) => false);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10, top: 40),
                              alignment: Alignment.center,
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    color: AppColors.blueDark, fontSize: 18),
                              ),
                            ),
                          )
                        ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 70),
                        //   width: MediaQuery.of(context).size.width/2,
                        child: Column(children: <Widget>[
                          Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              alignment: Alignment.center,
                              child: Image.asset('assests/image/exit.png')),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
