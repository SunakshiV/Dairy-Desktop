import 'dart:async';
import 'dart:convert';
import 'package:dairy_newdeskapp/model/AddBonusResponse.dart';
import 'package:dairy_newdeskapp/model/BonusListResponse.dart';
import 'package:dairy_newdeskapp/model/DeleteMilkSaleResponse.dart';
import 'package:dairy_newdeskapp/model/EditBonus.dart';
import 'package:dairy_newdeskapp/model/GetFatResponse.dart';
import 'package:dairy_newdeskapp/model/GetVendorNameResponse.dart';
import 'package:dairy_newdeskapp/model/MilkSaleFilterGetResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class Bonus extends StatefulWidget {
  @override
  BonusState createState() => BonusState();
}

class BonusState extends State<Bonus> {
  int select, valueRadio;
  TimeOfDay selectedTime = TimeOfDay.now();
  String dropdownValue = 'Select';
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  final dateController2 = TextEditingController();
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  int _userId;
  var listdata1;
  bool resultvalue1 = true;
  MilkSaleFilterGetResponse user2;
  var listdata2;
  bool resultvalue2 = true;
  var dltid;
  int weight;
  int amount;
  int rate;
  BonusListResponse user1;
  String type = 'normal';
  double percent = 0.0;
  Timer timer;
  String textValue;
  Timer timeHandle;
  String textValuefat;
  Timer timeHandlefat;
  String textValueweight;
  Timer timeHandleweight;
  List<int> _selected_box = List();
  var tmpArray = [];
  String s;


  final cmf = FocusNode();
  final cowunit = FocusNode();
  final cowcost = FocusNode();
  final bmf = FocusNode();
  final bufunit = FocusNode();
  final bufcost = FocusNode();

