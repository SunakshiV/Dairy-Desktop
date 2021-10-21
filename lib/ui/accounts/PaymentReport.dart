import 'dart:async';

import 'package:dairy_newdeskapp/model/EditPaymentSale.dart';
import 'package:dairy_newdeskapp/model/ItemSaleListResponse.dart';
import 'package:dairy_newdeskapp/model/PaymentCreditResponse.dart';
import 'package:dairy_newdeskapp/ui/task/DeleteMilkResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditPaymentDebitSale.dart';

class PaymentReport extends StatefulWidget {
  @override
  PaymentReportState createState() => PaymentReportState();
}

class PaymentReportState extends State<PaymentReport> {
  int select, valueRadio;
  String radioButtonItem = 'Credit Report';
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  bool purchasetype = false;

  // Group Value for Radio Button.
  int id = 1;
  Timer timer;
  int _userId;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  ItemSaleListResponse user1;
  var listdata1;
  bool resultvalue1 = true;
  PaymentCreditResponse user2;
  var listdata2;
  bool resultvalue2 = true;

  List<int> _selected_box = List();
  var tmpArray = [];
  String s;

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
        getItemCollections(_keyLoader, _userId);
      } else {
        getMilkCollections(_keyLoader, _userId);
      }
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
                                                      child: TextField(
                                                        decoration: InputDecoration(
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
                                                      child: TextField(
                                                        decoration: InputDecoration(
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
                                                        dateController.text =
                                                            date
                                                                .toString()
                                                                .substring(
                                                                    0, 10);
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
                                                                    DateTime(
                                                                        2100));
                                                        dateController1.text =
                                                            date
                                                                .toString()
                                                                .substring(
                                                                    0, 10);
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
                                                Container(
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
                                                        color: AppColors.white,
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
                                radioButtonItem = 'Credit Report';
                                id = 1;
                                purchasetype = true;
                              });
                            },
                          ),
                          Text(
                            'Credit Report',
                            style: new TextStyle(
                                fontSize: 17.0,
                                color: AppColors.allaccounttextcolor),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Debit Report';
                                id = 2;
                              });
                            },
                          ),
                          Text(
                            'Debit Report',
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
                              ),
                              height: SizeConfig.blockSizeVertical * 60,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  70,
                                          height:
                                              SizeConfig.blockSizeVertical * 5,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
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
                                                      6,
                                                  margin: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1,
                                                  ),

                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  child: Text(
                                                    'BILL NUMBER',
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
                                                    'NOTES',
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
                                      listdata2 != null
                                          ? Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  75,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      50,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: ListView.builder(
                                                    itemCount:
                                                        listdata2.length == null
                                                            ? 0
                                                            : listdata2.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Row(
                                                        children: [
                                                          Checkbox(
                                                            value: _selected_box
                                                                .contains(
                                                                    index),
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .date,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .time,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .vendorCode,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .vendorName,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .billNumber,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notes,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .amount,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                              alignment:
                                                                  Alignment
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
                                                                        4),
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
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .yellow),
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
                                          : Container()
                                    ],
                                  )))
                          : Container(
                              width: SizeConfig.blockSizeHorizontal * 80,
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                              ),
                              height: SizeConfig.blockSizeVertical * 60,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  70,
                                          height:
                                              SizeConfig.blockSizeVertical * 5,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
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
                                                      6,
                                                  margin: EdgeInsets.only(
                                                    left: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1,
                                                  ),

                                                  //   width: MediaQuery.of(context).size.width/2,
                                                  child: Text(
                                                    'BILL NUMBER',
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
                                                    'NOTES',
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
                                      listdata2 != null
                                          ? Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  75,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      50,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: ListView.builder(
                                                    itemCount:
                                                        listdata2.length == null
                                                            ? 0
                                                            : listdata2.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Row(
                                                        children: [
                                                          Checkbox(
                                                            value: _selected_box
                                                                .contains(
                                                                    index),
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .date,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .time,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .vendorCode,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .vendorName,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .billNumber,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .notes,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                            alignment: Alignment
                                                                .center,
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
                                                              user2.data
                                                                  .elementAt(
                                                                      index)
                                                                  .amount,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
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
                                                              alignment:
                                                                  Alignment
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
                                                                        4),
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
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .yellow),
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
                                          : Container()
                                    ],
                                  ))))
                ],
              ),
            )),
      ),
    );
  }

  void getCheckValues(int index) {
    if (id == 1) {
      if (_selected_box.contains(index)) {
        _selected_box.remove(index);
        tmpArray.remove(user2.data.elementAt(index).id);
      } else {
        _selected_box.add(index);
        tmpArray.add(user2.data.elementAt(index).id);
      }

      s = tmpArray.join(',');
    } else {
      if (_selected_box.contains(index)) {
        _selected_box.remove(index);
        tmpArray.remove(user2.data.elementAt(index).id);
      } else {
        _selected_box.add(index);
        tmpArray.add(user2.data.elementAt(index).id);
      }

      s = tmpArray.join(',');
    }
  }

  void nextscreen(int ids) {
    if (id == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditPaymentSale(ids)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditPaymentDebitSale(ids)),
      );
    }
  }

  Future<void> getMilkCollections(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id, 'credit_debit': 'debit'};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportdesktoppayments_list',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user2 = PaymentCreditResponse.fromJson(responseData.data);
      setState(() {
        //type = 'normal';
        resultvalue2 = true;
        listdata2 = user2.data;
      });
    } catch (e) {
      setState(() {
        resultvalue2 = false;
      });
    }
  }

  Future<void> getItemCollections(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id, 'credit_debit': 'credit'};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportdesktoppayments_list',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user2 = PaymentCreditResponse.fromJson(responseData.data);
      setState(() {
        //type = 'normal';
        resultvalue2 = true;
        listdata2 = user2.data;
      });
    } catch (e) {
      setState(() {
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
            '/api/deletedesktoppayments',
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
            '/api/deletedesktoppayments',
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
      setState(() {
        //  resultvalue1 = false;
      });
    }
  }
}
