import 'dart:async';

import 'package:dairy_newdeskapp/model/AdvanceRateAddResponse.dart';
import 'package:dairy_newdeskapp/model/AdvanceRateListResponse.dart';
import 'package:dairy_newdeskapp/model/DeleteAdvanceRateResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvanceRate extends StatefulWidget {
  @override
  AdvanceRateState createState() => AdvanceRateState();
}

class AdvanceRateState extends State<AdvanceRate> {
  int select, valueRadio;
  String dropdownValue = 'Select';
  String radioButtonItem = 'Fat Wise Rate';
  bool listFlag = true;
  TextEditingController rate_date = TextEditingController();
  TextEditingController rate_cattle = TextEditingController();
  TextEditingController min_fat = TextEditingController();
  TextEditingController max_fat = TextEditingController();
  TextEditingController min_snf = TextEditingController();
  TextEditingController max_snf = TextEditingController();
  TextEditingController kg_fat = TextEditingController();
  TextEditingController kg_snf = TextEditingController();
  TextEditingController rate_fat = TextEditingController();
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  AdvanceRateListResponse user1;
  List<int> _selected_box = List();
  var tmpArray = [];
  String s;
  var listdata1;
  bool resultvalue1 = true;
  int id = 1;
  List<String> spinnerItems = ['Select', 'Two', 'Three', 'Four', 'Five'];
  Timer timer;
  String date;
  int _userId;
  @override
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
    DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    date = formatted;
    rate_date.text = date;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      getAdvancrRate(_keyLoader, _userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Card(
          color: AppColors.accountbgcolor,
          elevation: 10,
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      top: 20, left: SizeConfig.blockSizeHorizontal * 1),
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            radioButtonItem = 'Fat Wise Rate';
                            id = 1;
                          });
                        },
                      ),
                      Text(
                        'Fat Wise Rate',
                        style: new TextStyle(
                            fontSize: 17.0,
                            color: AppColors.allaccounttextcolor),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 100),
                        child: Radio(
                          value: 2,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Fat Lactose Wise Rate';
                              id = 2;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Fat Lactose Wise Rate',
                        style: new TextStyle(
                            fontSize: 17.0,
                            color: AppColors.allaccounttextcolor),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 100),
                        child: Radio(
                          value: 3,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Fat Snf Wise Rate';
                              id = 3;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Fat Snf Wise Rate',
                        style: new TextStyle(
                            fontSize: 17.0,
                            color: AppColors.allaccounttextcolor),
                      ),
                    ],
                  )),
              Container(
                color: AppColors.lightGreenHeading,
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                margin: EdgeInsets.only(
                    top: 20,
                    left: SizeConfig.blockSizeHorizontal * 1,
                    right: SizeConfig.blockSizeHorizontal * 1),
                alignment: Alignment.topLeft,
                child: Text(
                  'Advance Rate',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: 20,
                      left: SizeConfig.blockSizeHorizontal * 1,
                      right: SizeConfig.blockSizeHorizontal * 1),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Date:',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      controller: rate_date,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Cattle',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      controller: rate_cattle,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'min Fat',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9.]")),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          try {
                                            final text = newValue.text;
                                            if (text.isNotEmpty)
                                              double.parse(text);
                                            return newValue;
                                          } catch (e) {}
                                          return oldValue;
                                        }),
                                      ],
                                      controller: min_fat,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'max Fat',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9.]")),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          try {
                                            final text = newValue.text;
                                            if (text.isNotEmpty)
                                              double.parse(text);
                                            return newValue;
                                          } catch (e) {}
                                          return oldValue;
                                        }),
                                      ],
                                      controller: max_fat,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'min SNF',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9.]")),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          try {
                                            final text = newValue.text;
                                            if (text.isNotEmpty)
                                              double.parse(text);
                                            return newValue;
                                          } catch (e) {}
                                          return oldValue;
                                        }),
                                      ],
                                      controller: min_snf,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'max SNF',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9.]")),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          try {
                                            final text = newValue.text;
                                            if (text.isNotEmpty)
                                              double.parse(text);
                                            return newValue;
                                          } catch (e) {}
                                          return oldValue;
                                        }),
                                      ],
                                      controller: max_snf,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'KG Fat',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9.]")),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          try {
                                            final text = newValue.text;
                                            if (text.isNotEmpty)
                                              double.parse(text);
                                            return newValue;
                                          } catch (e) {}
                                          return oldValue;
                                        }),
                                      ],
                                      controller: kg_fat,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'KG SNF',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9.]")),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          try {
                                            final text = newValue.text;
                                            if (text.isNotEmpty)
                                              double.parse(text);
                                            return newValue;
                                          } catch (e) {}
                                          return oldValue;
                                        }),
                                      ],
                                      controller: kg_snf,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Rate FAT',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true, signed: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9.]")),
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          try {
                                            final text = newValue.text;
                                            if (text.isNotEmpty)
                                              double.parse(text);
                                            return newValue;
                                          } catch (e) {}
                                          return oldValue;
                                        }),
                                      ],
                                      controller: rate_fat,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: AppColors.greyhint),
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 5,
                            margin: EdgeInsets.only(top: 30, bottom: 10),
                            alignment: Alignment.center,
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 18),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.greencolor,
                            ),
                          ),
                          onTap: () {
                            addMilkCollection(_keyLoader);
                          },
                        )
                      ],
                    ),
                  )),
              /* Container(
                child: Align(
                  child: Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 3,
                      ),
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 6,
                        child: Row(
                          children: <Widget>[
                            listFlag == true
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        // listFlag==false;
                                        listFlag = !listFlag;
                                      });
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              1,
                                        ),
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        height:
                                            SizeConfig.blockSizeVertical * 6,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assests/image/chart.png"),
                                                fit: BoxFit.fill))),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        // listFlag==true;
                                        listFlag = !listFlag;
                                      });
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              1,
                                        ),
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        height:
                                            SizeConfig.blockSizeVertical * 6,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assests/image/table.png"),
                                                fit: BoxFit.fill))),
                                  ),
                            Align(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeVertical * 90),
                                child: Text(
                                  'Export To',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  width: SizeConfig.blockSizeHorizontal * 8,
                                  height: SizeConfig.blockSizeVertical * 5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assests/image/pdf.png"),
                                          fit: BoxFit.fill))),
                            )
                          ],
                        ),
                      )),
                ),
              ),*/

              Container(
                child: Align(
                  child: Container(
                      child: Container(
                    margin: EdgeInsets.only(right: 30),
                    height: SizeConfig.blockSizeVertical * 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1),
                            width: SizeConfig.blockSizeHorizontal * 7,
                            height: SizeConfig.blockSizeVertical * 4,
                            alignment: Alignment.center,
                            child: Text(
                              'DELETE',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    10,
                                                width: SizeConfig
                                                        .blockSizeVertical *
                                                    40,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    children: <Widget>[
                                                      InkWell(
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              'Are you sure you want to delete'),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: () {
                                                              deleteEntry(
                                                                  _keyLoader,
                                                                  s);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  10,
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  5,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 20,
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'Yes',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: <
                                                                      Color>[
                                                                    Color(
                                                                        0xFF0D47A1),
                                                                    Color(
                                                                        0xFF0D47A1),
                                                                    Color(
                                                                        0xFF0D47A1),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  10,
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  5,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 20,
                                                                      left: 20),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'No',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: <
                                                                      Color>[
                                                                    Color(
                                                                        0xFFA10D0D),
                                                                    Color(
                                                                        0xFFA10D0D),
                                                                    Color(
                                                                        0xFFA10D0D),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        Align(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeVertical * 1),
                            child: Text(
                              'Export To',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: SizeConfig.blockSizeVertical * 2,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("Tapped on container");
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 1,
                                left: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              width: SizeConfig.blockSizeHorizontal * 8,
                              height: SizeConfig.blockSizeVertical * 6,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assests/image/cs.png"),
                                      fit: BoxFit.fill))),
                        ),
                        InkWell(
                          onTap: () {
                            print("Tapped on container");
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 1,
                                left: SizeConfig.blockSizeHorizontal * 1,
                              ),
                              width: SizeConfig.blockSizeHorizontal * 8,
                              height: SizeConfig.blockSizeVertical * 6,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assests/image/pdf.png"),
                                      fit: BoxFit.fill))),
                        )
                      ],
                    ),
                  )),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  width: SizeConfig.blockSizeHorizontal * 75,
                  height: SizeConfig.blockSizeVertical * 5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 5,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 1,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'DATE',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 3,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'Cattle',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 3,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'min FAT',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 5,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'max FAT',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 6,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'min SNF',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 6,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'max SNF',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 4,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'kG FAT',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 4,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'KG SNF',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 4,
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                          ),

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            'Rate FAT',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: (SizeConfig.blockSizeVertical * 1.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.allaccountbgcolor,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 0.3),
                      bottomRight:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 0.3),
                      topLeft:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 0.3),
                      topRight:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 0.3),
                    ),
                  )),
              listdata1 != null
                  ? Container(
                      width: SizeConfig.blockSizeHorizontal * 80,
                      height: SizeConfig.blockSizeVertical * 50,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ListView.builder(
                            itemCount:
                                listdata1.length == null ? 0 : listdata1.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: _selected_box.contains(index),
                                    //index is the position of the checkbox
                                    onChanged: (value) {
                                      setState(() {
                                        print("idsss====" +
                                            user1.data
                                                .elementAt(index)
                                                .id
                                                .toString());

                                        getCheckValues(index);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                      child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 5,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).date,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 4,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).cattle,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 2,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).minFat,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 6,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).maxFat,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 4,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).minSnf,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 7,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).maxSnf,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 5,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).kgFat,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 3,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).kgSnf,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 3,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 4,
                                    ),

                                    //   width: MediaQuery.of(context).size.width/2,
                                    child: Text(
                                      user1.data.elementAt(index).rateFat,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ))
                  : Container(
                      margin: EdgeInsets.only(top: 50, right: 100),
                      alignment: Alignment.center,
                      child: resultvalue1 == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(child: Text("No Data")),
                    )
            ],
          )),
        ),
      ),
    );
  }

  Future<void> deleteEntry(
      GlobalKey<State<StatefulWidget>> keyLoader, String user_id) async {
    final formData = {
      'id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/delete_advance_rate',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      DeleteAdvanceRateResponse user2 =
          DeleteAdvanceRateResponse.fromJson(responseData.data);
      setState(() {
        getAdvancrRate(_keyLoader, _userId);

        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user2.message)));
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);

      setState(() {
        //  resultvalue1 = false;
      });
    }
  }

  void getCheckValues(int index) {
    if (_selected_box.contains(index)) {
      _selected_box.remove(index);
      tmpArray.remove(user1.data.elementAt(index).id);
    } else {
      _selected_box.add(index);
      tmpArray.add(user1.data.elementAt(index).id);
    }

    print(tmpArray);

    s = tmpArray.join(',');

    print("new" + s);
  }

  Future<void> addMilkCollection(
      GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'user_id': _userId,
      'date': rate_date.text,
      'cattle': rate_cattle.text,
      'min_fat': min_fat.text,
      'max_fat': max_fat.text,
      'min_snf': min_snf.text,
      'max_snf': max_snf.text,
      'kg_fat': kg_fat.text,
      'kg_snf': kg_snf.text,
      'rate_fat': rate_fat.text,
      'fat_type': radioButtonItem,
    };

    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/fat_rate',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      AdvanceRateAddResponse user =
          AdvanceRateAddResponse.fromJson(responseData.data);
      if (user.status == 200) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));

        rate_cattle.text = '';
        min_fat.text = '';
        max_fat.text = '';
        min_snf.text = '';
        max_snf.text = '';
        kg_fat.text = '';
        kg_snf.text = '';
        rate_fat.text = '';
      }
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  Future<void> getAdvancrRate(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id, 'fat_type': radioButtonItem};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/fat_rate_list',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user1 = AdvanceRateListResponse.fromJson(responseData.data);
      setState(() {
        resultvalue1 = true;
        listdata1 = user1.data;
      });
    } catch (e) {
      setState(() {
        resultvalue1 = false;
      });
    }
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        message =
            _handleError(dioError.response.statusCode, dioError.response.data);
        break;
      case DioErrorType.SEND_TIMEOUT:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        /*  Fluttertoast.showToast(
          msg: 'The email has already been taken.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return 'Oops something went wrong';
      case 404:
        /* Fluttertoast.showToast(
          msg: error["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return error["message"];
      case 500:
        /* Fluttertoast.showToast(
          msg: 'Internal server error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return 'Internal server error';
      default:
        /* Fluttertoast.showToast(
          msg: 'Oops something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
