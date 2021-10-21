import 'dart:async';
import 'dart:convert';

import 'package:dairy_newdeskapp/model/AccountFilterResponse.dart';
import 'package:dairy_newdeskapp/model/AddToFvrtResponse.dart';
import 'package:dairy_newdeskapp/model/GetAccountsResponse.dart';
import 'package:dairy_newdeskapp/model/GetAddToFvrtResponse.dart';
import 'package:dairy_newdeskapp/model/GetVendorNameResponse.dart';
import 'package:dairy_newdeskapp/ui/task/DeleteMilkResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'EditAccounts.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BankAccounts extends StatefulWidget {
  @override
  BankAccountsState createState() => BankAccountsState();
}

class BankAccountsState extends State<BankAccounts> {
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int _userId;
  var listdata1;
  bool resultvalue1 = true;
  int page=1;
  String val;
  var storelist_length;
  GetAccountsResponse requestpojo;
  int pageNumber = 1;
  int totalPage = 1;
  bool isLoading = false;
  static ScrollController _listViewController;
  bool resultvalueitem = true;
  String type = "normal";
  var listdataitem;
  AccountFilterResponse useritem;
  String textValue;
  Timer timeHandle;
  TextEditingController vendorCode = TextEditingController();
  TextEditingController vendorName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String s;
  List<int> _selected_box = List();
  var tmpArray = [];

