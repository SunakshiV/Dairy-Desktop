import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:dairy_newdeskapp/model/AddItemSaleResponse.dart';
import 'package:dairy_newdeskapp/model/DeleteItemSaleResponse.dart';
import 'package:dairy_newdeskapp/model/GetVendorNameResponse.dart';
import 'package:dairy_newdeskapp/model/ItemSaleFilterGetResponse.dart';
import 'package:dairy_newdeskapp/model/ItemSaleListResponse.dart';
import 'package:dairy_newdeskapp/model/ItemSaleSingleSaleResponse.dart';
import 'package:dairy_newdeskapp/model/MilkSaleResponse.dart';
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
import 'Bonus.dart';
import 'package:get/get.dart';

class ItemSale extends StatefulWidget {
  @override
  ItemSaleState createState() => ItemSaleState();
}

class ItemSaleState extends State<ItemSale> {
  int select, valueRadio;
  String dropdownValue = 'Select';
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  Timer timer;
  var time, date;
  int _userId;
  String textValue;
  Timer timeHandle;
  String type = 'normal';
  var listdata1;

  bool resultvalue1 = true;
  var listdata3;
  bool resultvalue3 = true;
  int value = 0;
  var listdata2;
  int _counter = 0;
  bool resultvalue2 = true;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  ItemSaleSingleSaleResponse user2;
  int count = 1;
  List a;
  MilkSaleResponse user1;
  List<String> spinnerItems = ['Select', 'Two', 'Three', 'Four', 'Five'];
  List<int> _selected_box = List();
  var tmpArray = [];
  String s;
  ItemSaleFilterGetResponse user4;
  var listdata4;
  bool resultvalue4 = true;
  ItemSaleListResponse user3;
  var tmpArray1 = [];
  final List<String> names = <String>[];
  final List<String> units = <String>[];
  final List<String> rate = <String>[];
  final List<String> quantity = <String>[];
  final List<String> amount = <String>[];
  int amounta;
  int ratea;
  String textValueweight;
  Timer timeHandleweight;



