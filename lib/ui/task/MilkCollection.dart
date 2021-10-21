import 'dart:async';
import 'dart:convert';

import 'package:dairy_newdeskapp/model/AddMilkCollectionResponse.dart';
import 'package:dairy_newdeskapp/model/AddToFvrtResponse.dart';
import 'package:dairy_newdeskapp/model/GetAnalyze.dart';
import 'package:dairy_newdeskapp/model/GetAnalyzeResponse.dart';
import 'package:dairy_newdeskapp/model/GetFatResponse.dart';
import 'package:dairy_newdeskapp/model/GetSavedWeight.dart';
import 'package:dairy_newdeskapp/model/GetVendorNameResponse.dart';
import 'package:dairy_newdeskapp/model/GetWeightReponse.dart';
import 'package:dairy_newdeskapp/model/MilkCollcetionFilterGetResponse.dart';
import 'package:dairy_newdeskapp/model/MilkCollcetionGetResponse.dart';
import 'package:dairy_newdeskapp/ui/task/DeleteMilkResponse.dart';
import 'package:dairy_newdeskapp/ui/task/EditMilkCollection.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
class
MilkCollection extends StatefulWidget {
  @override
  MilkCollectionState createState() => MilkCollectionState();
}

class MilkCollectionState extends State<MilkCollection> {
  int select, valueRadio;
  TimeOfDay selectedTime = TimeOfDay.now();
  String dropdownValue = 'Select';
  final CLRFocus = FocusNode();
  final WeightFocus = FocusNode();
  final VendorFocus = FocusNode();
  final FatFocus = FocusNode();
  final SNFFocus = FocusNode();
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  final dateController2 = TextEditingController();
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  int _userId;
  var listdata1;
  bool resultvalue1 = true;
  List<int> _selected_box = List();
  MilkCollcetionFilterGetResponse user2;
  var listdata2;
  bool resultvalue2 = true;
  var dltid;
  int weight;
  int amount;
  int rate;
  MilkCollcetionGetResponse requestpojo;
  String type = 'normal';
  double percent = 0.0;
  Timer timer;
  var time, date;
  var tmpArray = [];
  String weightValue;
  List<String> spinnerItems = ['kg'.tr, 'l'.tr,];
  AddMilkCollectionResponse user;
  String dropdownValueSpinner;
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
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _loadID());
  }

  _loadID() async {
    getWeightValue(_keyLoader, _userId);
    getAnalyzValue(_keyLoader, _userId);

    DateTime now = DateTime.now();
    final format = DateFormat.jm();
    final DateFormat formatter = DateFormat('dd-MM-yyy');
    final String formatted = formatter.format(now);
    date = formatted;
    time = format.format(now);

    Controllers.milk_time.text = time;
    Controllers.milk_date.text = date;
    if (Controllers.milk_time.text.contains("AM"))
      Controllers.milk_shift.text = 'Morning';
    else
      Controllers.milk_shift.text = 'Evening';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
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
  String s;

  void textChanged(String val) {
    textValue = val;
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () {
      getVedorName(_keyLoader, textValue);
    });
  }

  void textChangedFat(String val) {
    textValuefat = val;
    if (timeHandlefat != null) {
      timeHandlefat.cancel();
    }
    timeHandlefat = Timer(Duration(seconds: 1), () {
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
        amount = int.parse(textValueweight) * rate;
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
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 1,
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      color: AppColors.lightGreenHeading,
                      child:  Row(
                        children: <Widget>[
                          Container(
                            padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'milkcollection'.tr,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                          ),

                          Container(
                            padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                            alignment: Alignment.topLeft,
                              child:FavoriteButton(
                              iconSize: 4,
                              isFavorite: true,
                              // iconDisabledColor: Colors.white,
                               valueChanged: (_isFavorite) {
                                addFvrt(_isFavorite);
                              },
                            ),
                          ),
                        ],
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
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            controller: Controllers.milk_date,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                labelText: '',
                                                labelStyle: TextStyle(
                                                    color: AppColors.greyhint),
                                                hoverColor: AppColors.lightBlue,
                                                border: OutlineInputBorder()),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return '';
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
                                            'time'.tr,
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
                                            controller: Controllers.milk_time,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                labelText: '',
                                                labelStyle: TextStyle(
                                                    color: AppColors.greyhint),
                                                hoverColor: AppColors.lightBlue,
                                                border: OutlineInputBorder()),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return '';
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
                                            'shift'.tr,
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
                                            controller: Controllers.milk_shift,
                                            readOnly: true,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelText: '',
                                                labelStyle: TextStyle(
                                                    color: AppColors.greyhint),
                                                hoverColor: AppColors.lightBlue,
                                                border: OutlineInputBorder()),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'Enter Shift';
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
                                            'cattletype'.tr,
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
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller:
                                                Controllers.milk_cattletype,
                                            readOnly: true,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: AppColors.black),
                                                labelText: 'cattle',
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
                                            'vendorcode'.tr,
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
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: textChanged,
                                            controller:
                                                Controllers.milk_vendor_Code,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            focusNode: VendorFocus,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(FatFocus);
                                            },
                                            decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: AppColors.black),
                                                labelText: '',
                                                hoverColor: AppColors.lightBlue,
                                                border: OutlineInputBorder()),
                                            /*  validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'Enter Vendor Code';
                                              }
                                              return null;
                                            },*/
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
                                            'vendorname'.tr,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextField(
                                            controller:
                                                Controllers.milk_vendor_name,
                                            readOnly: true,
                                            textAlignVertical:
                                                TextAlignVertical.top,
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
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'fat'.tr,
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
                                            onChanged: textChangedFat,
                                            controller: Controllers.milk_fat,
                                            focusNode: FatFocus,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(SNFFocus);
                                            },
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
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
                                            'snf'.tr,
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
                                            focusNode: SNFFocus,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(CLRFocus);
                                            },
                                            controller: Controllers.milk_snf,
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
                                            'clr'.tr,
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
                                            controller: Controllers.milk_clr,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            focusNode: CLRFocus,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(WeightFocus);
                                            },
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
                                    weightValue == null
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                top: 20, left: 10, right: 20),
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    4,
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: dropdownValueSpinner,
                                              icon: Icon(Icons.arrow_drop_down),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                              onChanged: (String data) {
                                                setState(() {
                                                  dropdownValueSpinner = data;
                                                });
                                              },
                                              items: spinnerItems.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                top: 20, left: 10, right: 20),
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    4,
                                            child: Container(),
                                          ),
                                    Container(
                                      //   width: MediaQuery.of(context).size.width/2,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 15,
                                      margin: EdgeInsets.only(),
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
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          alignment: Alignment.topLeft,
                                          child: TextFormField(
                                            onChanged: textChangedWeight,
                                            controller: Controllers.milk_weight,
                                            focusNode: WeightFocus,
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
                                                labelText: weightValue,
                                                hoverColor: AppColors.lightBlue,
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Container(
                                      //   width: MediaQuery.of(context).size.width/2,
                                      margin: EdgeInsets.only(left: 90),
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
                                            controller: Controllers.milk_rate,
                                            readOnly: true,
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
                                      margin: EdgeInsets.only(left: 80),
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
                                            controller: Controllers.milk_amount,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            textAlign: TextAlign.left,
                                            readOnly: true,
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
                                  if (Controllers
                                      .milk_vendor_Code.text.isEmpty) {
                                    Scaffold.of(context).showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                'Please Enter Vendor Code')));
                                  } else if (Controllers
                                      .milk_fat.text.isEmpty) {
                                    Scaffold.of(context).showSnackBar(
                                        new SnackBar(
                                            content:
                                                new Text('Please Enter FAT')));
                                  } else if (Controllers
                                      .milk_snf.text.isEmpty) {
                                    Scaffold.of(context).showSnackBar(
                                        new SnackBar(
                                            content:
                                                new Text('Please Enter SNF')));
                                  } else if (Controllers
                                      .milk_weight.text.isEmpty) {
                                    Scaffold.of(context).showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                'Please Enter Weight')));
                                  } else {
                                    Dialogs.showLoadingDialog(
                                        context, _keyLoader);
                                    addMilkCollection(_keyLoader);
                                  }
                                  /* if (_formKey.currentState.validate()) {
                                    Dialogs.showLoadingDialog(
                                        context, _keyLoader);
                                    addMilkCollection(_keyLoader);
                                  }*/
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
                                                                        _keyLoader, s);
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
                                                    5,
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
                                                    3,
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
                                                    3,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'shift'.tr,
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
                                              'cattletype'.tr,
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
                                                    6,
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'vendorname'.tr,
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
                                              'fat'.tr,
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
                                              'snf'.tr,
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
                                              'clr'.tr,
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
                                                    40,
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
                                                              getCheckValues(
                                                                  index);
                                                            });
                                                          },
                                                        ),
                                                        SizedBox(
                                                            child: Container(
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
                                                            requestpojo.paginateData.data
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
                                                              4,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            requestpojo.paginateData.data
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
                                                              2,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            requestpojo.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .shift,
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
                                                            requestpojo.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .cattleType,
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
                                                            requestpojo.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .vendorNumber,
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
                                                              7,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            requestpojo.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .vendorName,
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
                                                            requestpojo.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .fat,
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
                                                            requestpojo.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .snf,
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
                                                            requestpojo.paginateData.data.elementAt(index).clr ==
                                                                        null ||
                                                                requestpojo.paginateData.data
                                                                            .elementAt(
                                                                                index)
                                                                            .clr ==
                                                                        "0"
                                                                ? "0"
                                                                : requestpojo.paginateData.data
                                                                    .elementAt(
                                                                        index)
                                                                    .clr,
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
                                                            requestpojo.paginateData.data
                                                                    .elementAt(
                                                                        index)
                                                                    .weight +
                                                                requestpojo.paginateData.data
                                                                    .elementAt(
                                                                        index)
                                                                    .weighing,
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
                                                            requestpojo.paginateData.data
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
                                                              6,
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                1,
                                                          ),

                                                          //   width: MediaQuery.of(context).size.width/2,
                                                          child: Text(
                                                            requestpojo.paginateData.data
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
                                                            nextscreen(requestpojo.paginateData.data
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

                                                                  dltid = user2
                                                                      .data
                                                                      .elementAt(
                                                                          index)
                                                                      .id;
                                                                });
                                                              },
                                                            ),
                                                            SizedBox(
                                                                child:
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
                                                                    .snf,
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
                                                                    .clr,
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
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    top: 50, right: 100),
                                                alignment: Alignment.center,
                                                child: resultvalue2 == true
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Center(
                                                        child: Text("No Data")),
                                              )
                                        : Container()
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
      tmpArray.remove(requestpojo.paginateData.data.elementAt(index).id);
    } else {
      _selected_box.add(index);
      tmpArray.add(requestpojo.paginateData.data.elementAt(index).id);
    }

    s = tmpArray.join(',');
  }

  Future<void> addMilkCollection(
      GlobalKey<State<StatefulWidget>> keyLoader) async {
    var formData;
    if (weightValue == null) {
      formData = {
        'date': Controllers.milk_date.text,
        'time': Controllers.milk_time.text,
        'shift': Controllers.milk_shift.text,
        'cattle_type': "",
        'vendor_number': textValue,
        'vendor_name': Controllers.milk_vendor_name.text,
        'fat': Controllers.milk_fat.text,
        'snf': Controllers.milk_snf.text,
        'clr': Controllers.milk_clr.text,
        'weight': Controllers.milk_weight.text,
        'rate': Controllers.milk_rate.text,
        'amount': Controllers.milk_amount.text,
        'weighing': dropdownValueSpinner,
        'user_id': _userId
      };
    } else {
      formData = {
        'date': Controllers.milk_date.text,
        'time': Controllers.milk_time.text,
        'shift': Controllers.milk_shift.text,
        'cattle_type': "",
        'vendor_number': textValue,
        'vendor_name': Controllers.milk_vendor_name.text,
        'fat': Controllers.milk_fat.text,
        'snf': Controllers.milk_snf.text,
        'clr': Controllers.milk_clr.text,
        'weight': Controllers.milk_weight.text,
        'rate': Controllers.milk_rate.text,
        'amount': Controllers.milk_amount.text,
        'weighing': weightValue,
        'user_id': _userId
      };
    }
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/addmilkcollection',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      user = AddMilkCollectionResponse.fromJson(responseData.data);
      if (user.status == 200) {
        getMilkCollections(_userId,pageNumber);

        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));

        dateController2.text = '';
        Controllers.milk_time.text = '';
        Controllers.milk_shift.text = '';
        Controllers.milk_vendor_Code.text = '';
        Controllers.milk_vendor_name.text = '';
        Controllers.milk_fat.text = '';
        Controllers.milk_snf.text = '';
        Controllers.milk_clr.text = '';
        Controllers.milk_weight.text = '';
        Controllers.milk_rate.text = '';
        Controllers.milk_amount.text = '';
      } else if (user.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.toString())));
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text("Vendor Code Already Exists")));
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
          '/api/deleteMilkcollection',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      DeleteMilkResponse user2 = DeleteMilkResponse.fromJson(responseData.data);
      setState(() {
        getMilkCollections(_userId,pageNumber);

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



  void paginationApi() {
    _listViewController.addListener(() {
      if (_listViewController.offset >= _listViewController.position.maxScrollExtent &&
          !_listViewController.position.outOfRange) {
        setState(() {
          if (pageNumber <requestpojo.paginateData.lastPage ) {
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
            if (pageNumber <requestpojo.paginateData.lastPage ) {
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
      'shift': Controllers.milk_shift.text,
      'page':page.toString()
    };
    print("Darta: "+data.toString());

    Dialogs.showLoadingDialog(context, _keyLoader);
    var jsonResponse = null;
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/milkcollection_list", body: data);
    if (response.statusCode == 200)
    {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {
        print("Json User: " + jsonResponse.toString());

        requestpojo = new MilkCollcetionGetResponse.fromJson(jsonResponse);
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(requestpojo.paginateData.data.isEmpty)
            {
              resultvalue1 = false;
            }
            else
            {
              resultvalue1 = true;
              print("SSSS");
              listdata1 = requestpojo.paginateData.data;
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
      'user_id': user_id.toString(), 'shift': Controllers.milk_shift.text,'page':page.toString()
    };

    print("user: " + data.toString());
    var jsonResponse = null;
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/milkcollection_list", body: data);
    if (response.statusCode == 200)
    {

      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {

        requestpojo = new MilkCollcetionGetResponse.fromJson(jsonResponse);
        /*  print("Json User: " + jsonResponse.toString());*/
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(requestpojo.paginateData.data.isEmpty)
            {
              resultvalue1 = false;
            }
            else
            {
              resultvalue1 = true;
              print("SSSS");
              listdata1 = requestpojo.paginateData.data;
            }
          });
        }
        else {

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
      GetVendorNameResponse user1 =
          GetVendorNameResponse.fromJson(responseData.data);
      if (user1.status == 200) {
        setState(() {
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user1.message)));

          Controllers.milk_vendor_name.text =
              user1.data.elementAt(0).vendorName;
          Controllers.milk_rate.text = user1.data.elementAt(0).rate;
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
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  void nextscreen(int id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditMilkCollection(id)),
    );
  }

  void calculate(int rateval) {
    rate = rateval;
    weight = int.parse(Controllers.milk_weight.text.toString());
  }

  Future<void> getFilterList(GlobalKey<State<StatefulWidget>> keyLoader,
      String text, String text2, int userId) async {
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
      user2 = MilkCollcetionFilterGetResponse.fromJson(responseData.data);
      setState(() {
        type = 'filter';
        resultvalue2 = true;
        listdata2 = user2.data;
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      /*   Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));*/
      setState(() {
        type = 'filter';
        resultvalue2 = false;
      });
    }
  }

  Future<void> getweight(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getweight',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetWeightReponse user1 = GetWeightReponse.fromJson(responseData.data);
      setState(() {
        if (user1.status == 200) {
          getWeightValue(_keyLoader, _userId);
          weightValue = user1.data.elementAt(0).weight;
        } else if (user1.status == 400) {}
      });
    } catch (e) {
      setState(() {});
    }
  }

  void getWeightValue(
      GlobalKey<State<StatefulWidget>> keyLoader, int userId) async {
    final formData = {'user_id': userId};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getsetting',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetSavedWeight user1 = GetSavedWeight.fromJson(responseData.data);
      setState(() {
        if (user1.data.elementAt(0).weighing.toString() == "true") {
          getweight(keyLoader, _userId);
        } else if (user1.data.elementAt(0).weighing.toString() == "false") {}
        // showvalue = user1.data.elementAt(0).weighing.toString();
      });
    } catch (e) {
      setState(() {});
    }
  }

  void getAnalyzValue(
      GlobalKey<State<StatefulWidget>> keyLoader, int userId) async {
    final formData = {'user_id': userId};
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getanalyzersetting',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetAnalyze user1 = GetAnalyze.fromJson(responseData.data);
      setState(() {
        if (user1.data.elementAt(0).analyzer.toString() == "true") {
          getweightUser(_keyLoader, _userId);
        } else if (user1.data.elementAt(0).analyzer.toString() == "false") {}
        // showvalue = user1.data.elementAt(0).weighing.toString();


      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> getweightUser(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': _userId};
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getanalyzer',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetAnalyzeResponse user1 = GetAnalyzeResponse.fromJson(responseData.data);
      print("staus================" + user1.status.toString());
      setState(() {
        if(user1.status==200) {
          String fat = user1.data.elementAt(0).fat;
          String snf = user1.data.elementAt(0).snf;
          String clr = user1.data.elementAt(0).clr;
          String cattle = user1.data.elementAt(0).cattle;
          Controllers.milk_fat.text = fat;
          Controllers.milk_snf.text = snf;
          Controllers.milk_clr.text = clr;
          Controllers.milk_cattletype.text = cattle;

        }
        else if(user1.status==400){
          Controllers.milk_fat.text = '';
          Controllers.milk_snf.text = '';
          Controllers.milk_clr.text = '';
          Controllers.milk_cattletype.text = '';
        }
      }
      );
    } catch (e) {
      setState(() {
        Controllers.milk_fat.text = '';
        Controllers.milk_snf.text = '';
        Controllers.milk_clr.text = '';
        Controllers.milk_cattletype.text = '';
      });
    }
  }

  void function() {
  }
  _launchPdfURL() async {
    String url =
        'https://shankraresearch.com/milkcollectionexport/' + _userId.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL() async {
    String url =
        'http://shankraresearch.com/milkCollection' + _userId.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void addFvrt(isFavorite) {

    if(isFavorite){
      print('Is Favorite : $isFavorite');
      addToFvrt(1);
    }
    else {
      print('Is Favorite : $isFavorite');
      addToFvrt(0);
    }

  }

  Future<void> addToFvrt(
     int i) async {
    var formData;
      formData = {
        'user_id': _userId,
        'favourite':i.toString(),
        'tab_name': 'Milk Collection',
      };
    print('Is Favorite : $formData');
      try {
        Dio _dio = new Dio();
        _dio.options.contentType = Headers.formUrlEncodedContentType;

        final responseData = await _dio.post<Map<String, dynamic>>(
            '/api/addTabToFavourite',
            options: RequestOptions(
                method: 'POST',
                headers: <String, dynamic>{},
                baseUrl: ApiBaseUrl.base_url),
            data: formData);

        AddToFvrtResponse  user = AddToFvrtResponse.fromJson(responseData.data);


        print('Is Favorite :'+user.message);


        if (user.status == 200) {
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user.message.toString())));
        }
        else if (user.status == 400) {
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user.message.toString())));
        }
      } catch (e) {

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
        return '';
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
        return '';
    }
  }

  @override
  String toString() => message;
}