  int pageNumber = 1;
  int totalPage = 1;
  bool isLoading = false;
  static ScrollController _listViewController;
  String val;
  @override
  void dispose() {
    _listViewController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Future<void> initState() {
    _listViewController = new ScrollController()..addListener(function);
    super.initState();
    Controllers.milk_vendor_name.text = '';
    Controllers.milk_cattletype.text = '';
    Controllers.b_cow_min_fat.text = '';
    Controllers.b_cow_per_unit.text = '';
    Controllers.b_cow_cost.text = '';
    Controllers.b_buf_min_fat.text = '';
    Controllers.b_buf_per_unit.text = '';
    Controllers.b_buf_cost.text = '';

    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _loadID());
  }

  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      print(_userId);
      if (type == 'normal') {
        getSubMilkCollections(_userId,pageNumber);
        paginationApi();
      } else {
        getFilterList(
            _keyLoader, dateController.text, dateController1.text, _userId);
      }
    });
  }

  void textChanged(String val) {
    textValue = val;
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () {
      print("Calling now the API: $textValue");
      getVedorName(_keyLoader, textValue);
    });
  }

  void textChangedFat(String val) {
    textValuefat = val;
    if (timeHandlefat != null) {
      timeHandlefat.cancel();
    }
    timeHandlefat = Timer(Duration(seconds: 1), () {
      print("Calling now the API: $textValuefat");
      getCattle(_keyLoader, textValuefat);
    });
  }

  void textChangedWeight(String val) {
    textValueweight = val;
    if (timeHandleweight != null) {
      timeHandleweight.cancel();
    }
    timeHandleweight = Timer(Duration(seconds: 1), () {
      setState(() {
        print("Calling now the API: $textValueweight");
        amount = int.parse(textValueweight) * rate;
        print("rate: " + amount.toString());
        Controllers.milk_amount.text = amount.toString();
      });
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    Container(
                      color: AppColors.lightGreenHeading,
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          top: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Bonus',
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 0.5,
                            right: SizeConfig.blockSizeHorizontal * 1),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      //   width: MediaQuery.of(context).size.width/2,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Cow min fat',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            focusNode: cmf,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(cowunit);
                                            },
                                            controller: Controllers.b_cow_min_fat,
                                            keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true,
                                                signed: false),
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
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: 'type here',
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Per Unit',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            focusNode: cowunit,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(cowcost);
                                            },
                                            controller:
                                                Controllers.b_cow_per_unit,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: 'type here',
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Cost',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            focusNode: cowcost,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(bmf);
                                            },
                                            controller: Controllers.b_cow_cost,
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
                                                    color: AppColors.greyhint),
                                                labelText: '',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      //   width: MediaQuery.of(context).size.width/2,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Buf min fat',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            focusNode: bmf,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(bufunit);
                                            },
                                            controller: Controllers.b_buf_min_fat,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true,
                                                signed: false),
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
                                            decoration: InputDecoration(
                                                labelText: 'type here',
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Per Unit',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            focusNode: bufunit,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(bufcost);
                                            },
                                            controller:
                                                Controllers.b_buf_per_unit,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: 'type here',
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Cost',
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            focusNode: bufcost,

                                            controller: Controllers.b_buf_cost,
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
                                                    color: AppColors.greyhint),
                                                labelText: '',
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
                                  margin: EdgeInsets.only(top: 10),
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
                                  if (_formKey.currentState.validate()) {
                                    Dialogs.showLoadingDialog(
                                        context, _keyLoader);
                                    addMilkCollection(_keyLoader);
                                  }
                                },
                              )
                            ],
                          ),
                        )),
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
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
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        child: Column(
                                                          children: <Widget>[
                                                            InkWell(
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    'Are you sure you want to delete'),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                InkWell(
                                                                  onTap: () {
                                                                    deleteEntry(
                                                                        _keyLoader,
                                                                        s);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        10,
                                                                    height:
                                                                        SizeConfig.blockSizeVertical *
                                                                            5,
                                                                    margin:
                                                                        EdgeInsets
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
                                                                          BorderRadius.circular(
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
                                                                  child:
                                                                      Container(
                                                                    width: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        10,
                                                                    height:
                                                                        SizeConfig.blockSizeVertical *
                                                                            5,
                                                                    margin: EdgeInsets.only(
                                                                        top: 20,
                                                                        left:
                                                                            20),
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
                                                                          BorderRadius.circular(
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
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _launchURL();
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
                                            image: AssetImage(
                                                "assests/image/cs.png"),
                                            fit: BoxFit.fill))),
                              ),
                              InkWell(
                                onTap: () {
                                _launchPdfURL();
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
                        width: SizeConfig.blockSizeHorizontal * 80,
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        height: SizeConfig.blockSizeVertical * 60,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    width: SizeConfig.blockSizeHorizontal * 75,
                                    height: SizeConfig.blockSizeVertical * 5,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: <Widget>[
                                          /*  Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),
                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),*/
                                          /* Container(
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
                                          ),*/
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    8,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'cow min fat',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'cow per unit',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'cow cost',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'buf min fat',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'buf per unit',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'buf cost',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
                                                    1.3),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'ACTION',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: (SizeConfig
                                                        .blockSizeVertical *
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
                                            SizeConfig.blockSizeHorizontal *
                                                0.3),
                                        bottomRight: Radius.circular(
                                            SizeConfig.blockSizeHorizontal *
                                                0.3),
                                        topLeft: Radius.circular(
                                            SizeConfig.blockSizeHorizontal *
                                                0.3),
                                        topRight: Radius.circular(
                                            SizeConfig.blockSizeHorizontal *
                                                0.3),
                                      ),
                                    )),
                                type == "normal"
                                    ? listdata1 != null
                                        ? Container(
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    80,
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    50,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: ListView.builder(
                                                controller: _listViewController,
                                                  itemCount:
                                                      listdata1.length == null
                                                          ? 0
                                                          : listdata1.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Row(
                                                      children: [
                                                        Checkbox(
                                                          value: _selected_box
                                                              .contains(index),
                                                          //index is the position of the checkbox
                                                          onChanged: (value) {
                                                            setState(() {
                                                              print("idsss====" +
                                                                  user1.paginateData.data
                                                                      .elementAt(
                                                                          index)
                                                                      .id
                                                                      .toString());

                                                              getCheckValues(
                                                                  index);
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

                                                        SizedBox(
                                                            child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              8,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .cow,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    (SizeConfig
                                                                            .blockSizeVertical *
                                                                        1.3),
                                                                letterSpacing:
                                                                    1.0),
                                                          ),
                                                        )),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              10,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .cowPerUnit,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    (SizeConfig
                                                                            .blockSizeVertical *
                                                                        1.3),
                                                                letterSpacing:
                                                                    1.0),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              10,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .cowCost,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    (SizeConfig
                                                                            .blockSizeVertical *
                                                                        1.3),
                                                                letterSpacing:
                                                                    1.0),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              10,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .buff,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    (SizeConfig
                                                                            .blockSizeVertical *
                                                                        1.3),
                                                                letterSpacing:
                                                                    1.0),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              10,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .buffPerUnit,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    (SizeConfig
                                                                            .blockSizeVertical *
                                                                        1.3),
                                                                letterSpacing:
                                                                    1.0),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              10,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .buffCost,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize:
                                                                    (SizeConfig
                                                                            .blockSizeVertical *
                                                                        1.3),
                                                                letterSpacing:
                                                                    1.0),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Container(
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  4,
                                                              height: SizeConfig
                                                                      .blockSizeVertical *
                                                                  3,
                                                              margin: EdgeInsets.only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1.5),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'EDIT',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: AppColors
                                                                          .yellow),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            print( user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .id);
                                                            nextscreen( user1.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .id);
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }),
                                            ))
                                        : Container(
                                            margin: EdgeInsets.only(
                                                top: 50, right: 100),
                                            alignment: Alignment.center,
                                            child: resultvalue1 == true
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Center(
                                                    child: Text("No Data")),
                                          )
                                    : type == "filter"
                                        ? listdata2 != null
                                            ? Container(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    80,
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    50,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: ListView.builder(
                                                      itemCount: listdata2
                                                                  .length ==
                                                              null
                                                          ? 0
                                                          : listdata2.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Row(
                                                          children: [
                                                            Radio(
                                                              activeColor:
                                                                  AppColors
                                                                      .lightBlue,
                                                              value: index,
                                                              groupValue:
                                                                  select,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  valueRadio =
                                                                      index;
                                                                  select =
                                                                      value;

                                                                  print(user2
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .id
                                                                      .toString());
                                                                  dltid = user2
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .id;
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

                                                            SizedBox(
                                                                child:
                                                                    Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  6,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .date,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            )),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  5,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .time,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  3,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .shift,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  7,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .cattleType,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  6,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .vendorNumber,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  7,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .vendorName,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  6,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .fat,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  4,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .weight,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  5,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .rate,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  6,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),

                                                              //   width: MediaQuery.of(context).size.width/2,
                                                              child: Text(
                                                                user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .amount,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        (SizeConfig.blockSizeVertical *
                                                                            1.3),
                                                                    letterSpacing:
                                                                        1.0),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    Container(
                                                                  width: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      4,
                                                                  height: SizeConfig
                                                                          .blockSizeVertical *
                                                                      3,
                                                                  margin: EdgeInsets.only(
                                                                      left: SizeConfig
                                                                              .blockSizeHorizontal *
                                                                          1.5),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    'EDIT',
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color:
                                                                              AppColors.yellow),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                print(user2.data
                                                                    .elementAt(
                                                                        index)
                                                                    .id);
                                                                nextscreen(user2
                                                                    .data
                                                                    .elementAt(
                                                                        index)
                                                                    .id);
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      }),
                                                ))
                                            : Container()
                                        : Container(),
                              ],
                            )))
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void getCheckValues(int index) {
    if (_selected_box.contains(index)) {
      _selected_box.remove(index);
      tmpArray.remove( user1.paginateData.data.elementAt(index).id);
    } else {
      _selected_box.add(index);
      tmpArray.add( user1.paginateData.data.elementAt(index).id);
    }

    print(tmpArray);

    s = tmpArray.join(',');

    print("new" + s);
  }

  Future<void> addMilkCollection(
      GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'cow': Controllers.b_cow_min_fat.text,
      'cow_per_unit': Controllers.b_cow_per_unit.text,
      'cow_cost': Controllers.b_cow_cost.text,
      'buff': Controllers.b_buf_min_fat.text,
      'buff_per_unit': Controllers.b_buf_per_unit.text,
      'buff_cost': Controllers.b_buf_cost.text,
      'user_id': _userId
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/addbonus',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      AddBonusResponse user = AddBonusResponse.fromJson(responseData.data);
      if (user.status == 200) {
        getMilkCollections( _userId,pageNumber);
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(responseData.data);
        Controllers.b_cow_min_fat.text = '';
        Controllers.b_cow_per_unit.text = '';
        Controllers.b_cow_cost.text = '';
        Controllers.cow1_min_snf.text = '';
        Controllers.cow1_per_unit.text = '';
        Controllers.cow1_cost.text = '';
        Controllers.b_buf_min_fat.text = '';
        Controllers.b_buf_per_unit.text = '';
        Controllers.b_buf_cost.text = '';
        Controllers.buf1_min_snf.text = '';
        Controllers.buf1_per_unit.text = '';
        Controllers.buf1_cost.text = '';
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
      print(errorMessage);
    }
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
          '/api/deletebonus',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      DeleteMilkSaleResponse user2 =
          DeleteMilkSaleResponse.fromJson(responseData.data);
      setState(() {
        getMilkCollections(_userId,pageNumber);

        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user2.message)));
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);

      setState(() {
        resultvalue1 = false;
      });
    }
  }



  void paginationApi() {
    _listViewController.addListener(() {
      if (_listViewController.offset >= _listViewController.position.maxScrollExtent &&
          !_listViewController.position.outOfRange) {
        setState(() {
          if (pageNumber <user1.paginateData.lastPage ) {
            pageNumber += 1;
            getMilkCollections(_userId, pageNumber);
          }

        });
      }
      if (_listViewController.offset <= _listViewController.position.minScrollExtent &&
          !_listViewController.position.outOfRange) {
        setState(() {
          if(pageNumber>=1)
          {
            pageNumber=  pageNumber-1;
            if (pageNumber <user1.paginateData.lastPage ) {
              getSubMilkCollections(_userId, pageNumber);
            }
          }
          else{
            getSubMilkCollections(_userId,pageNumber);
          }
        });
      }
    });
  }

  void getMilkCollections(int user_id,int page) async {
    Map data = {
      'user_id': user_id.toString(),
      'page':page.toString()
    };
    print("Darta: "+data.toString());

    Dialogs.showLoadingDialog(context, _keyLoader);
    var jsonResponse = null;
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/bonuslist", body: data);
    if (response.statusCode == 200)
    {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {
        print("Json User: " + jsonResponse.toString());

        user1 = new BonusListResponse.fromJson(jsonResponse);
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(user1.paginateData.data.isEmpty)
            {
              resultvalue1 = false;
            }
            else
            {
              resultvalue1 = true;
              print("SSSS");
              listdata1 = user1.paginateData.data;
            }
          });
        }
        else {
          print("SSSS1234");
        }
      } else {
        setState(() {
          resultvalue1 = false;
        });

      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    }
  }


  void getSubMilkCollections(int user_id,int page) async {
    Map data = {
      'user_id': user_id.toString(),
      'page':page.toString()
    };
    print("Darta: "+data.toString());


    var jsonResponse = null;
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/bonuslist", body: data);
    if (response.statusCode == 200)
    {

      jsonResponse = json.decode(response.body);

      val = response.body;
      if (jsonResponse["status"] == 200) {
        print("Json User: " + jsonResponse.toString());

        user1 = new BonusListResponse.fromJson(jsonResponse);
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(user1.paginateData.data.isEmpty)
            {
              resultvalue1 = false;
            }
            else
            {
              resultvalue1 = true;
              print("SSSS");
              listdata1 = user1.paginateData.data;
            }
          });
        }
        else {
          print("SSSS1234");
        }
      } else {
        setState(() {
          resultvalue1 = false;
        });

      }
    } else {


    }
  }


  Future<void> getVedorName(
      GlobalKey<State<StatefulWidget>> keyLoader, String vendor_code) async {
    final formData = {
      'vendor_code': vendor_code,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/milkunit1',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetVendorNameResponse user1 = GetVendorNameResponse.fromJson(responseData.data);

      if (user1.status == 200) {
        setState(() {
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user1.message)));
          Controllers.milk_vendor_name.text = user1.data.elementAt(0).vendorName;
          Controllers.milk_rate.text = user1.data.elementAt(0).rate;
          rate = int.parse(user1.data.elementAt(0).rate);
          //calculate(int.parse(user1.data.elementAt(0).rate));
        });
      }
      else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        Controllers.milk_vendor_name.text = '';
      }
    } catch (e) {
      Controllers.milk_vendor_name.text = '';
      final errorMessage = DioExceptions1.fromDioError(e, context);
      print("-----" + errorMessage.toString());
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;

        Controllers.milk_time.text =
            selectedTime.hour.toString() + ':' + selectedTime.minute.toString();
      });
  }

  Future<void> getCattle(
      GlobalKey<State<StatefulWidget>> keyLoader, String vendor_code) async {
    final formData = {
      'fat': vendor_code,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/milkunit2',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetFatResponse user1 = GetFatResponse.fromJson(responseData.data);

      if (user1.status == 200) {
        setState(() {
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user1.message)));
          Controllers.milk_cattletype.text = user1.data.elementAt(0).cattle;
        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        Controllers.milk_cattletype.text = '';
      }
    } catch (e) {
      Controllers.milk_cattletype.text = '';
      final errorMessage = DioExceptions1.fromDioError(e, context);
      print("-----" + errorMessage.toString());
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  void nextscreen(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditBonus(id)),
    );
  }

  void calculate(int rateval) {
    rate = rateval;
    weight = int.parse(Controllers.milk_weight.text.toString());
  }

  Future<void> getFilterList(GlobalKey<State<StatefulWidget>> keyLoader,
      String text, String text2, int userId) async {
    print(text);
    print(text2);
    print(userId);

    final formData = {
      'from': text,
      'to': text2,
      'user_id': userId,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/milksalesfilter',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user2 = MilkSaleFilterGetResponse.fromJson(responseData.data);
      setState(() {
        type = 'filter';
        resultvalue2 = true;
        listdata2 = user2.data;
        print("amo" + user2.data.length.toString());
        print("amo------" + responseData.data.toString());
      });
    } catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e);
      /* Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));*/
      setState(() {
        resultvalue2 = false;
      });
    }
  }

  void function() {
  }


  _launchPdfURL() async {
    String url =
        'https://shankraresearch.com/bonus/' + _userId.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  _launchURL() async {
    String url =
        'http://shankraresearch.com/bonusExcel'+_userId.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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

class DioExceptions1 implements Exception {
  DioExceptions1.fromDioError(DioError dioError, BuildContext context1) {
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
  String _handleError(BuildContext context1, int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        Scaffold.of(context1).showSnackBar(new SnackBar(content: new Text('')));
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