  int pageNumber = 1;
  int totalPage = 1;
  bool isLoading = false;
  static ScrollController _listViewController;
  String val;
  void textChanged(String val) {
    textValue = val;
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () {
      getVedorName(_keyLoader, textValue);
    });
  }
  void textChangedWeight(String val) {
    textValueweight = val;
    if (timeHandleweight != null) {
      timeHandleweight.cancel();
    }
    timeHandleweight = Timer(Duration(seconds: 1), () {
      setState(() {
        amounta = int.parse(textValueweight) * ratea;
        Controllers.item_amount.text = amounta.toString();
        print('ammm'+amounta.toString());
      });
    });
  }

  @override
  Future<void> initState() {
    _listViewController = new ScrollController()..addListener(function);
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _loadID());
  }
  @override
  void dispose() {
    _listViewController.dispose();
    timer.cancel();
    super.dispose();
  }

  _loadID() async {
    DateTime now = DateTime.now();
    final format = DateFormat.jm();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: SizeConfig.blockSizeHorizontal * 100,
        child: Card(
          color: AppColors.accountbgcolor,
          elevation: 10,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                color: AppColors.lightGreenHeading,
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeHorizontal * 1,
                    left: SizeConfig.blockSizeHorizontal * 1,
                    right: SizeConfig.blockSizeHorizontal * 1),
                alignment: Alignment.topLeft,
                child: Text(
                  'itemsale'.tr,
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
                                      'date'.tr,
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      controller: Controllers.milk_date,
                                      textAlignVertical: TextAlignVertical.top,
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
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'time'.tr,
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      controller: Controllers.milk_time,
                                      textAlignVertical: TextAlignVertical.top,
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
                              Container(
                                //   width: MediaQuery.of(context).size.width/2,
                                width: SizeConfig.blockSizeHorizontal * 15,
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'vendorcode'.tr,
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 40,
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: textChanged,
                                      controller: Controllers.milk_vendor_Code,
                                      textAlignVertical: TextAlignVertical.top,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: AppColors.black),
                                          labelText: '',
                                          hoverColor: AppColors.lightBlue,
                                          border: OutlineInputBorder()),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Enter Vendor Code';
                                        }
                                        return null;
                                      },
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
                                      'vendorname'.tr,
                                      style: TextStyle(
                                          color: AppColors.black, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    child: TextField(
                                      controller: Controllers.milk_vendor_name,
                                      readOnly: true,
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
                      ],
                    ),
                  )),
              Container(
                  width: SizeConfig.blockSizeHorizontal * 76,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                    right: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  child: Align(
                      alignment: Alignment.topLeft,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
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
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                1,
                                          ),
                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'srno'.tr,
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
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'itemname'.tr,
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
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'units'.tr,
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
                                            left:
                                            SizeConfig.blockSizeHorizontal *
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
                                              10,
                                          margin: EdgeInsets.only(
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                5,
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
                                          alignment: Alignment.center,
                                          width:
                                          SizeConfig.blockSizeHorizontal *
                                              10,
                                          margin: EdgeInsets.only(
                                            left:
                                            SizeConfig.blockSizeHorizontal *
                                                3,
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
                                  )),

                              Container(    // list

                                  width: SizeConfig.blockSizeHorizontal * 76,
                                  height: SizeConfig.blockSizeVertical * 10,



                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount: names.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              width: SizeConfig
                                                  .blockSizeHorizontal *
                                                  76,

                                              height: 50,
                                              margin: EdgeInsets.all(2),

                                                  child:Row(
                                                    children: <Widget>[


                                                      Container(
                                                       width: SizeConfig
                                                          .blockSizeHorizontal *
                                                          8,
                                                        child:  Text((index+1).toString(),
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ),


                                                      Container(
                                                        width: SizeConfig
                                                            .blockSizeHorizontal *
                                                            8,
                                                        margin: EdgeInsets.only(left:SizeConfig
                                                            .blockSizeHorizontal *
                                                            5),
                                                        child:  Text('${names[index]}',
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ),

                                                      Container(
                                                        width: SizeConfig
                                                            .blockSizeHorizontal *
                                                            8,
                                                        margin: EdgeInsets.only(left:SizeConfig
                                                            .blockSizeHorizontal *
                                                            5),
                                                        child:  Text('${units[index]}',
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ),

                                                      Container(
                                                        width: SizeConfig
                                                            .blockSizeHorizontal *
                                                            8,
                                                        margin: EdgeInsets.only(left:SizeConfig
                                                            .blockSizeHorizontal *
                                                            3),
                                                        child:  Text('${rate[index]}',
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ),

                                                      Container(
                                                        width: SizeConfig
                                                            .blockSizeHorizontal *
                                                            8,
                                                        margin: EdgeInsets.only(left:SizeConfig
                                                            .blockSizeHorizontal *
                                                            7),
                                                        child:  Text('${quantity[index]}',
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ),

                                                      Container(
                                                        width: SizeConfig
                                                            .blockSizeHorizontal *
                                                            8,
                                                        margin: EdgeInsets.only(left:SizeConfig
                                                            .blockSizeHorizontal *
                                                            5),
                                                        child:  Text('${amount[index]}',
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ),

                                                    ],
                                                  )



                                            );
                                          }
                                      )


                              ),

                              Container(

                                width: SizeConfig
                                    .blockSizeHorizontal *
                                    76,
                                height: 30,


                                child:Row(
                                  children: <Widget>[

                                Container(
                                  width: SizeConfig
                                      .blockSizeHorizontal *
                                      8,
                                  height: 30,
                                child: Text((names.length+1).toString()),
                                 padding: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(

                                    border: Border.all(
                                      color: AppColors.lightBlue,
                                      width: 2.0 ,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                ),


                                    Container(
                                      width: SizeConfig
                                          .blockSizeHorizontal *
                                          8,
                                      height: 30,
                                      margin: EdgeInsets.only(left: SizeConfig
                                          .blockSizeHorizontal *
                                          3),
                                      child: TextFormField(
                                        controller:
                                        Controllers.item_name,
                                        textAlignVertical:
                                        TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: AppColors
                                                    .greyhint),
                                            hoverColor:
                                            AppColors.lightBlue,
                                            border:
                                            OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null ||
                                              text.isEmpty) {
                                            return 'Enter Weight';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig
                                          .blockSizeHorizontal *
                                          8,
                                      height: 30,
                                      margin: EdgeInsets.only(left: SizeConfig
                                          .blockSizeHorizontal *
                                          5),
                                      child: TextFormField(

                                        controller:
                                        Controllers.item_units,
                                        textAlignVertical:
                                        TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: AppColors
                                                    .greyhint),
                                            hoverColor:
                                            AppColors.lightBlue,
                                            border:
                                            OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null ||
                                              text.isEmpty) {
                                            return 'Enter Weight';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig
                                          .blockSizeHorizontal *
                                          8,
                                      height: 30,
                                      margin: EdgeInsets.only(left: SizeConfig
                                          .blockSizeHorizontal *
                                          3),
                                      child: TextFormField(
                                       readOnly: true,
                                        controller:
                                        Controllers.item_rate,
                                        textAlignVertical:
                                        TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: AppColors
                                                    .greyhint),
                                            hoverColor:
                                            AppColors.lightBlue,
                                            border:
                                            OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null ||
                                              text.isEmpty) {
                                            return 'Enter Weight';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig
                                          .blockSizeHorizontal *
                                          8,
                                      height: 30,
                                      margin: EdgeInsets.only(left: SizeConfig
                                          .blockSizeHorizontal *
                                          7),
                                      child: TextFormField(
                                        onChanged: textChangedWeight,
                                        controller:
                                        Controllers.item_quantity,
                                        textAlignVertical:
                                        TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: AppColors
                                                    .greyhint),
                                            hoverColor:
                                            AppColors.lightBlue,
                                            border:
                                            OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null ||
                                              text.isEmpty) {
                                            return 'Enter Weight';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: SizeConfig
                                          .blockSizeHorizontal *
                                          5),
                                      width: SizeConfig
                                          .blockSizeHorizontal *
                                          8,
                                      height: 30,
                                      child: TextFormField(
                                       readOnly: true,
                                        controller:
                                        Controllers.item_amount,
                                        textAlignVertical:
                                        TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: AppColors
                                                    .greyhint),
                                            hoverColor:
                                            AppColors.lightBlue,
                                            border:
                                            OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null ||
                                              text.isEmpty) {
                                            return 'Enter Weight';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),


                                  ],
                                )

                                //   width: MediaQuery.of(context).size.width/2,

                              ),


                              Container(
                          margin: EdgeInsets.only(top:20),
                                  width: SizeConfig
                                      .blockSizeHorizontal *
                                      76,
                                  height: 30,


                                  child:Row(
                                    children: <Widget>[

                                      Container(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            8,
                                        height: 30,

                                      ),

                                      Container(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            8,
                                        height: 30,
                                        margin: EdgeInsets.only(left: SizeConfig
                                            .blockSizeHorizontal *
                                            3),

                                      ),
                                      Container(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            8,
                                        height: 30,
                                        margin: EdgeInsets.only(left: SizeConfig
                                            .blockSizeHorizontal *
                                            5),

                                      ),
                                      Container(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            8,
                                        height: 30,
                                        margin: EdgeInsets.only(left: SizeConfig
                                            .blockSizeHorizontal *
                                            3),

                                      ),
                                      Container(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            8,
                                        height: 30,
                                        margin: EdgeInsets.only(left: SizeConfig
                                            .blockSizeHorizontal *
                                            7),
                                        child: TextFormField(
                                          onChanged: textChangedWeight,
                                          controller:
                                          Controllers.itemadd_quantity,
                                          textAlignVertical:
                                          TextAlignVertical.top,
                                          textAlign: TextAlign.left,
                                          decoration: InputDecoration(

                                              labelStyle: TextStyle(
                                                  color: AppColors
                                                      .greyhint),
                                              hoverColor:
                                              AppColors.lightBlue,
                                              border:
                                              OutlineInputBorder()),

                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: SizeConfig
                                            .blockSizeHorizontal *
                                            5),
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            8,
                                        height: 30,
                                        child: TextFormField(

                                          readOnly: true,
                                          controller:
                                          Controllers.itemadd_amount,
                                          textAlignVertical:
                                          TextAlignVertical.top,
                                          textAlign: TextAlign.left,
                                          decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  color: AppColors
                                                      .greyhint),
                                              hoverColor:
                                              AppColors.lightBlue,
                                              border:
                                              OutlineInputBorder()),
                                          validator: (text) {
                                            if (text == null ||
                                                text.isEmpty) {
                                              return 'Enter Weight';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),


                                    ],
                                  )

                                //   width: MediaQuery.of(context).size.width/2,

                              ),



                              /* Container(
                                  width: SizeConfig.blockSizeHorizontal * 76,
                                  height: SizeConfig.blockSizeVertical * 5,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
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
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),
                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'SR NO.',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'ITEM NAME',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'UNITS',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'RATE',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    5,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'Quantity',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    3,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'AMOUNT',
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
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      bottomRight: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      topLeft: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      topRight: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                    ),
                                  )),
                              listdata2 != null
                                  ? Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 76,
                                      height: SizeConfig.blockSizeVertical * 10,
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              1),
                                      child: Expanded(
                                        child: ListView.builder(

                                            //  itemCount: count,
                                            itemCount: listdata2.length == null
                                                ? 0
                                                : listdata2.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        5,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                    ),
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontFamily:
                                                              'Poppins-Normal',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user2.data
                                                          .elementAt(index)
                                                          .item,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontFamily:
                                                              'Poppins-Normal',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          3,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user2.data
                                                          .elementAt(index)
                                                          .units,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontFamily:
                                                              'Poppins-Normal',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user2.data
                                                          .elementAt(index)
                                                          .rate,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontFamily:
                                                              'Poppins-Normal',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          5,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user2.data
                                                          .elementAt(index)
                                                          .quantity,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontFamily:
                                                              'Poppins-Normal',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          3,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user2.data
                                                          .elementAt(index)
                                                          .amount,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontFamily:
                                                              'Poppins-Normal',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ))
                                  : Container(
                                      */


                              /* margin:
                                          EdgeInsets.only(top: 50, right: 100),
                                      alignment: Alignment.center,
                                      child: resultvalue1 == true
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Center(child: Text("No Data")),*//*
                                      ),
                              Container(
                                  width: SizeConfig.blockSizeHorizontal * 76,
                                  height: SizeConfig.blockSizeVertical * 10,
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1),
                                  margin: EdgeInsets.only(top: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: ListView.builder(
                                        //  itemCount: count,
                                        itemCount: count,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      1,
                                                ),
                                                child: Text(
                                                  (value + 1).toString(),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontFamily:
                                                          'Poppins-Normal',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                      letterSpacing: 1.0),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    8,
                                                height: 30,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3,
                                                ),

                                                //   width: MediaQuery.of(context).size.width/2,
                                                child: TextFormField(
                                                  controller:
                                                      Controllers.item_name,
                                                  textAlignVertical:
                                                      TextAlignVertical.top,
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: AppColors
                                                              .greyhint),
                                                      hoverColor:
                                                          AppColors.lightBlue,
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (text) {
                                                    if (text == null ||
                                                        text.isEmpty) {
                                                      return 'Enter Weight';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    8,
                                                height: 30,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
                                                ),

                                                //   width: MediaQuery.of(context).size.width/2,
                                                child: TextFormField(
                                                  controller:
                                                      Controllers.item_units,
                                                  textAlignVertical:
                                                      TextAlignVertical.top,
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: AppColors
                                                              .greyhint),
                                                      hoverColor:
                                                          AppColors.lightBlue,
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (text) {
                                                    if (text == null ||
                                                        text.isEmpty) {
                                                      return 'Enter Weight';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    8,
                                                height: 30,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4,
                                                ),

                                                //   width: MediaQuery.of(context).size.width/2,
                                                child: TextFormField(
                                                  controller:
                                                      Controllers.item_rate,
                                                  textAlignVertical:
                                                      TextAlignVertical.top,
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: AppColors
                                                              .greyhint),
                                                      hoverColor:
                                                          AppColors.lightBlue,
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (text) {
                                                    if (text == null ||
                                                        text.isEmpty) {
                                                      return 'Enter Weight';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    8,
                                                height: 30,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      6,
                                                ),

                                                //   width: MediaQuery.of(context).size.width/2,
                                                child: TextFormField(
                                                  controller:
                                                      Controllers.item_quantity,
                                                  textAlignVertical:
                                                      TextAlignVertical.top,
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: AppColors
                                                              .greyhint),
                                                      hoverColor:
                                                          AppColors.lightBlue,
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (text) {
                                                    if (text == null ||
                                                        text.isEmpty) {
                                                      return 'Enter Weight';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    8,
                                                height: 30,
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
                                                ),

                                                //   width: MediaQuery.of(context).size.width/2,
                                                child: TextFormField(
                                                  controller:
                                                      Controllers.item_amount,
                                                  textAlignVertical:
                                                      TextAlignVertical.top,
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: AppColors
                                                              .greyhint),
                                                      hoverColor:
                                                          AppColors.lightBlue,
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (text) {
                                                    if (text == null ||
                                                        text.isEmpty) {
                                                      return 'Enter Weight';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ))*/
                            ],
                          )))),
              Container(
                  margin: EdgeInsets.only( top:30,
                    right: 20,
                  ),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(
                        right: 20,
                      ),
                      child: InkWell(
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 5,
                          height: SizeConfig.blockSizeVertical * 5,
                          alignment: Alignment.center,
                          child: Text(
                            'save'.tr,
                            style:
                                TextStyle(color: AppColors.white, fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blueDark,
                          ),
                        ),
                        onTap: () {
                          addMilkCollection(_keyLoader);


                        },
                      )),
                  Container(
                      margin: EdgeInsets.only(
                        right: 300,
                      ),
                      child: InkWell(
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 5,
                          height: SizeConfig.blockSizeVertical * 5,
                          alignment: Alignment.center,
                          child: Text(
                            'print'.tr,
                            style:
                                TextStyle(color: AppColors.white, fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blueDark,
                          ),
                        ),
                        onTap: () {},
                      )),
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeVertical * 5,
                      margin: EdgeInsets.only(
                          right: SizeConfig.blockSizeVertical * 13),
                      color: AppColors.greencolor,
                      child: InkWell(
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 5,
                          height: SizeConfig.blockSizeVertical * 5,
                          alignment: Alignment.center,
                          child: Text(
                            'add'.tr,
                            style:
                                TextStyle(color: AppColors.white, fontSize: 18),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.greencolor,
                          ),
                        ),
                        onTap: () {
                          addItemToList();
                          Controllers.item_name.text='';
                          Controllers.item_units.text='';

                          Controllers.item_quantity.text='';
                          Controllers.item_amount.text='';
                         /* if (Controllers.item_name.text.isEmpty ||
                              Controllers.item_units.text.isEmpty ||
                              Controllers.item_rate.text.isEmpty ||
                              Controllers.item_quantity.text.isEmpty ||
                              Controllers.item_amount.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(new SnackBar(
                                content: new Text('Please Enter Fields')));
                          } else {
                          addMilkCollection(_keyLoader, value);




                            List<String> data=new List();

                            data.add(Controllers.item_name.text);
                            print("---------------"+data.toString());

                            *//* if (count >= 1) {
                          count++;

                          //  a = new List();
                          // a.add(Controllers.item_name);
                        }*//*
                          }*/
                        },
                      )),
                ],
              )),
              Container(
                child: Align(
                  child: Container(
                      child: Container(
                    margin: EdgeInsets.only(right: 30, top: 20),
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
                                                              'sure'.tr),
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
                              'exportto'.tr,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: SizeConfig.blockSizeVertical * 2,
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
                                      image: AssetImage("assests/image/cs.png"),
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
                                    Container(
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 6,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'date'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 4,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'time'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 4,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'vendorcode'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 6,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'vendorname'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 7,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'item'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 7,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'units'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 5,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'rate'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 5,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'quantity'.tr,
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
                                      width: SizeConfig.blockSizeHorizontal * 6,
                                      margin: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                      ),

                                      //   width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        'amount'.tr,
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
                              )),
                          type == "normal"
                              ? listdata3 != null
                                  ? Container(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 80,
                                      height: SizeConfig.blockSizeVertical * 50,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: ListView.builder(
                                            controller: _listViewController,
                                            itemCount: listdata3.length == null
                                                ? 0
                                                : listdata3.length,
                                            itemBuilder: (BuildContext context,
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
                                                            user3.paginateData.data
                                                                .elementAt(
                                                                    index)
                                                                .id
                                                                .toString());

                                                        getCheckValues(index);
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                      child: Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        6,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .date,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  )),
                                                  Container(
                                                    alignment: Alignment.center,
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
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .time,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
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
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .code,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        7,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .name,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
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
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .item,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        9,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .units,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .rate,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
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
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .quantity,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        6,
                                                    margin: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .blockSizeHorizontal *
                                                          1,
                                                    ),

                                                    //   width: MediaQuery.of(context).size.width/2,
                                                    child: Text(
                                                      user3.paginateData.data
                                                          .elementAt(index)
                                                          .amount,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: (SizeConfig
                                                                  .blockSizeVertical *
                                                              1.3),
                                                          letterSpacing: 1.0),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ))
                                  : Container(
                                      margin:
                                          EdgeInsets.only(top: 50, right: 100),
                                      alignment: Alignment.center,
                                      child: resultvalue3 == true
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Center(child: Text("No Data")),
                                    )
                              : type == "filter"
                                  ? listdata3 != null
                                      ? Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  80,
                                          height:
                                              SizeConfig.blockSizeVertical * 50,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: ListView.builder(
                                                itemCount:
                                                    listdata3.length == null
                                                        ? 0
                                                        : listdata3.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Row(
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

                                                            print(user2.data
                                                                .elementAt(
                                                                    index)
                                                                .id
                                                                .toString());
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .date,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .time,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .code,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .name,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .item,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .units,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .rate,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
                                                                      .blockSizeVertical *
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
                                                            Alignment.center,
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            4,
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .quantity,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .amount,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user4.data
                                                              .elementAt(index)
                                                              .amount,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: (SizeConfig
                                                                      .blockSizeVertical *
                                                                  1.3),
                                                              letterSpacing:
                                                                  1.0),
                                                        ),
                                                      ),
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
    );
  }

  Future<void> getFilterList(GlobalKey<State<StatefulWidget>> keyLoader,
      String text, String text2, int userId) async {
    final formData = {
      'from': text,
      'to': text2,
      'user_id': userId,
    };

    print("filterdata" + formData.toString());

    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/itemfilter',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user4 = ItemSaleFilterGetResponse.fromJson(responseData.data);
      setState(() {
        type = 'filter';
        resultvalue4 = true;
        listdata4 = user4.data;
        print("11---------" + user4.data.length.toString());
        print("22------------" + responseData.data.toString());
      });
    } catch (e) {
      //final errorMessage = DioExceptions.fromDioError(e);
      /* Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));*/
      setState(() {
        resultvalue4 = false;
      });
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
          '/api/deleteitemsale',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      DeleteItemSaleResponse user2 =
          DeleteItemSaleResponse.fromJson(responseData.data);
      setState(() {
        getMilkCollections1(_userId,pageNumber);

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

  void getCheckValues(int index) {
    if (_selected_box.contains(index)) {
      _selected_box.remove(index);
      tmpArray.remove( user3.paginateData.data.elementAt(index).id);
    } else {
      _selected_box.add(index);
      tmpArray.add( user3.paginateData.data.elementAt(index).id);
    }

    print(tmpArray);

    s = tmpArray.join(',');

    print("new" + s);
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
       //   getMilkCollections(_keyLoader, _userId);

          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user1.message)));
          Controllers.milk_vendor_name.text =
              user1.data.elementAt(0).vendorName;
          Controllers.item_rate.text = user1.data.elementAt(0).rate;
          ratea = int.parse(user1.data.elementAt(0).rate);
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
      'date':Controllers.milk_date.text,
      'time': Controllers.milk_time.text,
      'code': textValue,
      'name':Controllers.milk_vendor_name.text,
      'item': names,
      'units':units,
      'rate':ratea,
      'quantity': Controllers.itemadd_quantity.text,
      'amount': Controllers.itemadd_amount.text,
      'user_id': _userId
    };
    print('mydata'+formData.toString());

    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/additemsales',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text('adddded')));

      AddItemSaleResponse user =
          AddItemSaleResponse.fromJson(responseData.data);
      print('mydata----'+user.toString());
      if (user.status == 200) {
   getMilkCollections(_keyLoader, _userId);
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        Controllers.item_name.text = '';
        Controllers.item_units.text = '';
        Controllers.item_rate.text = '';
        Controllers.item_quantity.text = '';
        Controllers.item_amount.text = '';
        //    getMilkCollections(_keyLoader);
      }


      else if(user.status==400){
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
      }
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  Future<void> getMilkCollections(
      GlobalKey<State<StatefulWidget>> keyLoader, int userId) async {
    final formData = {
      'user_id': userId,
      'code': textValue,
    };
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/itemsalevendor',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user2 = ItemSaleSingleSaleResponse.fromJson(responseData.data);
      setState(() {
        resultvalue2 = true;
        listdata2 = user2.data;
        print("value" + user2.data.length.toString());
        value = user2.data.length;
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
       Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
      setState(() {
        resultvalue2 = false;
      });
    }
  }



  void paginationApi() {
    _listViewController.addListener(() {
      if (_listViewController.offset >= _listViewController.position.maxScrollExtent &&
          !_listViewController.position.outOfRange) {
        setState(() {
          if (pageNumber <user3.paginateData.lastPage ) {
            pageNumber += 1;
            getMilkCollections1(_userId, pageNumber);
          }

        });
      }
      if (_listViewController.offset <= _listViewController.position.minScrollExtent &&
          !_listViewController.position.outOfRange) {
        setState(() {
          if(pageNumber>=1)
          {
            pageNumber=  pageNumber-1;
            if (pageNumber <user3.paginateData.lastPage ) {
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

  void getMilkCollections1(int user_id,int page) async {
    Map data = {
      'user_id': user_id.toString(),
      'page':page.toString()
    };
    print("Darta: "+data.toString());

    Dialogs.showLoadingDialog(context, _keyLoader);
    var jsonResponse = null;
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/itemsalelist", body: data);
    if (response.statusCode == 200)
    {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {
        print("Json User: " + jsonResponse.toString());

        user3 = new ItemSaleListResponse.fromJson(jsonResponse);
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(user3.paginateData.data.isEmpty)
            {
              resultvalue3 = false;
            }
            else
            {
              resultvalue3 = true;
              print("SSSS");
              listdata3 = user3.paginateData.data;
            }
          });
        }
        else {
          print("SSSS1234");
        }
      } else {
        setState(() {
          resultvalue3 = false;
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
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/itemsalelist", body: data);
    if (response.statusCode == 200)
    {

      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {
        print("Json User: " + jsonResponse.toString());

        user3 = new ItemSaleListResponse.fromJson(jsonResponse);
        if (jsonResponse != null) {
          print("response");
          setState(() {
            if(user3.paginateData.data.isEmpty)
            {
              resultvalue3 = false;
            }
            else
            {
              resultvalue3 = true;
              print("SSSS");
              listdata3 = user3.paginateData.data;
            }
          });
        }
        else {
          print("SSSS1234");
        }
      } else {
        setState(() {
          resultvalue3 = false;
        });

      }
    } else {

    }
  }


  void addItemToList(){
    setState(() {
      names.insert(0,  Controllers.item_name.text);
      units.insert(0,  Controllers.item_units.text);
      rate.insert(0,  Controllers.item_rate.text);
      quantity.insert(0,  Controllers.item_quantity.text);
      amount.insert(0,  Controllers.item_amount.text);

      List <int> lint = quantity.map(int.parse).toList();
      var sum = 0;

      for (var i = 0; i < lint.length; i++) {
        sum += lint[i];
      }

      print("Sum : ${sum}");
      Controllers.itemadd_quantity.text=sum.toString();





      List <int> lint1 = amount.map(int.parse).toList();
      var sum1 = 0;

      for (var i = 0; i < lint1.length; i++) {
        sum1 += lint1[i];
      }

      print("Sum : ${sum1}");
      Controllers.itemadd_amount.text=sum1.toString();

    });
  }

  void function() {
  }
  _launchPdfURL() async {
    String url =
        'https://shankraresearch.com/itemsales/' + _userId.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL() async {
    String url =
        'http://shankraresearch.com/itemSalesExcel' + _userId.toString();
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
        message = "added";
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
