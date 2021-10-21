import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends StatefulWidget {
  @override
  LanguageState createState() => LanguageState();
}

class LanguageState extends State<Language> {
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
                              'language'.tr,
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
                              title: "English",
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
                              title: "Hindi",
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
                              title: "Gujarati",
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
                              title: "Marathi",
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
                              title: "Telugu",
                              value: 4,
                              onChanged: (newValue) => setState(() =>
                                  setWindowSize4(newValue)
                              ),
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
    var locale=Locale('en','US');
    Get.updateLocale(locale);

  }

  void setWindowSize1(newValue) {
    _groupValue = newValue;
    var locale=Locale('hi','IN');
    Get.updateLocale(locale);
  }

  void setWindowSize2(newValue) {
    _groupValue = newValue;
    var locale=Locale('gu','IN');
    Get.updateLocale(locale);
  }

  void setWindowSize3(newValue) {
    _groupValue = newValue;
    var locale=Locale('mr','IN');
    Get.updateLocale(locale);
  }
  void setWindowSize4(newValue) {
    _groupValue = newValue;
    var locale=Locale('te','IN');
    Get.updateLocale(locale);
  }
}


