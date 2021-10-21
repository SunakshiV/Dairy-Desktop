import 'dart:async';

import 'package:dairy_newdeskapp/model/EditStockSale.dart';
import 'package:dairy_newdeskapp/model/GetVendorNameResponse.dart';
import 'package:dairy_newdeskapp/model/ItemPurchaseFilter.dart';
import 'package:dairy_newdeskapp/model/MilkCollcetionGetResponse.dart';
import 'package:dairy_newdeskapp/model/MilkPurchaseFilter.dart';
import 'package:dairy_newdeskapp/model/StockListResponse.dart';
import 'package:dairy_newdeskapp/ui/task/Bonus.dart';
import 'package:dairy_newdeskapp/ui/task/DeleteMilkResponse.dart';
import 'package:dairy_newdeskapp/ui/task/EditMilkCollection.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseReport extends StatefulWidget {
  @override
  PurchaseReportState createState() => PurchaseReportState();
}

class PurchaseReportState extends State<PurchaseReport> {
  int select, valueRadio;
  String radioButtonItem = 'Item Purchase';
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  bool purchasetype = false;

  // Group Value for Radio Button.
  int id = 1;
  Timer timer;
  int _userId;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  MilkCollcetionGetResponse user1;
  var listdata1;
  bool resultvalue1 = true;
  StockListResponse user2;
  var listdata2;
  bool resultvalue2 = true;
  var listdataitem;
  bool resultvalueitem = true;
  var listdatamilk;
  bool resultvaluemilk = true;
  List<int> _selected_box = List();

