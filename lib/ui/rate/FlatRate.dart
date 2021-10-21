import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dairy_newdeskapp/model/AddRateResponse.dart';
import 'package:dairy_newdeskapp/model/GetAccountsResponse.dart';
import 'package:dairy_newdeskapp/model/GetRateResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlatRate extends StatefulWidget {
  @override
  FlatRateState createState() => FlatRateState();
}

class FlatRateState extends State<FlatRate> {
  int select, valueRadio;
  String dropdownValue = 'Select';
  List<charts.Series> seriesList;
  List<String> spinnerItems = ['Select', 'Two', 'Three', 'Four', 'Five'];
  bool listFlag = true;
  var checkedValue = false;
  var checkedValue1 = false;
  var checkedValue2 = false;
  var checkedValue3 = false;
  int _userId;
  var listdata1;
  var listdata2;
  bool resultvalue1 = true;
  bool resultvalue2 = true;
  final _formKey = GlobalKey<FormState>();
  var rateid;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  GetRateResponse user1;
  GetAccountsResponse user2;
  List<int> _selected_box = List();
  var tmpArray = [];
  Future<void> initState() {
    super.initState();
    _loadID();
  }

  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      Dialogs.showLoadingDialog(context, _keyLoader);
      getRates(_keyLoader);
      getAccounts(_keyLoader, _userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Card(
          color: AppColors.accountbgcolor,
          elevation: 10,
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: AppColors.lightGreenHeading,
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                      margin: EdgeInsets.only(
                          top: 20,
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Flat Rate',
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 10,
                            left: SizeConfig.blockSizeHorizontal * 1,
                            right: SizeConfig.blockSizeHorizontal * 1),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      //   width: MediaQuery.of(context).size.width/2,

                                      width:
                                          SizeConfig.blockSizeHorizontal * 12,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Rate',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            controller: Controllers.flatrate,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: AppColors.black),
                                                labelText: 'enter rate',
                                                hoverColor: AppColors.lightBlue,
                                                border: OutlineInputBorder()),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'Enter Rate';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ]),
                                    ),
                                    InkWell(
                                      child: Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 8,
                                        height:
                                            SizeConfig.blockSizeVertical * 5,
                                        margin:
                                            EdgeInsets.only(top: 20, left: 10),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '+ADD',
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 15),
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.blueDark,
                                        ),
                                      ),
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          Dialogs.showLoadingDialog(
                                              context, _keyLoader);
                                          addRates(_keyLoader);

                                          // TODO submit
                                        }
                                      },
                                    )

                                    /* Checkbox(
                                value: this.checkedValue1,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkedValue1 = value;
                                  });
                                },
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 12,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Rate-2:',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.white,
                                    margin: EdgeInsets.all(10),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: AppColors.black),
                                          labelText: 'type here',
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Checkbox(
                                value: this.checkedValue2,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkedValue2 = value;
                                  });
                                },
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 12,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Rate-3:',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.white,
                                    margin: EdgeInsets.all(10),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: AppColors.black),
                                          labelText: 'type here',
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Checkbox(
                                value: this.checkedValue3,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkedValue3 = value;
                                  });
                                },
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 12,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Rate-4:',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.white,
                                    margin: EdgeInsets.all(10),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: AppColors.black),
                                          labelText: 'type here',
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    listdata1 != null
                        ? Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            margin: EdgeInsets.only(top: 30),
                            child: GridView.builder(
                                shrinkWrap: true,
                                //  physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 2,
                                ),
                                itemCount: listdata1.length == null
                                    ? 0
                                    : listdata1.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height:
                                            SizeConfig.blockSizeVertical * 10,
                                        child: Row(
                                          children: [
                                            Radio(
                                              activeColor: AppColors.lightBlue,
                                              value: index,
                                              groupValue: select,
                                              onChanged: (value) {
                                                setState(() {
                                                  valueRadio = index;
                                                  select = value;
                                                  rateid = user1.data
                                                      .elementAt(index)
                                                      .id;
                                                });
                                              },
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    //   width: MediaQuery.of(context).size.width/2,

                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        12,
                                                    child: Column(children: <
                                                        Widget>[
                                                      Container(
                                                        margin:
                                                            EdgeInsets.only(),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          'Rate',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: TextField(
                                                          readOnly: true,
                                                          controller:
                                                              TextEditingController()
                                                                ..text = user1
                                                                    .data
                                                                    .elementAt(
                                                                        index)
                                                                    .rate
                                                                    .toString(),
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .top,
                                                          textAlign:
                                                              TextAlign.left,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                                  labelStyle: TextStyle(
                                                                      color: AppColors
                                                                          .black),
                                                                  // labelText:user1.data.elementAt(0).rate.toString(),
                                                                  hoverColor:
                                                                      AppColors
                                                                          .lightBlue,
                                                                  border:
                                                                      OutlineInputBorder()),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),

                                                  /* Checkbox(
                                value: this.checkedValue1,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkedValue1 = value;
                                  });
                                },
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 12,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Rate-2:',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.white,
                                    margin: EdgeInsets.all(10),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: AppColors.black),
                                          labelText: 'type here',
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Checkbox(
                                value: this.checkedValue2,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkedValue2 = value;
                                  });
                                },
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 12,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Rate-3:',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.white,
                                    margin: EdgeInsets.all(10),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: AppColors.black),
                                          labelText: 'type here',
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),
                              Checkbox(
                                value: this.checkedValue3,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkedValue3 = value;
                                  });
                                },
                              ),
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 12,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Rate-4:',
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.white,
                                    margin: EdgeInsets.all(10),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: AppColors.black),
                                          labelText: 'type here',
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                              ),*/
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );

                                  /*  child:   Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Radio(
                                        activeColor:
                                        AppColors.lightBlue,
                                        value: index,
                                        groupValue: select,
                                        onChanged: (value) {
                                          setState(() {
                                            valueRadio = index;
                                            select = value;
                                          });
                                        },
                                      ),
                                      */ /* Container(

                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),

                                              child: Text(
                                                a.toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontFamily:
                                                          'Poppins-Normal',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                      letterSpacing: 1.0),
                                                ),
                                              ),*/ /*


                                      Container(
                                        //   width: MediaQuery.of(context).size.width/2,
                                        width: SizeConfig.blockSizeHorizontal * 12,
                                        child:
                                        Column(children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 10, left: 10),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Rate-4:',
                                              style: TextStyle(
                                                  color: AppColors.black, fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                            color: AppColors.white,
                                            margin: EdgeInsets.all(10),
                                            height: SizeConfig.blockSizeVertical * 5,
                                            alignment: Alignment.topLeft,
                                            child: TextField(
                                              textAlignVertical: TextAlignVertical.top,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                  labelStyle:
                                                  TextStyle(color: AppColors.black),
                                                  labelText: 'type here',
                                                  hoverColor: AppColors.lightBlue,
                                                  border: OutlineInputBorder()),
                                            ),
                                          ),
                                        ]),
                                      ),


                                    ],
                                  ),*/
                                }),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 50, right: 100),
                            alignment: Alignment.center,
                            child: resultvalue1 == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(child: Text("No Data")),
                          ),
                    InkWell(
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 8,
                        height: SizeConfig.blockSizeVertical * 5,
                        margin: EdgeInsets.only(top: 30, bottom: 10, left: 500),
                        alignment: Alignment.center,
                        child: Text(
                          'SAVE',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.greencolor,
                        ),
                      ),
                      onTap: () {
                        print("Tapped on container");
                        Scaffold.of(context).showSnackBar(
                            new SnackBar(content: new Text("Added")));
                      },
                    ),
                    Container(
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
                                              print(listFlag);
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                              ),
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  10,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      6,
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
                                              print(listFlag);
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                              ),
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  10,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      6,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assests/image/table.png"),
                                                      fit: BoxFit.fill))),
                                        ),
                                  Align(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeVertical *
                                              90),
                                      child: Text(
                                        'Export To',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize:
                                              SizeConfig.blockSizeVertical * 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("Tapped on container");
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              1,
                                        ),
                                        width:
                                            SizeConfig.blockSizeHorizontal * 8,
                                        height:
                                            SizeConfig.blockSizeVertical * 5,
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
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 76,
                      margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 0.5,
                        top: SizeConfig.blockSizeVertical * 2,
                        right: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 76,
                              height: SizeConfig.blockSizeVertical * 5,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
                                      ),
                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),
                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'SR NO.',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'CODE',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 20,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'NAME',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 24,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'RATE',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 20,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 2,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'ACTION',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize:
                                              (SizeConfig.blockSizeVertical *
                                                  1.3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.allaccountbgcolor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                  bottomRight: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                  topLeft: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                  topRight: Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    listdata2 != null
                        ? Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            height: SizeConfig.blockSizeVertical * 60,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ListView.builder(
                                  itemCount: listdata2.length == null
                                      ? 0
                                      : listdata2.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: _selected_box.contains(
                                              index), //index is the position of the checkbox
                                          onChanged: (value) {
                                            setState(() {
                                              // remove or add index to _selected_box

                                              getCheckValues(index);
                                            });
                                          },
                                        ),

                                        /* Container(

                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),

                                              child: Text(
                                                a.toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontFamily:
                                                          'Poppins-Normal',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                      letterSpacing: 1.0),
                                                ),
                                              ),*/

                                        Container(
                                          alignment: Alignment.center,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: SelectableText(
                                            '',
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                                letterSpacing: 1.0),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  13,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: SelectableText(
                                            user2.paginateData.data
                                                .elementAt(index)
                                                .vendorCode,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                                letterSpacing: 1.0),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  21,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            user2.paginateData.data
                                                .elementAt(index)
                                                .vendorName,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                                letterSpacing: 1.0),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  23,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            user2.paginateData.data.elementAt(index).rate,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                                letterSpacing: 1.0),
                                          ),
                                        ),
                                        InkWell(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      3,
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1.5),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'EDIT',
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 15),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: AppColors.yellow),
                                            ),
                                          ),
                                          onTap: () {
                                            print(
                                                user2.paginateData.data.elementAt(index).id);
                                          },
                                        )
                                      ],
                                    );
                                  }),
                            ))
                        : Container(
                            margin: EdgeInsets.only(top: 50, right: 100),
                            alignment: Alignment.center,
                            child: resultvalue2 == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(child: Text("No Data")),
                          ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Future<void> addRates(GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'rate': Controllers.flatrate.text,
      'user_id': _userId,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>('/api/addrate',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      AddRateResponse user = AddRateResponse.fromJson(responseData.data);
      if (user.status == 200) {
        Dialogs.showLoadingDialog(context, _keyLoader);
        getRates(_keyLoader);
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Controllers.flatrate.text = '';
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(responseData.data);
      } else if (user.status == 400) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Controllers.flatrate.text = '';
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(responseData.data);
      }
    } catch (e) {
      Controllers.flatrate.text = '';
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e, context);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
      print(errorMessage);
    }
  }

  Future<void> getRates(GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'user_id': _userId,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/ratelist',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      user1 = GetRateResponse.fromJson(responseData.data);
      if (user1.status == 200) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        print(responseData.data);
        setState(() {
          resultvalue1 = true;
          listdata1 = user1.data;
          print(user1.data.elementAt(0).rate);
        });
      } else if (user1.status == 400) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        print(responseData.data);
      }
    } catch (e) {
      Controllers.flatrate.text = '';
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e, context);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
      print(errorMessage);
    }
  }

  Future<void> getAccounts(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {
      'user_id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/account_list',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user2 = GetAccountsResponse.fromJson(responseData.data);
      setState(() {
        resultvalue2 = true;
        listdata2 = user2.paginateData.data;
        print("klk" + listdata2.length.toString());
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e, context);

      setState(() {
        resultvalue1 = false;
      });
    }
  }

  void getCheckValues(int index) {
    if (_selected_box.contains(index)) {
      _selected_box.remove(index);
      tmpArray.remove(user2.paginateData.data.elementAt(index).vendorCode);
    } else {
      _selected_box.add(index);
      tmpArray.add(user2.paginateData.data.elementAt(index).vendorCode);
    }

    print(tmpArray);
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError, BuildContext context1) {
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
        message = _handleError(
            context1, dioError.response.statusCode, dioError.response.data);
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

  String _handleError(BuildContext context2, int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return '';
      case 404:
        /* Fluttertoast.showToast(
          msg: error["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return error["message"];
      case 500:
        /*  Fluttertoast.showToast(
          msg: 'Internal server error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return 'Internal server error';
      default:
        /*   Fluttertoast.showToast(
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

class ChartsDemo extends StatefulWidget {
  //
  ChartsDemo() : super();

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //
  List<charts.Series> seriesList;

  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      Sales('2015', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.red)),
      Sales('2016', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.blue)),
      Sales('2017', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.green)),
      Sales('2018', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.pinkAccent)),
      Sales('2019', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.purple)),
      Sales('2020', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.brown)),
      Sales('2021', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.yellow)),
      Sales('2017', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.green)),
      Sales('2018', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.pinkAccent)),
      Sales('2019', random.nextInt(100),
          charts.ColorUtil.fromDartColor(Colors.purple)),
    ];
    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (Sales series, _) => series.color,
      )
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 1.0,
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: barChart(),
      ),
    );
  }
}

class Sales {
  final String year;
  final int sales;
  final charts.Color color;

  Sales(
    this.year,
    this.sales,
    this.color,
  );
}
