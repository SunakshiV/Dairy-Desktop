import 'dart:async';
import 'dart:convert';

import 'package:dairy_newdeskapp/model/AddMilkCollectionResponse.dart';
import 'package:dairy_newdeskapp/model/DeleteMilkSaleResponse.dart';
import 'package:dairy_newdeskapp/model/DispatchFilterGetResponse.dart';
import 'package:dairy_newdeskapp/model/DispatchListResponse.dart';
import 'package:dairy_newdeskapp/model/GetFatResponse.dart';
import 'package:dairy_newdeskapp/model/GetFatValueResponse.dart';
import 'package:dairy_newdeskapp/model/GetVendorNameResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'EditDispatch.dart';
import 'package:get/get.dart';

class Dispatch extends StatefulWidget {
  @override
  DispatchState createState() => DispatchState();
}

class DispatchState extends State<Dispatch> {
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

  DispatchFilterGetResponse user2;
  var listdata2;
  bool resultvalue2 = true;
  var dltid;
  int weight;
  int amount;
  int rate;
  DispatchListResponse user1;
  String type = 'normal';
  double percent = 0.0;
  Timer timer;
  List<int> _selected_box = List();
  var tmpArray = [];
  String s;
  var time, date;
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
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _loadID());
  }

  _loadID() async {
    DateTime now = DateTime.now();
    final format = DateFormat.jm();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    print(formatted);
    date = formatted;
    time = format.format(now);

    print("----date" + date);
    print("----time" + time);
    Controllers.milk_time.text = time;
    Controllers.milk_date.text = date;
    if (Controllers.milk_time.text.contains("AM"))
      Controllers.milk_shift.text = 'Morning';
    else
      Controllers.milk_shift.text = 'Evening';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);

      print(_userId);

      getFat(_keyLoader, _userId);
      getSnf(_keyLoader, _userId);
      getClr(_keyLoader, _userId);
      if (type == 'normal') {
        getSubMilkCollections(_userId,pageNumber);
        paginationApi();
      } else {
        getFilterList(
            _keyLoader, dateController.text, dateController1.text, _userId);
      }
    });
  }

  String textValue;
  Timer timeHandle;
  String textValuefat;
  Timer timeHandlefat;

  String textValueweight;
  Timer timeHandleweight;

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
                          top: SizeConfig.blockSizeHorizontal * 1,
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'dispatch'.tr,
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
                                            'date'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        InkWell(
                                          child: Container(
                                              height: 40,
                                              margin: EdgeInsets.all(10),
                                              alignment: Alignment.topLeft,
                                              child: GestureDetector(
                                                  child: new IgnorePointer(
                                                    child: TextFormField(
                                                      enableInteractiveSelection:
                                                      false,
                                                      readOnly: true,
                                                      controller:
                                                      Controllers.milk_date,
                                                      decoration: InputDecoration(
                                                          labelText: '',
                                                          hoverColor:
                                                          AppColors.lightBlue,
                                                          border:
                                                          OutlineInputBorder()),
                                                    ),
                                                  ))),
                                        )
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
                                            'time'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        InkWell(
                                          child: Container(
                                              height: 40,
                                              margin: EdgeInsets.all(10),
                                              alignment: Alignment.topLeft,
                                              child: GestureDetector(
                                                  child: new IgnorePointer(
                                                    child: TextFormField(
                                                      enableInteractiveSelection:
                                                      false,
                                                      readOnly: true,
                                                      controller:
                                                      Controllers.milk_time,
                                                      decoration: InputDecoration(
                                                          labelText: '',
                                                          hoverColor:
                                                          AppColors.lightBlue,
                                                          border:
                                                          OutlineInputBorder()),
                                                    ),
                                                  ))),
                                        )
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
                                            'vendorcode'.tr,
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
                                            onChanged: textChanged,
                                            controller: Controllers.dairy_code,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: 'type here',
                                                labelStyle: TextStyle(
                                                    color: AppColors.greyhint),
                                                hoverColor: AppColors.lightBlue,
                                                border: OutlineInputBorder()),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'Enter Dairy Code';
                                              }
                                              return null;
                                            },
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
                                            'avgfat'.tr,
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
                                            readOnly: true,
                                            controller: Controllers.avg_fat,
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
                                            'avgsnf'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: Controllers.avg_snf,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
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
                                            'avgclr'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: Controllers.avg_clr,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
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
                                            'rate'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            controller:
                                            Controllers.dispatch_rate,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
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
                                            'weight'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            controller:
                                            Controllers.dispatch_weight,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
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
                                            'noofcans'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            controller:
                                            Controllers.dispatch_no_cans,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
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
                                      margin:
                                      EdgeInsets.only(top: 10, left: 90),
                                      width:
                                      SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'amount'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            controller:
                                            Controllers.dispatch_amount,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
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
                                      margin:
                                      EdgeInsets.only(top: 10, left: 90),
                                      width:
                                      SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'quantity'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 40,
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            controller:
                                            Controllers.dispatch_quantity,
                                            textAlignVertical:
                                            TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
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
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'save'.tr,
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
                                        'delete'.tr,
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
                                                                        'sure'.tr),
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
                                                                          'yes'.tr,
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
                                                                          'no'.tr,
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
                                        'exportto'.tr,
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
                                                6,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'date'.tr,
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
                                                4,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'time'.tr,
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
                                                6,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'vendorcode'.tr,
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
                                                4,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'avgfat'.tr,
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
                                                4,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'avgsnf'.tr,
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
                                                4,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'avgclr'.tr,
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
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'rate'.tr,
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
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'weight'.tr,
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
                                                6,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'noofcans'.tr,
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
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'amount'.tr,
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
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'quantity'.tr,
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
                                                5,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                  .blockSizeHorizontal *
                                                  2,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'action'.tr,
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
                                                          6,
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
                                                            .date,
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
                                                      5,
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
                                                        .time,
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
                                                      4,
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
                                                        .dairyCode,
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
                                                      6,
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
                                                        .avgFat,
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
                                                      3,
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
                                                        .avgSnf,
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
                                                      5,
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
                                                        .avgClr,
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
                                                      4,
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
                                                        .rate,
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
                                                      5,
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
                                                        .weight,
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
                                                      6,
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
                                                        .noOfCans,
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
                                                      6,
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
                                                        .amount,
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
                                                      4,
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
                                                        .quantity,
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
                                                        'edit'.tr,
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
                                                        .dairyCode,
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
                                                        .avgFat,
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
                                                      2,
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
                                                        .avgSnf,
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
                                                        .avgClr,
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
                                                /*  Container(
                                                  alignment:
                                                  Alignment.center,
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3,
                                                  margin: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                  ),

                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  child: Text(
                                                    user2.data
                                                        .elementAt(index)
                                                        .snf,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color:
                                                        AppColors.black,
                                                        fontSize: (SizeConfig
                                                            .blockSizeVertical *
                                                            1.3),
                                                        letterSpacing: 1.0),
                                                  ),
                                                ),*/
                                                /*  Container(
                                                  alignment:
                                                  Alignment.center,
                                                  width: SizeConfig
                                                      .blockSizeHorizontal *
                                                      5,
                                                  margin: EdgeInsets.only(
                                                    left: SizeConfig
                                                        .blockSizeHorizontal *
                                                        1,
                                                  ),

                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  child: Text(
                                                    user2.data
                                                        .elementAt(index)
                                                        .clr,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color:
                                                        AppColors.black,
                                                        fontSize: (SizeConfig
                                                            .blockSizeVertical *
                                                            1.3),
                                                        letterSpacing: 1.0),
                                                  ),
                                                ),*/
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
                                                        .noOfCans,
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
                                                        .quantity,
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
                                                        'edit'.tr,
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



  Future<void> getFat(
      GlobalKey<State<StatefulWidget>> keyLoader, int userid) async {
    final formData = {
      'user_id': userid,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/dislist',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetFatValueResponse user1 =
      GetFatValueResponse.fromJson(responseData.data);
      if (user1.status == 200) {
        setState(() {
          Controllers.avg_fat.text = user1.data;

        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));

      }
    } catch (e) {
      Controllers.avg_fat.text = '';
      final errorMessage = DioExceptions1.fromDioError(e, context);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }




  Future<void> getSnf(
      GlobalKey<State<StatefulWidget>> keyLoader, int userid) async {
    final formData = {
      'user_id': userid,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/dislist2',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetFatValueResponse user1 =
      GetFatValueResponse.fromJson(responseData.data);
      if (user1.status == 200) {
        setState(() {


          Controllers.avg_snf.text =
              user1.data;

        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));

      }
    } catch (e) {
      Controllers.avg_snf.text = '';
      final errorMessage = DioExceptions1.fromDioError(e, context);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }



  Future<void> getClr(
      GlobalKey<State<StatefulWidget>> keyLoader, int userid) async {
    final formData = {
      'user_id': userid,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/dislist3',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetFatValueResponse user1 =
      GetFatValueResponse.fromJson(responseData.data);
      if (user1.status == 200) {
        setState(() {


          Controllers.avg_clr.text =
              user1.data;

        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));

      }
    } catch (e) {
      Controllers.avg_clr.text = '';
      final errorMessage = DioExceptions1.fromDioError(e, context);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
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
      GetVendorNameResponse user1 =
      GetVendorNameResponse.fromJson(responseData.data);
      if (user1.status == 200) {
        setState(() {
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user1.message)));

          Controllers.milk_vendor_name.text =
              user1.data.elementAt(0).vendorName;
          Controllers.dispatch_rate.text = user1.data.elementAt(0).rate;
          rate = int.parse(user1.data.elementAt(0).rate);
        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        Controllers.milk_vendor_name.text = '';
      }
    } catch (e) {
      Controllers.milk_vendor_name.text = '';
      final errorMessage = DioExceptions1.fromDioError(e, context);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }


  Future<void> addMilkCollection(
      GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'date': Controllers.milk_date.text,
      'time': Controllers.milk_time.text,
      'dairy_code': Controllers.dairy_code.text,
      'avg_fat': Controllers.avg_fat.text,
      'avg_snf': Controllers.avg_snf.text,
      'avg_clr': Controllers.avg_clr.text,
      'rate': Controllers.dispatch_rate.text,
      'weight': Controllers.dispatch_weight.text,
      'no_of_cans': Controllers.dispatch_no_cans.text,
      'amount': Controllers.dispatch_amount.text,
      'quantity': Controllers.dispatch_quantity.text,
      'user_id': _userId
    };
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/adddispatch',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      AddMilkCollectionResponse user =
      AddMilkCollectionResponse.fromJson(responseData.data);
      if (user.status == 200) {
        getMilkCollections(_userId,pageNumber);
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(responseData.data);

        dateController2.text = '';
        Controllers.milk_time.text = Controllers.dairy_code.text = '';
        Controllers.avg_fat.text = '';
        Controllers.avg_snf.text = '';
        Controllers.avg_clr.text = '';
        Controllers.dispatch_rate.text = '';
        Controllers.dispatch_weight.text = '';
        Controllers.dispatch_no_cans.text = '';
        Controllers.dispatch_amount.text = '';
        Controllers.dispatch_quantity.text = '';
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
    print("idssss" + user_id.toString());
    final formData = {
      'id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/deletedispatch',
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
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/dispatch_list", body: data);
    if (response.statusCode == 200)
    {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {
        print("Json User: " + jsonResponse.toString());

        user1 = new DispatchListResponse.fromJson(jsonResponse);
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
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/dispatch_list", body: data);
    if (response.statusCode == 200)
    {

      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {
        print("Json User: " + jsonResponse.toString());

        user1 = new DispatchListResponse.fromJson(jsonResponse);
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
      MaterialPageRoute(builder: (context) => EditDispatch(id)),
    );
  }

  void calculate(int rateval) {
    rate = rateval;
    weight = int.parse(Controllers.milk_weight.text.toString());

    //amount = (weight) * (rate);
    print("weight: " + weight.toString());
    print("amount: " + amount.toString());

    // print("rate: "+func(rate, weight).toString());
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
          '/api/dispatchfilter',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user2 = DispatchFilterGetResponse.fromJson(responseData.data);
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
        'http://shankraresearch.com/dispatches/' + _userId.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  _launchURL() async {
    String url =
        'http://shankraresearch.com/dispatchExcel'+_userId.toString();
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
        Scaffold.of(context1).showSnackBar(new SnackBar(
            content: new Text("Email does't found on our database")));
        return 'Email does not found on our database';
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