  String isfvrt;
  bool fav;
  @override
  Future<void> initState() {
    _listViewController = new ScrollController()..addListener(function);
    super.initState();
    _loadID();
  }
  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
  }
  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      gettabfvrt();
      if(type=='normal'){
        getdata(_userId, pageNumber);
        paginationApi();
      }
      else {
        getAccountFilterData(_userId);
      }



    });
  }

  int select, valueRadio;
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
                                                        'vendorcode'.tr,
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
                                                        'vendorname'.tr,
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
                                                        'phonenumber'.tr,
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
                                                        controller: phoneNumber,
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
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    getAccountFilterData(_userId);
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
                            'bankaccounts'.tr,
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: SizeConfig.blockSizeVertical * 2),
                          ),
                        ),




                        fav==true? Container(
                          padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                          alignment: Alignment.topLeft,
                          child:FavoriteButton(
                            iconSize: 4,
                            isFavorite: true,
                            // iconDisabledColor: Colors.white,
                            valueChanged: (_isFavorite) {
                              print("FAv: "+_isFavorite.toString());
                              addFvrt(_isFavorite);
                            },
                          ),
                        ):
                        fav==false? Container(
                          padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 0.5),
                          alignment: Alignment.topLeft,
                          child:FavoriteButton(
                            iconSize: 4,
                            isFavorite: false,
                            // iconDisabledColor: Colors.white,
                            valueChanged: (_isFavorite) {
                              print("FAv: "+_isFavorite.toString());
                              addFvrt(_isFavorite);
                            },
                          ),
                        ):Container()



                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 4),
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
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3,
                        ),
                        child: Text(
                          'exportto'.tr,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchPdfURL();
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 3,
                                right: SizeConfig.blockSizeHorizontal * 2,
                                left: SizeConfig.blockSizeHorizontal * 1),
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 6,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assests/image/pdf.png"),
                                    fit: BoxFit.fill))),
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL();
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 3,
                              right: SizeConfig.blockSizeHorizontal * 2,
                            ),
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 6,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assests/image/cs.png"),
                                    fit: BoxFit.fill))),
                      )
                    ],
                  ),
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 80,
                      height: SizeConfig.blockSizeVertical * 80,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 2,
                                    top: SizeConfig.blockSizeVertical * 2,
                                    right: SizeConfig.blockSizeHorizontal * 2,
                                  ),
                                  width: SizeConfig.blockSizeHorizontal * 75,
                                  height: SizeConfig.blockSizeVertical * 5,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        /* Container(
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
                                        ),*/
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
                                            left:
                                                SizeConfig.blockSizeHorizontal *
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
                                                  6,
                                          margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),

                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            'address'.tr,
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
                                            'phonenumber'.tr,
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
                                            'mobilenumber'.tr,
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
                                            'gstinnumber'.tr,
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
                                            'pannumber'.tr,
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
                                            'bankbranch'.tr,
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
                                            'accountnumber'.tr,
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
                                            'ifsc'.tr,
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
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      bottomRight: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      topLeft: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                      topRight: Radius.circular(
                                          SizeConfig.blockSizeHorizontal * 0.3),
                                    ),
                                  )),

                              type=='normal' ?

                              storelist_length != null
                                  ? Container(
                                      width: SizeConfig.blockSizeHorizontal * 80,
                                      height: SizeConfig.blockSizeVertical * 70,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: ListView.builder(
                                            controller: _listViewController,
                                            itemCount: storelist_length == null
                                                ? 0
                                                : storelist_length.length,
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
                                                        getCheckValues(
                                                            index);
                                                      });
                                                    },
                                                  ),
                                                  /*  Container(

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
                                                  '',
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .vendorCode,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .vendorName,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .address,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .phoneNumber,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .mobileNumber,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .gstNumber,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .panNumber,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .bankBranch,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .accountNumber,
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
                                                      requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .ifscNumber,
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
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'edit'.tr,
                                                          style: TextStyle(
                                                              color: AppColors
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
                                                      print(requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .id);
                                                      nextscreen(requestpojo.paginateData.data
                                                          .elementAt(index)
                                                          .id);
                                                    },
                                                  )
                                                ],
                                              );
                                            }),
                                      ))
                                  : Container(
                                      margin:
                                          EdgeInsets.only(top: 50, right: 100),
                                      alignment: Alignment.center,
                                      child: resultvalue1 == true
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Center(child: Text("No Data")),
                                    ) :

                              listdataitem != null
                                  ? Container(
                                  width:
                                  SizeConfig.blockSizeHorizontal * 80,
                                  height: SizeConfig.blockSizeVertical * 50,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: ListView.builder(
                                        controller: _listViewController,
                                        itemCount: listdataitem == null
                                            ? 0
                                            : listdataitem.length,
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
                                                    getCheckValues(
                                                        index);
                                                  });
                                                },
                                              ),
                                              /*  Container(

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
                                                  '',
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .vendorCode,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .vendorName,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .address,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .phoneNumber,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .mobileNumber,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .gstNumber,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .panNumber,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .bankBranch,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .accountNumber,
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
                                                  listdataitem
                                                      .elementAt(index)
                                                      .ifscNumber,
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
                                                    alignment:
                                                    Alignment.center,
                                                    child: Text(
                                                      'edit'.tr,
                                                      style: TextStyle(
                                                          color: AppColors
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
                                                  print(listdataitem
                                                      .elementAt(index)
                                                      .id);
                                                  nextscreen(listdataitem
                                                      .elementAt(index)
                                                      .id);
                                                },
                                              )
                                            ],
                                          );
                                        }),
                                  ))
                                  : Container(
                                margin:
                                EdgeInsets.only(top: 50, right: 100),
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

  void nextscreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditAccounts(index)),
    ).then((value) => setState(() {}));
  }

  void getdata(int user_id,int page) async {
    Map data = {
      'user_id': user_id.toString(),
      'page': page.toString(),
    };

    Dialogs.showLoadingDialog(context, _keyLoader);
    print("user: " + data.toString());
    var jsonResponse = null;
    print(ApiBaseUrl.base_url +"account_list");
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/account_list", body: data);
    if (response.statusCode == 200)
    {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {

        requestpojo = new GetAccountsResponse.fromJson(jsonResponse);
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
              storelist_length = requestpojo.paginateData.data;
            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: requestpojo.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      } else {
        setState(() {
          resultvalue1 = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      Fluttertoast.showToast(
        msg: jsonDecode(val)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
  void getSUBdata(int user_id,int page) async {
    Map data = {
      'user_id': user_id.toString(),
      'page': page.toString(),
    };


    print("user: " + data.toString());
    var jsonResponse = null;
    print(ApiBaseUrl.base_url +"account_list");
    http.Response response = await http.post(ApiBaseUrl.base_url +"api/account_list", body: data);
    if (response.statusCode == 200)
    {

      jsonResponse = json.decode(response.body);
      val = response.body;
      if (jsonResponse["status"] == 200) {

        requestpojo = new GetAccountsResponse.fromJson(jsonResponse);
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
              storelist_length = requestpojo.paginateData.data;



              //  getdata(_userId,page);


            }
          });
        }
        else {
          Fluttertoast.showToast(
              msg: requestpojo.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
        }
      } else {
        setState(() {
          resultvalue1 = false;
        });
        Fluttertoast.showToast(
            msg: jsonDecode(val)["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {

      Fluttertoast.showToast(
        msg: jsonDecode(val)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
  void paginationApi() {
    _listViewController.addListener(() {
      if (_listViewController.offset >= _listViewController.position.maxScrollExtent &&
          !_listViewController.position.outOfRange) {
        setState(() {
          if (pageNumber <requestpojo.paginateData.lastPage ) {
            pageNumber += 1;
            getdata(_userId, pageNumber);
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

  values(length) {
    print(length);
  }

  Future<void> getAccountFilterData(
      int userid) async {
    final formData = {
      'code': vendorCode.text,
      'name': vendorName.text,
      'phone': phoneNumber.text,
      'user_id': _userId,
    };
    print("my sending data"+formData.toString());
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/accountapi',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      useritem = AccountFilterResponse.fromJson(responseData.data);
      setState(() {
        type = 'filter';
        resultvalueitem = true;
        listdataitem = useritem.result;
      });
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e,context);
      setState(() {
        type = 'filter';
        resultvalueitem = false;
      });
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
          vendorName.text = user1.data.elementAt(0).vendorName;
        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        vendorCode.text = '';
      }
    } catch (e) {
      vendorName.text = '';
      final errorMessage = DioExceptions.fromDioError(e, context);

      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  void function() {
  }

  _launchURL() async {
    String url =
        'http://shankraresearch.com/bankAccountCSV16' + _userId.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  _launchPdfURL() async {
    String url =
        'https://shankraresearch.com/bank/' + _userId.toString();
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
      'tab_name': 'Bank Accounts',
    };
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
        gettabfvrt();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message.toString())));
      }
      else if (user.status == 400) {
        gettabfvrt();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message.toString())));
      }
    } catch (e) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text('Tab UnMarked from Favourite')));
    }

  }

  Future<void> gettabfvrt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt(PrefConstant.user_id);
    print("UserID: "+_userId.toString());
    var formData;
    formData = {
      'user_id':_userId.toString(),
      'tab_name': 'Bank Accounts',
    };
    print('checkingfvrt1: '+formData.toString());
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getFavouriteByTabName',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{

              },
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetAddToFvrtResponse  user = GetAddToFvrtResponse.fromJson(responseData.data);
      if (user.status == 200)
      {
        setState(() {
          isfvrt=user.results.elementAt(0).isFavourite;
          if(isfvrt=="1"){
            setState(() {
              fav = true;
            });

          }
          else
          {
            setState(() {
              fav = false;
            });

          }
          print('checkingfvrt2: '+isfvrt);
          print('checkingfav: '+fav.toString());
        });

      }
      else if (user.status == 400)
      {
        print('checkingfvrt3'+isfvrt);
        fav = false;
      }
    }
    catch (e) {
      print('checkingfvrt4'+isfvrt);
      fav = false;
    }
  }



  Future<void> deleteEntry(
      GlobalKey<State<StatefulWidget>> keyLoader, String user_id) async {


    print('deleteid'+user_id.toString());
    final formData = {

      'list': user_id,
      'user_id': _userId,
    };
    print('deleteid'+formData.toString());
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/deleteSelectedAccounts',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      DeleteMilkResponse user2 = DeleteMilkResponse.fromJson(responseData.data);
      setState(() {
        getdata(_userId, pageNumber);
        paginationApi();
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(user2.message)));
      });
    } catch (e) {
      setState(() {});
    }
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
