import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Resolution extends StatefulWidget {
  @override
  ResolutionState createState() => ResolutionState();
}

class ResolutionState extends State<Resolution> {
  int _groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          height: SizeConfig.blockSizeHorizontal * 100,
          color: AppColors.white,
          width: double.infinity,

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(

                  child: Row(
                    children: <Widget>[
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,

                        child: Row(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Display Resolution',
                              style: TextStyle(
                                  color: AppColors.allaccounttextcolor,
                                  fontSize: 18),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 40),



                        child: Row(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.black),
                            ),
                            width: SizeConfig.blockSizeHorizontal * 20,
                            child: _myRadioButton(
                              title: "1920 * 1080",
                              value: 0,
                              onChanged: (newValue) => setState(() =>
                            //  _groupValue = newValue,

                              setWindowSize(newValue)
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.black),
                            ),
                            width: SizeConfig.blockSizeHorizontal * 20,
                            child: _myRadioButton(
                              title: "1680 * 1050",
                              value: 1,
                              onChanged: (newValue) =>
                                  setState(() =>

                                      setWindowSize1(newValue)


                              ),
                            ),
                          ),

                        ]
                        ),
                      ),

                    ],
                  ),
                ),
                Container(

                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 40),

                        child: Row(children: <Widget>[
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.black),
                            ),
                            child: _myRadioButton(
                              title: "1600 * 900",
                              value: 2,
                              onChanged: (newValue) => setState(() =>
                                  setWindowSize2(newValue)
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            width: SizeConfig.blockSizeHorizontal * 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.black),
                            ),
                            child: _myRadioButton(
                              title: "1440 * 900",
                              value: 3,
                              onChanged: (newValue) => setState(() =>
                                  setWindowSize3(newValue)),
                            ),
                          ),

                        ]
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }

  void setWindowSize(newValue) {
    _groupValue = newValue;
     DesktopWindow.setMinWindowSize(Size(1920, 1080));
  }

  void setWindowSize1(newValue) {
    _groupValue = newValue;
    DesktopWindow.setMinWindowSize(Size(1680, 1050));
  }

  void setWindowSize2(newValue) {
    _groupValue = newValue;
    DesktopWindow.setMinWindowSize(Size(1600, 900));
  }

  void setWindowSize3(newValue) {
    _groupValue = newValue;
    DesktopWindow.setMinWindowSize(Size(1440, 900));
  }
}


/*
Expanded(
flex: 1,
child: RadioListTile(
value: 0,
groupValue: _groupValue,
title: Text("Male"),
onChanged: (newValue) =>
setState(() => _groupValue = newValue),
activeColor: Colors.red,
selected: false,
),
),
Expanded(
flex: 1,
child: RadioListTile(
value: 1,
groupValue: _groupValue,
title: Text("Female"),
onChanged: (newValue) =>
setState(() => _groupValue = newValue),
activeColor: Colors.red,
selected: false,
),
),*/