  List<bool> isChecked = List.generate(10, (index) => false);
  String type = "normal";
  var tmpArray = [];
  String s;
  TextEditingController vendorCode = TextEditingController();
  TextEditingController vendorName = TextEditingController();
  String textValue;
  Timer timeHandle;
  ItemPurchaseFilter useritem;
  MilkPurchaseFilter usermilk;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      if (id == 1) {
        if (type == 'normal') {

          getItemCollections(_keyLoader, _userId);

        } else {
          getItemFilterList(_keyLoader);
        }
      } else {
        if (type == 'normal') {
          getMilkCollections(_keyLoader, _userId);
        } else {
          getMilkFilterList(_keyLoader);
        }
      }
    });
  }

  void textChanged(String val) {
    textValue = val;
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(seconds: 1), () {
      getVedorName(_keyLoader, textValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        child: Card(
            color: AppColors.accountbgcolor,
            elevation: 10,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
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
                                          height:
                                              SizeConfig.blockSizeVertical * 70,
                                          width:
                                              SizeConfig.blockSizeVertical * 40,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: <Widget>[
                                                InkWell(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Icon(Icons.clear),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Image.asset(
                                                  'assests/image/logofilter.png',
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      10,
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      10,
                                                ),
                                                Container(
                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      17,
                                                  color: AppColors.white,
                                                  child:
                                                      Column(children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10, left: 10),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'Code',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          5,
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: <
                                                            TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        onChanged: textChanged,
                                                        controller: vendorCode,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .top,
                                                        textAlign:
                                                            TextAlign.left,
                                                        decoration: InputDecoration(
                                                            labelStyle: TextStyle(
                                                                color: AppColors
                                                                    .black),
                                                            labelText:
                                                                'type here',
                                                            hoverColor:
                                                                AppColors
                                                                    .lightBlue,
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                Container(
                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      17,
                                                  color: AppColors.white,
                                                  child:
                                                      Column(children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10, left: 10),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'Name',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          5,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: TextFormField(
                                                        controller: vendorName,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .top,
                                                        textAlign:
                                                            TextAlign.left,
                                                        decoration: InputDecoration(
                                                            labelStyle: TextStyle(
                                                                color: AppColors
                                                                    .black),
                                                            labelText: '',
                                                            hoverColor:
                                                                AppColors
                                                                    .lightBlue,
                                                            border:
                                                                OutlineInputBorder()),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                Container(
                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      17,
                                                  color: AppColors.white,
                                                  child:
                                                      Column(children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10, left: 10),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'From Date',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        var date =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        1900),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100));


                                                        final DateFormat formatter = DateFormat('dd-MM-yyy');
                                                        final String formatted = formatter.format(date);

                                                        dateController.text = formatted.toString().substring(0, 10);
                                                      },
                                                      child: Container(
                                                          height: SizeConfig
                                                                  .blockSizeVertical *
                                                              5,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: GestureDetector(
                                                              child: new IgnorePointer(
                                                            child: TextField(
                                                              enableInteractiveSelection:
                                                                  false,
                                                              readOnly: true,
                                                              controller:
                                                                  dateController,
                                                              decoration: InputDecoration(
                                                                  labelText: '',
                                                                  hoverColor:
                                                                      AppColors
                                                                          .lightBlue,
                                                                  border:
                                                                      OutlineInputBorder()),
                                                            ),
                                                          ))),
                                                    )
                                                  ]),
                                                ),
                                                Container(
                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      17,
                                                  color: AppColors.white,
                                                  child:
                                                      Column(children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10, left: 10),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'To Date',
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        var date =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        1900),
                                                                lastDate:
                                                                    DateTime( 2100));


                                                        final DateFormat formatter = DateFormat('dd-MM-yyy');
                                                        final String formatted = formatter.format(date);

                                                        dateController1.text = formatted.toString().substring(0, 10);
                                                      },
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          height: SizeConfig
                                                                  .blockSizeVertical *
                                                              5,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: GestureDetector(
                                                              child: new IgnorePointer(
                                                            child: TextField(
                                                              enableInteractiveSelection:
                                                                  false,
                                                              readOnly: true,
                                                              controller:
                                                                  dateController1,
                                                              decoration: InputDecoration(
                                                                  labelText: '',
                                                                  hoverColor:
                                                                      AppColors
                                                                          .lightBlue,
                                                                  border:
                                                                      OutlineInputBorder()),
                                                            ),
                                                          ))),
                                                    )
                                                  ]),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    if (id == 1) {
                                                      getItemFilterList(
                                                          _keyLoader);
                                                    } else {
                                                      getMilkFilterList(
                                                          _keyLoader);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        5,
                                                    margin: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 18),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      gradient: LinearGradient(
                                                        colors: <Color>[
                                                          Color(0xFF0D47A1),
                                                          Color(0xFF1976D2),
                                                          Color(0xFF42A5F5),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
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
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 6,
                        height: SizeConfig.blockSizeVertical * 6,
                        child: Icon(Icons.filter_list_sharp)),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: 20, left: SizeConfig.blockSizeHorizontal * 1),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Item Purchase';
                                id = 1;
                                purchasetype = true;
                              });
                            },
                          ),
                          Text(
                            'Item Purchase',
                            style: new TextStyle(
                                fontSize: 17.0,
                                color: AppColors.allaccounttextcolor),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Milk Purchase';
                                id = 2;
                              });
                            },
                          ),
                          Text(
                            'Milk Purchase',
                            style: new TextStyle(
                                fontSize: 17.0,
                                color: AppColors.allaccounttextcolor),
                          ),
                        ],
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
                                                            children: <Widget>[
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
                                                                  height: SizeConfig
                                                                          .blockSizeVertical *
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
                                                                  height: SizeConfig
                                                                          .blockSizeVertical *
                                                                      5,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20,
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
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
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
                              onTap: () {},
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
                      width: SizeConfig.blockSizeHorizontal * 78,
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                      ),
                      height: SizeConfig.blockSizeVertical * 60,
                      child: (id == 1)
                          ? Container(
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  75,
                                          height:
                                              SizeConfig.blockSizeVertical * 5,
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
                                                    'DATE',
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
                                                    'TIME',
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
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      6,

                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  child: Text(
                                                    'VENDOR CODE',
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
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      11,
                                                  margin: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1,
                                                  ),

                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  child: Text(
                                                    'VENDOR NAME',
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
                                                    'ITEM',
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
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      11,
                                                  margin: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1,
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
                                                    'AMOUNT',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: (SizeConfig
                                                              .blockSizeVertical *
                                                          1.3),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
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
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                              bottomRight: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                              topLeft: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                              topRight: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                            ),
                                          )),
                                      type == 'normal'
                                          ? listdata2 != null
                                              ? Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      80,
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      50,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: ListView.builder(
                                                        itemCount: listdata2
                                                                    .length ==
                                                                null
                                                            ? 0
                                                            : listdata2.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Row(
                                                            children: [
                                                              Checkbox(
                                                                value: _selected_box
                                                                    .contains(
                                                                        index),
                                                                //index is the position of the checkbox
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    getCheckValues(
                                                                        index);
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
                                                                    6,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user2.paginateData.data
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
                                                                    6,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user2.paginateData.data
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
                                                                    6,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user2.paginateData.data
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
                                                                    13,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user2.paginateData.data
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
                                                                    8,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user2.paginateData.data
                                                                      .elementAt(
                                                                          index)
                                                                      .type,
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
                                                                    12,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user2.paginateData.data
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
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    9,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user2.paginateData.data
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
                                                                    height:
                                                                        SizeConfig.blockSizeVertical *
                                                                            3,
                                                                    margin: EdgeInsets.only(
                                                                        left: SizeConfig.blockSizeHorizontal *
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
                                                                  nextscreen(user2.paginateData.data
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
                                          : listdataitem != null
                                              ? Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      80,
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      50,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: ListView.builder(
                                                        itemCount: listdataitem
                                                                    .length ==
                                                                null
                                                            ? 0
                                                            : listdataitem
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Row(
                                                            children: [
                                                              Checkbox(
                                                                value: _selected_box
                                                                    .contains(
                                                                        index),
                                                                //index is the position of the checkbox
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    getCheckValues(
                                                                        index);
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
                                                                    6,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  useritem.data
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
                                                                    6,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  useritem.data
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
                                                                    6,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  useritem.data
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
                                                                    13,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  useritem.data
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
                                                                    8,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  useritem.data
                                                                      .elementAt(
                                                                          index)
                                                                      .type,
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
                                                                    12,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  useritem.data
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
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    9,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  useritem.data
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
                                                                    height:
                                                                        SizeConfig.blockSizeVertical *
                                                                            3,
                                                                    margin: EdgeInsets.only(
                                                                        left: SizeConfig.blockSizeHorizontal *
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
                                                                  nextscreen(user2.paginateData.data
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
                                                  child: resultvalueitem == true
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : Center(
                                                          child:
                                                              Text("No Data")),
                                                )
                                    ],
                                  )))
                          : Container(
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  75,
                                          height:
                                              SizeConfig.blockSizeVertical * 5,
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
                                                    'DATE',
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
                                                    'TIME',
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
                                                    'SHIFT',
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
                                                    'CATTLE TYPE',
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
                                                    'VENDOR CODE',
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
                                                    'VENDOR NAME',
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
                                                    'FAT',
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
                                                    'SNF',
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
                                                    'CLR',
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
                                                    'WEIGHT',
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
                                                    'AMOUNT',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: (SizeConfig
                                                              .blockSizeVertical *
                                                          1.3),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      5,
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
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                              bottomRight: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                              topLeft: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                              topRight: Radius.circular(
                                                  SizeConfig
                                                          .blockSizeHorizontal *
                                                      0.3),
                                            ),
                                          )),
                                      type == 'normal'
                                          ? listdata1 != null
                                              ? Container(
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      80,
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      50,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: ListView.builder(
                                                        itemCount: listdata1
                                                                    .length ==
                                                                null
                                                            ? 0
                                                            : listdata1.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Row(
                                                            children: [
                                                              /*  Radio(
                                                          activeColor: AppColors
                                                              .lightBlue,
                                                          value: index,
                                                          groupValue: select,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              valueRadio =
                                                                  index;
                                                              select = value;
                                                              print(user1.data
                                                                  .elementAt(
                                                                      index)
                                                                  .id
                                                                  .toString());
                                                              dltid = user1.data
                                                                  .elementAt(
                                                                      index)
                                                                  .id;
                                                            });
                                                          },
                                                        ),*/

                                                              Checkbox(
                                                                value: _selected_box
                                                                    .contains(
                                                                        index),
                                                                //index is the position of the checkbox
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    getCheckValues(
                                                                        index);
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user1.paginateData.data
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user1.paginateData.data
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user1.paginateData.data
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user1.paginateData.data
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user1.paginateData.data
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user1.paginateData.data
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .blockSizeHorizontal *
                                                                      1,
                                                                ),

                                                                //   width: MediaQuery.of(context).size.width/2,
                                                                child: Text(
                                                                  user1.paginateData.data.elementAt(index).clr ==
                                                                              null ||
                                                                      user1.paginateData.data.elementAt(index).clr ==
                                                                              "0"
                                                                      ? "0"
                                                                      :  user1.paginateData.data
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
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
                                                                    height:
                                                                        SizeConfig.blockSizeVertical *
                                                                            3,
                                                                    margin: EdgeInsets.only(
                                                                        left: SizeConfig.blockSizeHorizontal *
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
                                                          child:
                                                              Text("No Data")),
                                                )
                                          : type == 'normal'
                                              ? listdata1 != null
                                                  ? Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          80,
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          50,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: ListView.builder(
                                                            itemCount: listdata1
                                                                        .length ==
                                                                    null
                                                                ? 0
                                                                : listdata1
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Row(
                                                                children: [
                                                                  /*  Radio(
                                                          activeColor: AppColors
                                                              .lightBlue,
                                                          value: index,
                                                          groupValue: select,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              valueRadio =
                                                                  index;
                                                              select = value;
                                                              print(user1.data
                                                                  .elementAt(
                                                                      index)
                                                                  .id
                                                                  .toString());
                                                              dltid = user1.data
                                                                  .elementAt(
                                                                      index)
                                                                  .id;
                                                            });
                                                          },
                                                        ),*/

                                                                  Checkbox(
                                                                    value: _selected_box
                                                                        .contains(
                                                                            index),
                                                                    //index is the position of the checkbox
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        getCheckValues(
                                                                            index);
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .date,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .time,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .shift,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .cattleType,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .vendorNumber,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .vendorName,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .fat,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .snf,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data.elementAt(index).clr == null ||
                                                                          user1.paginateData.data.elementAt(index).clr ==
                                                                                  "0"
                                                                          ? "0"
                                                                          :  user1.paginateData.data
                                                                              .elementAt(index)
                                                                              .clr,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .weight,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .rate,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      user1.paginateData.data
                                                                          .elementAt(
                                                                              index)
                                                                          .amount,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
                                                                              1.3),
                                                                          letterSpacing:
                                                                              1.0),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                4,
                                                                        height:
                                                                            SizeConfig.blockSizeVertical *
                                                                                3,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                SizeConfig.blockSizeHorizontal * 1.5),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          'EDIT',
                                                                          style: TextStyle(
                                                                              color: AppColors.white,
                                                                              fontSize: 15),
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(color: AppColors.yellow),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: resultvalue1 ==
                                                              true
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : Center(
                                                              child: Text(
                                                                  "No Data")),
                                                    )
                                              : listdatamilk != null
                                                  ? Container(
                                                      width: SizeConfig
                                                              .blockSizeHorizontal *
                                                          80,
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          50,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: ListView.builder(
                                                            itemCount: listdatamilk
                                                                        .length ==
                                                                    null
                                                                ? 0
                                                                : listdatamilk
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Row(
                                                                children: [
                                                                  /*  Radio(
                                                          activeColor: AppColors
                                                              .lightBlue,
                                                          value: index,
                                                          groupValue: select,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              valueRadio =
                                                                  index;
                                                              select = value;
                                                              print(user1.data
                                                                  .elementAt(
                                                                      index)
                                                                  .id
                                                                  .toString());
                                                              dltid = user1.data
                                                                  .elementAt(
                                                                      index)
                                                                  .id;
                                                            });
                                                          },
                                                        ),*/

                                                                  Checkbox(
                                                                    value: _selected_box
                                                                        .contains(
                                                                            index),
                                                                    //index is the position of the checkbox
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        getCheckValues(
                                                                            index);
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .date,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .time,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .shift,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .cattleType,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .vendorNumber,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .vendorName,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .fat,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .snf,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk.data.elementAt(index).clr == null ||
                                                                              usermilk.data.elementAt(index).clr ==
                                                                                  "0"
                                                                          ? "0"
                                                                          : usermilk
                                                                              .data
                                                                              .elementAt(index)
                                                                              .clr,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .weight,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .rate,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
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
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              1,
                                                                    ),

                                                                    //   width: MediaQuery.of(context).size.width/2,
                                                                    child: Text(
                                                                      usermilk
                                                                          .data
                                                                          .elementAt(
                                                                              index)
                                                                          .amount,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontSize: (SizeConfig.blockSizeVertical *
                                                                              1.3),
                                                                          letterSpacing:
                                                                              1.0),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                4,
                                                                        height:
                                                                            SizeConfig.blockSizeVertical *
                                                                                3,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                SizeConfig.blockSizeHorizontal * 1.5),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          'EDIT',
                                                                          style: TextStyle(
                                                                              color: AppColors.white,
                                                                              fontSize: 15),
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(color: AppColors.yellow),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      nextscreen(usermilk
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: resultvaluemilk ==
                                                              true
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : Center(
                                                              child: Text(
                                                                  "No Data")),
                                                    )
                                    ],
                                  ))))
                ],
              ),
            )),
      ),
    );
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
          vendorName.text = user1.data.elementAt(0).vendorName;
        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        vendorCode.text = '';
      }
    } catch (e) {
      vendorName.text = '';
      final errorMessage = DioExceptions1.fromDioError(e, context);

      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  void getCheckValues(int index) {
    if (id == 1) {
      //  for (var i = 0; i < _selected_box.length; i++) _selected_box[i] = true;
      for (int i = 0; i < 4; i++) {
        isChecked[i] = true;
      }
      if (_selected_box.contains(index)) {
        _selected_box.remove(index);
        tmpArray.remove(user2.paginateData.data.elementAt(index).id);
      } else {
        _selected_box.add(index);
        tmpArray.add(user2.paginateData.data.elementAt(index).id);
      }

      s = tmpArray.join(',');
    } else {
      if (_selected_box.contains(index)) {
        _selected_box.remove(index);
        tmpArray.remove( user1.paginateData.data.elementAt(index).id);
      } else {
        _selected_box.add(index);
        tmpArray.add( user1.paginateData.data.elementAt(index).id);
      }

      s = tmpArray.join(',');
    }
  }

  void nextscreen(int ids) {
    if (id == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditStockSale(ids)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditMilkCollection(ids)),
      );
    }
  }

  Future<void> getMilkCollections(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/milkcollectionlistreport',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user1 = MilkCollcetionGetResponse.fromJson(responseData.data);
      setState(() {
        type = 'normal';
        resultvalue1 = true;
        listdata1 =  user1.paginateData.data;
      });
    } catch (e) {
      setState(() {
        type = 'normal';
        resultvalue1 = false;
      });
    }
  }

  Future<void> getItemCollections(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportstockupdateslist',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user2 = StockListResponse.fromJson(responseData.data);
      setState(() {
        type = 'normal';
        resultvalue2 = true;
        listdata2 = user2.paginateData.data;
      });
    } catch (e) {
      setState(() {
        type = 'normal';
        resultvalue2 = false;
      });
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

      if (id == 1) {
        final responseData = await _dio.post<Map<String, dynamic>>(
            '/api/deletestockupdates',
            options: RequestOptions(
                method: 'POST',
                headers: <String, dynamic>{},
                baseUrl: ApiBaseUrl.base_url),
            data: formData);
        DeleteMilkResponse user2 =
            DeleteMilkResponse.fromJson(responseData.data);
        setState(() {
          getItemCollections(_keyLoader, _userId);

          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user2.message)));
        });
      } else {
        final responseData = await _dio.post<Map<String, dynamic>>(
            '/api/deleteMilkcollection',
            options: RequestOptions(
                method: 'POST',
                headers: <String, dynamic>{},
                baseUrl: ApiBaseUrl.base_url),
            data: formData);
        DeleteMilkResponse user2 =
            DeleteMilkResponse.fromJson(responseData.data);
        setState(() {
          getMilkCollections(_keyLoader, _userId);

          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user2.message)));
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> getItemFilterList(
      GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'vendor_name': vendorName.text,
      'from': dateController.text,
      'to': dateController1.text,
      'user_id': _userId,
    };
    print("my sending data"+formData.toString());
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportfilterstockupdate',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      useritem = ItemPurchaseFilter.fromJson(responseData.data);
      setState(() {
        type = 'filter';
        resultvalueitem = true;
        listdataitem = useritem.data;
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      setState(() {
        type = 'filter';
        resultvalueitem = false;
      });
    }
  }

  Future<void> getMilkFilterList(
      GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'vendor_name': vendorName.text,
      'from': dateController.text,
      'to': dateController1.text,
      'user_id': _userId,


    };

    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportfilter1',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      usermilk = MilkPurchaseFilter.fromJson(responseData.data);
      setState(() {
        type = 'filter';
        resultvaluemilk = true;
        listdatamilk = usermilk.data;
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      setState(() {
        type = 'filter';
        resultvaluemilk = false;
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
