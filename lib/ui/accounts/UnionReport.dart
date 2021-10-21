import 'dart:async';

import 'package:dairy_newdeskapp/model/UnionListResponse.dart';
import 'package:dairy_newdeskapp/model/UnionSaleFilter.dart';
import 'package:dairy_newdeskapp/ui/task/DeleteMilkResponse.dart';
import 'package:dairy_newdeskapp/ui/task/EditDispatch.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnionReport extends StatefulWidget {
  @override
  UnionReportState createState() => UnionReportState();
}

class UnionReportState extends State<UnionReport> {
  int select, valueRadio;
  String radioButtonItem = 'Item Purchase';
  final dateController = TextEditingController();
  final dateController1 = TextEditingController();
  // Group Value for Radio Button.
  int id = 1;
  Timer timer;
  int _userId;
  UnionListResponse user1;
  var listdata1;
  bool resultvalue1 = true;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  List<int> _selected_box = List();
  var tmpArray = [];
  String s;
  TextEditingController vendorCode = TextEditingController();
  int pageNumber = 1;
  var listdataitem;
  bool resultvalueitem = true;
  UnionSaleFilter useritem;
  String type = 'normal';
  static ScrollController _listViewController;
  @override
  Future<void> initState() {
    _listViewController = new ScrollController()..addListener(function);
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _loadID());
  }
  void function() {
  }
  @override
  void dispose() {
    _listViewController.dispose();
    timer.cancel();
    super.dispose();
  }

  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      if (type == 'normal') {
        getSUBdata(_userId,pageNumber);
        paginationApi();

      } else {
        getItemFilterList();
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
                                              SizeConfig.blockSizeVertical * 60,
                                          width:
                                              SizeConfig.blockSizeVertical * 40,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: <Widget>[
                                                InkWell(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
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
                                                        'Dairy Code',
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

                                                                initialDate: DateTime.now(),
                                                                firstDate: DateTime(1900),
                                                                lastDate: DateTime(2100));

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
                                                                    DateTime(
                                                                        2100));
                                                        final DateFormat formatter = DateFormat('dd-MM-yyy');
                                                        final String formatted = formatter.format(date);

                                                        dateController1.text = formatted.toString().substring(0, 10);
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
                                                    getItemFilterList();
                                                  },
                                                  child: Container(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                    height: SizeConfig
                                                            .blockSizeVertical *
                                                        5,
                                                    margin: EdgeInsets.only(
                                                      top: 15,
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
                        left: SizeConfig.blockSizeHorizontal * 1),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Union Sale Report',
                      style: TextStyle(
                          color: AppColors.allaccounttextcolor,
                          fontSize: SizeConfig.blockSizeVertical * 3),
                    ),
                  ),
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
                      width: SizeConfig.blockSizeHorizontal * 76,
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  8,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'DAIRY',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'AVG FAT',
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
                                                  8,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'AVG SNF',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'AVG CLR',
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
                                                  6,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'No of cans',
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
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
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      bottomRight: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      topLeft: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      topRight: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                    ),
                                  )),
                              type == 'normal'
                                  ? listdata1 != null
                                      ? Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  80,
                                          height:
                                              SizeConfig.blockSizeVertical * 50,
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user1.paginateData.data
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
                                                            6,
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user1.paginateData.data
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
                                                            6,
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user1.paginateData.data
                                                              .elementAt(index)
                                                              .dairyCode,
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
                                                          user1.paginateData.data
                                                              .elementAt(index)
                                                              .avgFat,
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
                                                          user1.paginateData.data
                                                              .elementAt(index)
                                                              .avgSnf,
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
                                                          user1.paginateData.data
                                                              .elementAt(index)
                                                              .avgClr,
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
                                                            4,
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          user1.paginateData.data
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
                                                          user1.paginateData.data
                                                              .elementAt(index)
                                                              .weight,
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
                                                          user1.paginateData.data
                                                              .elementAt(index)
                                                              .noOfCans,
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
                                                          user1.paginateData.data
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
                                                      InkWell(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              'EDIT',
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontSize: 15),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: AppColors
                                                                        .yellow),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          nextscreen(user1.paginateData.data
                                                              .elementAt(index)
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
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  80,
                                          height:
                                              SizeConfig.blockSizeVertical * 50,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: ListView.builder(
                                                itemCount:
                                                    listdataitem.length == null
                                                        ? 0
                                                        : listdataitem.length,
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
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          useritem.data
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
                                                            6,
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          useritem.data
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
                                                            6,
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          useritem.data
                                                              .elementAt(index)
                                                              .dairyCode,
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
                                                          useritem.data
                                                              .elementAt(index)
                                                              .avgFat,
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
                                                          useritem.data
                                                              .elementAt(index)
                                                              .avgSnf,
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
                                                          useritem.data
                                                              .elementAt(index)
                                                              .avgClr,
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
                                                            4,
                                                        margin: EdgeInsets.only(
                                                          left: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              1,
                                                        ),

                                                        //   width: MediaQuery.of(context).size.width/2,
                                                        child: Text(
                                                          useritem.data
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
                                                          useritem.data
                                                              .elementAt(index)
                                                              .weight,
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
                                                          useritem.data
                                                              .elementAt(index)
                                                              .noOfCans,
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
                                                          useritem.data
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
                                                      InkWell(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              'EDIT',
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontSize: 15),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: AppColors
                                                                        .yellow),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          nextscreen(useritem
                                                              .data
                                                              .elementAt(index)
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
                                              : Center(child: Text("No Data")),
                                        )
                            ],
                          )))
                ],
              ),
            )),
      ),
    );
  }

  void nextscreen(int ids) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDispatch(ids)),
    );
  }

  void getCheckValues(int index) {
    if (_selected_box.contains(index)) {
      _selected_box.remove(index);
      tmpArray.remove(user1.paginateData.data.elementAt(index).id);
    } else {
      _selected_box.add(index);
      tmpArray.add(user1.paginateData.data.elementAt(index).id);
    }

    s = tmpArray.join(',');
  }

  Future<void> getMilkCollections(
    int user_id,int page) async {
    final formData = {'user_id': user_id,'page':page};
    Dialogs.showLoadingDialog(context, _keyLoader);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportdispatchlist',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      user1 = UnionListResponse.fromJson(responseData.data);
      if(user1.status==200){
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        setState(() {
          type = 'normal';
          resultvalue1 = true;
          listdata1 = user1.paginateData.data;
        });
        }
    }
      catch (e) {
      setState(() {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        type = 'normal';
        resultvalue1 = false;
      });
    }
  }

  Future<void> getSUBdata(
      int user_id,int page) async {
    final formData = {'user_id': user_id,'page':page};

    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportdispatchlist',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      user1 = UnionListResponse.fromJson(responseData.data);
      if(user1.status==200){

        setState(() {
          type = 'normal';
          resultvalue1 = true;
          listdata1 = user1.paginateData.data;
        });
      }
    }
    catch (e) {
      setState(() {

        type = 'normal';
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
             getSUBdata(_userId, pageNumber);
            }
          }
          else{
          getSUBdata(_userId,pageNumber);
          }
        });
      }
    });
  }




  Future<void> getItemFilterList(
    ) async {
    final formData = {
      'dairy_code': vendorCode.text,
      'from': dateController.text,
      'to': dateController1.text,
      'user_id': _userId,
    };

    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/reportfilterdispatch',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      useritem = UnionSaleFilter.fromJson(responseData.data);
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

  Future<void> deleteEntry(
      GlobalKey<State<StatefulWidget>> keyLoader, String user_id) async {
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
      DeleteMilkResponse user2 = DeleteMilkResponse.fromJson(responseData.data);
      setState(() {
        getMilkCollections(_userId,pageNumber);

        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user2.message)));
      });
    } catch (e) {
      setState(() {});
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
