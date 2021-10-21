import 'dart:async';

import 'package:dairy_newdeskapp/model/GetAnalyze.dart';
import 'package:dairy_newdeskapp/model/GetAnalyzeResponse.dart';
import 'package:dairy_newdeskapp/model/GetBannerImagesResponse.dart';
import 'package:dairy_newdeskapp/model/GetFvrtResponse.dart';
import 'package:dairy_newdeskapp/model/GetNotesResponse.dart';
import 'package:dairy_newdeskapp/model/GetProfileResponse.dart';
import 'package:dairy_newdeskapp/model/GetSavedWeight.dart';
import 'package:dairy_newdeskapp/model/GetTopListResponse.dart';
import 'package:dairy_newdeskapp/model/GetWeightReponse.dart';
import 'package:dairy_newdeskapp/model/NotesResponse.dart';
import 'package:dairy_newdeskapp/model/SaveAnalzResponse.dart';
import 'package:dairy_newdeskapp/model/SaveWeigResponse.dart';
import 'package:dairy_newdeskapp/model/UpdateAnalzResponse.dart';
import 'package:dairy_newdeskapp/model/UpdateWeigResponse.dart';
import 'package:dairy_newdeskapp/ui/accounts/AddAccounts.dart';
import 'package:dairy_newdeskapp/ui/accounts/All%20Accounts.dart';
import 'package:dairy_newdeskapp/ui/accounts/BankAccounts.dart';
import 'package:dairy_newdeskapp/ui/accounts/PaymentReport.dart';
import 'package:dairy_newdeskapp/ui/accounts/SaleReport.dart';
import 'package:dairy_newdeskapp/ui/accounts/StockReport.dart';
import 'package:dairy_newdeskapp/ui/accounts/UnionReport.dart';
import 'package:dairy_newdeskapp/ui/help/FAQ.dart';
import 'package:dairy_newdeskapp/ui/help/HelpDesk.dart';
import 'package:dairy_newdeskapp/ui/help/Services.dart';
import 'package:dairy_newdeskapp/ui/help/Version.dart';
import 'package:dairy_newdeskapp/ui/rate/AdvanceRate.dart';
import 'package:dairy_newdeskapp/ui/rate/FlatRate.dart';
import 'package:dairy_newdeskapp/ui/rate/ImportData.dart';
import 'package:dairy_newdeskapp/ui/reports/PurchaseReport.dart';
import 'package:dairy_newdeskapp/ui/setting/Analyze.dart';
import 'package:dairy_newdeskapp/ui/setting/EditPass.dart';
import 'package:dairy_newdeskapp/ui/setting/EditUser.dart';
import 'package:dairy_newdeskapp/ui/setting/Formatdate.dart';
import 'package:dairy_newdeskapp/ui/setting/Language.dart';
import 'package:dairy_newdeskapp/ui/setting/Resolution.dart';
import 'package:dairy_newdeskapp/ui/setting/Weighing.dart';
import 'package:dairy_newdeskapp/ui/task/Bonus.dart';
import 'package:dairy_newdeskapp/ui/task/Deduct.dart';
import 'package:dairy_newdeskapp/ui/task/Dispatch.dart';
import 'package:dairy_newdeskapp/ui/task/ItemSale.dart';
import 'package:dairy_newdeskapp/ui/task/MilkCollection.dart';
import 'package:dairy_newdeskapp/ui/task/MilkSale.dart';
import 'package:dairy_newdeskapp/ui/task/Payments.dart';
import 'package:dairy_newdeskapp/ui/task/StockUpdate.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'Profile.dart';



class HomeMainScreen extends StatefulWidget {
  @override
  HomeScreenMainState createState() => HomeScreenMainState();
}

class HomeScreenMainState extends State<HomeMainScreen> {
  String vall;
  bool flag = false;
  bool expandFlag00 = false;
  bool listFlag = false;
  var checkedValue = false;
  var checkedValue1 = false;
  bool expandFlag0 = false;
  bool expandFlag1 = false;
  bool expandFlag2 = false;
  bool expandFlag3 = false;
  bool expandFlag4 = false;
  bool expandFlag5 = false;
  bool expandFlag6 = false;
  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool milktype1 = false;
  bool milktype2 = false;
  bool milktype3 = false;
  bool milktype4 = false;
  bool milktype5 = false;
  bool milktype6 = false;
  bool milktype7 = false;
  bool milktype8 = false;
  bool reports1 = false;
  bool reports2 = false;
  bool reports3 = false;
  bool reports4 = false;
  bool reports5 = false;
  bool reports6 = false;
  bool rate1 = false;
  bool rate2 = false;
  bool rate3 = false;
  bool database = false;
  bool settingtype1 = false;
  bool settingtype2 = false;
  bool settingtype3 = false;
  bool settingtype4 = false;
  bool settingtype5 = false;
  bool settingtype6 = false;
  bool settingtype7 = false;
  bool settingtype8 = false;
  bool help1 = false;
  bool help2 = false;
  bool help3 = false;
  bool help4 = false;
  bool profile = false;
  bool resultvalue = true;
  bool resultvalue1 = true;
  bool resultvalue2 = true;
  bool resultvalue3 = true;
  var type = 'home';
  var listdata;
  var listdata1;
  var listdata2;
  var listdata3;
  var tabtype = 'All';

  var username, useremail, userlname;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  GetNotesResponse user;
  GetTopListResponse user1;
  GetBannerImagesResponse user2;
  int select, valueRadio;
  int _userId;
  int currentPageValue = 0;
  final _formKey = GlobalKey<FormState>();
  bool showvalue;
  bool showvalue1;
  String notificationvalue;
  GetProfileResponse userProfile;
  var listdata5;
  bool resultvalue5 = true;

  //Timer timer;
  bool chk, chk1;
  int val, val1;
  GetFvrtResponse fvrtresponse;
  final List<Widget> introWidgetsList = <Widget>[
    Image.asset(
      "assests/image/milk1.png",
      height: SizeConfig.blockSizeVertical * 2,
    ),
    Image.asset(
      "assests/image/milk1.png",
      height: SizeConfig.blockSizeVertical * 30,
    ),
    Image.asset(
      "assests/image/milk1.png",
      height: SizeConfig.blockSizeVertical * 30,
    ),
  ];

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? AppColors.white : AppColors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Future<void> initState() {
    super.initState();
    _loadID();
  }

  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      username = prefs.getString(PrefConstant.user_name);
      useremail = prefs.getString(PrefConstant.user_email);
      userlname = prefs.getString(PrefConstant.user_lname);
      getNotes(_userId);
      getFvrtTabs(_userId);
      getTopList(_keyLoader, _userId);
      getImages(_keyLoader, _userId);
      getweight(_keyLoader, _userId);
      getProfile(_keyLoader, _userId);
      getAweight(_keyLoader, _userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    //

    // TODO: implement build
    return Scaffold(
      body: Container(
          child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Image.asset(
                  'assests/image/home.png',
                  width: SizeConfig.blockSizeHorizontal * 10,
                  height: SizeConfig.blockSizeVertical * 10,
                ),
                Container(
                    width: SizeConfig.blockSizeHorizontal * 20,
                    height: SizeConfig.blockSizeVertical * 90,
                    color: AppColors.homeBlue,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              type = "profile";

                              expandFlag0 = false;
                              expandFlag1 = false;
                              expandFlag2 = false;
                              expandFlag3 = false;
                              expandFlag4 = false;
                              expandFlag5 = false;
                              expandFlag6 = false;
                              expandFlag00 = false;
                              profile = !profile;
                              //   pressAttention = !pressAttention;
                            });
                          },
                          child: Container(
                            color: profile
                                ? AppColors.blueDark
                                : AppColors.homeBlue,
                            height: SizeConfig.blockSizeVertical * 15,
                            child: Row(
                              children: <Widget>[
                                listdata5 != null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            top:
                                                SizeConfig.blockSizeHorizontal *
                                                    2),
                                        height:
                                            SizeConfig.blockSizeVertical * 6,
                                        width:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    userProfile.data.image),
                                                fit: BoxFit.fill)),
                                      )
                                    :  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                        SizeConfig.blockSizeHorizontal * 2,
                                        top:
                                        SizeConfig.blockSizeHorizontal * 2),
                                    height: SizeConfig.blockSizeVertical * 6,
                                    width: SizeConfig.blockSizeHorizontal * 4,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assests/image/person.png'),
                                            fit: BoxFit.fill))),
                                Container(
                                  //   width: MediaQuery.of(context).size.width/2,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1,
                                      top: SizeConfig.blockSizeHorizontal * 4),
                                  alignment: Alignment.center,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            '$username' + '$userlname',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //   width: MediaQuery.of(context).size.width/2,
                                          child: Text(
                                            '$useremail',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 3,
                            ),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      tabtype = 'All';
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                        left: SizeConfig.blockSizeVertical * 3,
                                      ),
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 7,
                                      height: SizeConfig.blockSizeVertical * 5,
                                      child: Text(
                                        'All Tabs',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGreen,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(5.0),
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0),
                                        ),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      tabtype = 'Fav';
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                        left: SizeConfig.blockSizeVertical * 3,
                                      ),
                                      alignment: Alignment.center,
                                      width: SizeConfig.blockSizeHorizontal * 7,
                                      height: SizeConfig.blockSizeVertical * 5,
                                      child: Text(
                                        'Favourite Tabs',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGreen,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(5.0),
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                        tabtype == 'All'
                            ? Container(
                                child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "home";

                                        expandFlag0 = false;
                                        profile = false;
                                        expandFlag1 = false;
                                        expandFlag2 = false;
                                        expandFlag3 = false;
                                        expandFlag4 = false;
                                        expandFlag5 = false;
                                        expandFlag6 = false;
                                        expandFlag00 = !expandFlag00;
                                        //   pressAttention = !pressAttention;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag00
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2,
                                            ),
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    2.6,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    1.5,
                                            child: Icon(
                                              Icons.home,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                            ),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'home'.tr,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  //       expandFlag00 == true ? Expandedview0() : Container(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "account";
                                        expandFlag1 = false;
                                        expandFlag2 = false;
                                        expandFlag3 = false;
                                        expandFlag4 = false;
                                        expandFlag5 = false;
                                        expandFlag6 = false;
                                        expandFlag00 = false;
                                        expandFlag0 = !expandFlag0;
                                        profile = false;
                                        pressAttention2 = false;
                                        pressAttention = false;
                                        pressAttention1 = !pressAttention1;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag0
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2.6,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1.5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assests/image/accounticon.png"),
                                                      fit: BoxFit.fill))),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'accounts'.tr,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  expandFlag0 == true
                                      ? Expandedview0()
                                      : Container(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "task";
                                        expandFlag0 = false;
                                        expandFlag00 = false;
                                        expandFlag2 = false;
                                        expandFlag3 = false;
                                        expandFlag4 = false;
                                        expandFlag5 = false;
                                        expandFlag6 = false;
                                        expandFlag1 = !expandFlag1;
                                        profile = false;
                                        milktype1 = !milktype1;
                                        milktype2 = false;
                                        milktype3 = false;
                                        milktype4 = false;
                                        milktype5 = false;
                                        milktype6 = false;
                                        milktype7 = false;
                                        milktype8 = false;
                                      });
                                    },
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag1
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2.6,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1.5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assests/image/taskicon.png"),
                                                      fit: BoxFit.fill))),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'task'.tr,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  expandFlag1 == true
                                      ? Expandedview1()
                                      : Container(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "reports";
                                        expandFlag00 = false;
                                        expandFlag0 = false;
                                        expandFlag1 = false;
                                        expandFlag3 = false;
                                        expandFlag4 = false;
                                        expandFlag5 = false;
                                        expandFlag6 = false;
                                        expandFlag2 = !expandFlag2;
                                        profile = false;
                                        reports1 = !reports1;
                                        reports2 = false;
                                        reports3 = false;
                                        reports4 = false;
                                        reports5 = false;
                                        reports6 = false;
                                      });
                                    },
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag2
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2.6,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1.5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assests/image/reporticon.png"),
                                                      fit: BoxFit.fill))),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'Reports',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  expandFlag2 == true
                                      ? Expandedview2()
                                      : Container(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "rate";
                                        expandFlag0 = false;
                                        expandFlag00 = false;
                                        expandFlag1 = false;
                                        expandFlag2 = false;
                                        expandFlag4 = false;
                                        expandFlag5 = false;
                                        expandFlag6 = false;
                                        expandFlag3 = !expandFlag3;
                                        profile = false;

                                        rate3 = !rate3;
                                        rate2 = false;
                                        rate1 = false;
                                      });
                                    },
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag3
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2.6,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1.5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assests/image/rateicon.png"),
                                                      fit: BoxFit.fill))),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),
                                            child: Text(
                                              'Rate Management',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  expandFlag3 == true
                                      ? Expandedview3()
                                      : Container(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "database";
                                        expandFlag0 = false;
                                        expandFlag0 = false;
                                        expandFlag1 = false;
                                        expandFlag3 = false;
                                        expandFlag2 = false;
                                        expandFlag5 = false;
                                        expandFlag6 = false;
                                        expandFlag4 = !expandFlag4;
                                        database = !database;
                                        profile = false;
                                      });
                                    },
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag4
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2.6,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1.5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assests/image/databaseicon.png"),
                                                      fit: BoxFit.fill))),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'Database Management',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  expandFlag4 == true
                                      ? Expandedview4()
                                      : Container(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "setting";
                                        expandFlag0 = false;
                                        expandFlag00 = false;
                                        expandFlag1 = false;
                                        expandFlag3 = false;
                                        expandFlag4 = false;
                                        expandFlag2 = false;
                                        expandFlag6 = false;
                                        expandFlag5 = !expandFlag5;
                                        settingtype1 = !settingtype1;
                                        settingtype2 = false;
                                        settingtype3 = false;
                                        settingtype4 = false;
                                        settingtype5 = false;
                                        settingtype6 = false;
                                        settingtype7 = false;
                                        settingtype8 = false;
                                        profile = false;
                                      });
                                    },
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag5
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2),
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    2.6,
                                            width:
                                                SizeConfig.blockSizeHorizontal *
                                                    1.5,
                                            child: Icon(
                                              Icons.settings,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'Settings & Tools',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  expandFlag5 == true
                                      ? Expandedview5()
                                      : Container(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        type = "help";
                                        expandFlag0 = false;
                                        expandFlag00 = false;
                                        expandFlag1 = false;
                                        expandFlag3 = false;
                                        expandFlag4 = false;
                                        expandFlag5 = false;
                                        expandFlag2 = false;
                                        expandFlag6 = !expandFlag6;
                                        profile = false;

                                        help1 = !help1;
                                        help2 = false;
                                        help3 = false;
                                        help4 = false;
                                      });
                                    },
                                    child: Container(
                                      height: SizeConfig.blockSizeVertical * 5,
                                      color: expandFlag6
                                          ? AppColors.blueDark
                                          : AppColors.homeBlue,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2.6,
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1.5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assests/image/helpicon.png"),
                                                      fit: BoxFit.fill))),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1),

                                            //   width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              'Help Desk',
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: Container()),
                                  expandFlag6 == true
                                      ? Expandedview6()
                                      : Container(),
                                ],
                              )) // all tabs
                            :



                        listdata3 != null?

                        Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 1,
                                top: SizeConfig.blockSizeHorizontal * 1),
                            height: SizeConfig.blockSizeVertical * 70,
                            width: SizeConfig.blockSizeHorizontal * 15,


                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: listdata3.length == null
                                    ? 0
                                    : listdata3.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        fvrtresponse.results
                                            .elementAt(index)
                                            .isFavourite ==
                                            "1"
                                            ? InkWell(
                                            onTap: () {

                                              setState(() {

                                                fvrtTabsClick(fvrtresponse.results.elementAt(index).tabName);

                                                //   pressAttention = !pressAttention;
                                              });
                                            },
                                            child: Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets
                                                        .only(
                                                      top: 8,
                                                    ),
                                                    alignment:
                                                    Alignment
                                                        .topLeft,
                                                    child: Text(
                                                      fvrtresponse
                                                          .results
                                                          .elementAt(
                                                          index)
                                                          .tabName,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .white,
                                                          fontSize:
                                                          15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                            : Container(),
                                      ],
                                    ),
                                  );
                                })) :
                        Container(

                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 1,
                              top: SizeConfig.blockSizeHorizontal * 1),

                          alignment: Alignment.center,
                          child: resultvalue3 == true
                              ? Center(

                          )
                              : Center(child: Text("")),
                        ),








                        // favrte tabs
                        Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 5,
                              bottom: SizeConfig.blockSizeVertical * 3,
                            ),
                            alignment: Alignment.center,
                            width: SizeConfig.blockSizeHorizontal * 10,
                            height: SizeConfig.blockSizeVertical * 5,
                            child: Text(
                              '+ADD PAYMENTS',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 10,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                            ))
                      ]),
                    )),
              ]),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 80,
              height: SizeConfig.blockSizeVertical * 100,
              decoration: BoxDecoration(color: Colors.red),
              child: Column(children: <Widget>[
                Container(
                  height: SizeConfig.blockSizeVertical * 100,
                  color: AppColors.homebg,
                  child: rightView(type),
                ),
              ]),
            )
          ],
        ),
      )),
    );
  }

  Expandedview0() {
    return Container(
      color: AppColors.blueDark,
      width: SizeConfig.blockSizeHorizontal * 20,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                width: SizeConfig.blockSizeHorizontal * 16,
                height: SizeConfig.blockSizeVertical * 3,
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2,
                    top: SizeConfig.blockSizeHorizontal * 0.3,
                    left: SizeConfig.blockSizeHorizontal * 0.3),
                color:
                    pressAttention1 ? AppColors.lightBlue : AppColors.blueDark,
                margin: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    top: SizeConfig.blockSizeHorizontal * 1.5),
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "add account";
                      pressAttention2 = false;
                      pressAttention = false;
                      pressAttention1 = !pressAttention1;
                    });
                  },
                  child: Text(
                    'addaccounts'.tr,
                    style: TextStyle(color: AppColors.white, fontSize: 10),
                  ),
                )),
            Container(
                width: SizeConfig.blockSizeHorizontal * 16,
                height: SizeConfig.blockSizeVertical * 3,
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2,
                    top: SizeConfig.blockSizeHorizontal * 0.3,
                    left: SizeConfig.blockSizeHorizontal * 0.3),
                color:
                    pressAttention ? AppColors.lightBlue : AppColors.blueDark,
                margin: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    top: SizeConfig.blockSizeHorizontal * 1.5),
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "all account";
                      pressAttention2 = false;
                      pressAttention1 = false;
                      pressAttention = !pressAttention;
                    });
                  },
                  child: Text(
                    'allaccounts'.tr,
                    style: TextStyle(color: AppColors.white, fontSize: 10),
                  ),
                )),
            Container(
                width: SizeConfig.blockSizeHorizontal * 16,
                height: SizeConfig.blockSizeVertical * 3,
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2,
                    top: SizeConfig.blockSizeHorizontal * 0.3,
                    left: SizeConfig.blockSizeHorizontal * 0.3),
                color:
                    pressAttention2 ? AppColors.lightBlue : AppColors.blueDark,
                margin: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    bottom: SizeConfig.blockSizeVertical * 1,
                    top: SizeConfig.blockSizeHorizontal * 1.5),
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "bank account";
                      pressAttention1 = false;
                      pressAttention = false;
                      pressAttention2 = !pressAttention2;
                    });
                  },
                  child: Text(
                    'bankaccounts'.tr,
                    style: TextStyle(color: AppColors.white, fontSize: 10),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Expandedview1() {
    return Container(
      color: AppColors.blueDark,
      width: SizeConfig.blockSizeHorizontal * 20,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: SizeConfig.blockSizeHorizontal * 16,
                height: SizeConfig.blockSizeVertical * 3,
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 2,
                    top: SizeConfig.blockSizeHorizontal * 0.3,
                    left: SizeConfig.blockSizeHorizontal * 0.3),
                color: milktype1 ? AppColors.lightBlue : AppColors.blueDark,
                margin: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 3,
                    top: SizeConfig.blockSizeHorizontal * 1),
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "milk collection";
                      milktype1 = !milktype1;
                      milktype2 = false;
                      milktype3 = false;
                      milktype4 = false;
                      milktype5 = false;
                      milktype6 = false;
                      milktype7 = false;
                      milktype8 = false;
                    });
                  },
                  child: Text(
                    'milkcollection'.tr,
                    style: TextStyle(color: AppColors.white, fontSize: 10),
                  ),
                )),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: milktype2 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "milk sale";
                    milktype2 = !milktype2;
                    milktype1 = false;
                    milktype3 = false;
                    milktype4 = false;
                    milktype5 = false;
                    milktype6 = false;
                    milktype7 = false;
                    milktype8 = false;
                  });
                },
                child: Text(
                  'milksale'.tr,
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: milktype3 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "item sale";
                    milktype3 = !milktype3;
                    milktype1 = false;
                    milktype2 = false;
                    milktype4 = false;
                    milktype5 = false;
                    milktype6 = false;
                    milktype7 = false;
                    milktype8 = false;
                  });
                },
                child: Text(
                  'itemsale'.tr,
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: milktype4 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "payment";
                    milktype4 = !milktype4;
                    milktype1 = false;
                    milktype2 = false;
                    milktype3 = false;
                    milktype5 = false;
                    milktype6 = false;
                    milktype7 = false;
                    milktype8 = false;
                  });
                },
                child: Text(
                  'payments'.tr,
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: milktype5 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "stoke update";
                    milktype5 = !milktype5;
                    milktype1 = false;
                    milktype2 = false;
                    milktype3 = false;
                    milktype4 = false;
                    milktype6 = false;
                    milktype7 = false;
                    milktype8 = false;
                  });
                },
                child: Text(
                  'stockupdate'.tr,
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: milktype6 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "dispatch";
                    milktype6 = !milktype6;
                    milktype1 = false;
                    milktype2 = false;
                    milktype3 = false;
                    milktype4 = false;
                    milktype5 = false;
                    milktype7 = false;
                    milktype8 = false;
                  });
                },
                child: Text(
                  'dispatch'.tr,
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: milktype7 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "deduct";
                    milktype7 = !milktype7;
                    milktype1 = false;
                    milktype2 = false;
                    milktype3 = false;
                    milktype4 = false;
                    milktype5 = false;
                    milktype6 = false;
                    milktype8 = false;
                  });
                },
                child: Text(
                  'Deduct',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * 2,
                top: SizeConfig.blockSizeHorizontal * 0.3,
                left: SizeConfig.blockSizeHorizontal * 0.3,
              ),
              color: milktype8 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1,
                  bottom: SizeConfig.blockSizeVertical * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "bonus";
                    milktype8 = !milktype8;
                    milktype1 = false;
                    milktype2 = false;
                    milktype3 = false;
                    milktype4 = false;
                    milktype5 = false;
                    milktype6 = false;
                    milktype7 = false;
                  });
                },
                child: Text(
                  'Bonus',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Expandedview2() {
    return Container(
      color: AppColors.blueDark,
      width: SizeConfig.blockSizeHorizontal * 20,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: reports1 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "purchase report";
                    reports1 = !reports1;
                    reports2 = false;
                    reports3 = false;
                    reports4 = false;
                    reports5 = false;
                    reports6 = false;
                  });
                },
                child: Text(
                  'Purchase Report',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: reports2 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "sale report";
                    reports2 = !reports2;
                    reports1 = false;
                    reports3 = false;
                    reports4 = false;
                    reports5 = false;
                    reports6 = false;
                  });
                },
                child: Text(
                  'Sale Report',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: reports4 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "payment report";
                    reports4 = !reports4;
                    reports1 = false;
                    reports2 = false;
                    reports3 = false;
                    reports5 = false;
                    reports6 = false;
                  });
                },
                child: Text(
                  'Payment Report',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: reports5 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "stock report";
                    reports5 = !reports5;
                    reports1 = false;
                    reports2 = false;
                    reports3 = false;
                    reports4 = false;
                    reports6 = false;
                  });
                },
                child: Text(
                  'Stock Report',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: reports6 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
                bottom: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "union report";
                    reports6 = !reports6;
                    reports1 = false;
                    reports2 = false;
                    reports3 = false;
                    reports4 = false;
                    reports5 = false;
                  });
                },
                child: Text(
                  'Union Sale Report',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expandedview3() {
    return Container(
      color: AppColors.blueDark,
      width: SizeConfig.blockSizeHorizontal * 20,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: rate3 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "importrate";
                    rate3 = !rate3;
                    rate2 = false;
                    rate1 = false;
                  });
                },
                child: Text(
                  'Import Rate',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: rate1 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "flatrate";
                    rate1 = !rate1;
                    rate2 = false;
                    rate3 = false;
                  });
                },
                child: Text(
                  'Flat Rate',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: rate2 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeHorizontal * 1,
                  bottom: SizeConfig.blockSizeHorizontal * 1),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "advancerate";
                    rate2 = !rate2;
                    rate1 = false;
                    rate3 = false;
                  });
                },
                child: Text(
                  'Advance Rate',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expandedview4() {
    return Container(
      color: AppColors.blueDark,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 4,
                  top: SizeConfig.blockSizeHorizontal * 1.5),
              alignment: Alignment.topLeft,
              child: Text(
                'Export Data',
                style: TextStyle(color: AppColors.white, fontSize: 10),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: database ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
                bottom: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "importdata";
                    database = !database;
                  });
                },
                child: Text(
                  'Import Data',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expandedview5() {
    return Container(
      color: AppColors.blueDark,
      width: SizeConfig.blockSizeHorizontal * 20,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype1 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "resolution";
                    settingtype1 = !settingtype1;
                    settingtype2 = false;
                    settingtype3 = false;
                    settingtype4 = false;
                    settingtype5 = false;
                    settingtype6 = false;
                    settingtype7 = false;
                    settingtype8 = false;
                  });
                },
                child: Text(
                  'Resolution',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype2 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "language";
                    settingtype2 = !settingtype2;
                    settingtype1 = false;
                    settingtype3 = false;
                    settingtype4 = false;
                    settingtype5 = false;
                    settingtype6 = false;
                    settingtype7 = false;
                    settingtype8 = false;
                  });
                },
                child: Text(
                  'Language',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype3 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "analyze";
                      settingtype3 = !settingtype3;
                      settingtype1 = false;
                      settingtype2 = false;
                      settingtype4 = false;
                      settingtype5 = false;
                      settingtype6 = false;
                      settingtype7 = false;
                      settingtype8 = false;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Analyser Data',
                        style: TextStyle(color: AppColors.white, fontSize: 10),
                      ),
                      chk1 == true
                          ? val == 0
                              ? Checkbox(
                                  value: showvalue1,
                                  // activeColor: checkedValue ? Colors.black : Colors.white,
                                  onChanged: (bool value) {
                                    setState(() {
                                      showvalue1 = value;
                                      /*  UpdateAnalyz(_keyLoader, "true");*/

                                      showvalue1 = value;
                                      if (showvalue1 == true) {
                                        notificationvalue = "on";
                                        UpdateAnalyz(_keyLoader, "true");
                                      } else if (showvalue1 == false) {
                                        notificationvalue = "off";
                                        UpdateAnalyz(_keyLoader, "false");
                                      }
                                      print(
                                          "Notification: " + notificationvalue);
                                    });
                                  },
                                )
                              : Checkbox(
                                  value: false,
                                  // activeColor: checkedValue ? Colors.black : Colors.white,
                                  onChanged: (bool value) {
                                    setState(() {
                                      showvalue1 = value;
                                      saveAnalyz(_keyLoader, "true");
                                      print(
                                          "Notification: " + notificationvalue);
                                    });
                                  },
                                )
                          : Container(
                              alignment: Alignment.center,
                              child: chk1 == true
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Center(child: Text('')),
                            )
                    ],
                  )),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype4 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      type = "weigning";
                      settingtype4 = !settingtype4;
                      settingtype1 = false;
                      settingtype2 = false;
                      settingtype3 = false;
                      settingtype5 = false;
                      settingtype6 = false;
                      settingtype7 = false;
                      settingtype8 = false;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Weighing Scale',
                        style: TextStyle(color: AppColors.white, fontSize: 10),
                      ),
                      chk == true
                          ? val1 == 0
                              ? Checkbox(
                                  value: showvalue,
                                  // activeColor: checkedValue ? Colors.black : Colors.white,
                                  onChanged: (bool value) {
                                    setState(() {
                                      showvalue = value;
                                      /*  UpdateAnalyz(_keyLoader, "true");*/

                                      showvalue = value;
                                      if (showvalue == true) {
                                        notificationvalue = "on";
                                        UpdateWeight(_keyLoader, "true");
                                      } else if (showvalue == false) {
                                        notificationvalue = "off";
                                        UpdateWeight(_keyLoader, "false");
                                      }
                                      print(
                                          "Notification: " + notificationvalue);
                                    });
                                  },
                                )
                              : Checkbox(
                                  value: false,
                                  // activeColor: checkedValue ? Colors.black : Colors.white,
                                  onChanged: (bool value) {
                                    setState(() {
                                      showvalue = value;
                                      saveWeight(_keyLoader, "true");
                                      print(
                                          "Notification: " + notificationvalue);
                                    });
                                  },
                                )
                          : Container(
                              alignment: Alignment.center,
                              child: chk == true
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Center(child: Text('')),
                            )
                    ],
                  )),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype5 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "editsnf";
                    settingtype5 = !settingtype5;
                    settingtype1 = false;
                    settingtype2 = false;
                    settingtype3 = false;
                    settingtype4 = false;
                    settingtype6 = false;
                    settingtype7 = false;
                    settingtype8 = false;
                  });
                },
                child: Text(
                  'Edit SNF Formula',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype6 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "formatdate";
                    settingtype6 = !settingtype6;
                    settingtype1 = false;
                    settingtype2 = false;
                    settingtype3 = false;
                    settingtype4 = false;
                    settingtype5 = false;
                    settingtype7 = false;
                    settingtype8 = false;
                  });
                },
                child: Text(
                  'Format Date and Time',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype7 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "editusername";
                    settingtype7 = !settingtype7;
                    settingtype1 = false;
                    settingtype2 = false;
                    settingtype3 = false;
                    settingtype4 = false;
                    settingtype5 = false;
                    settingtype6 = false;
                    settingtype8 = false;
                  });
                },
                child: Text(
                  'Edit Username',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: settingtype8 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
                bottom: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "editpassword";

                    settingtype8 = !settingtype8;
                    settingtype1 = false;
                    settingtype2 = false;
                    settingtype3 = false;
                    settingtype4 = false;
                    settingtype5 = false;
                    settingtype6 = false;
                    settingtype7 = false;
                  });
                },
                child: Text(
                  'Edit Password',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expandedview6() {
    return Container(
      color: AppColors.blueDark,
      width: SizeConfig.blockSizeHorizontal * 20,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: help1 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "version";
                    help1 = !help1;
                    help2 = false;
                    help3 = false;
                    help4 = false;
                  });
                },
                child: Text(
                  'Version',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: help2 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "faq";
                    help2 = !help2;
                    help1 = false;
                    help3 = false;
                    help4 = false;
                  });
                },
                child: Text(
                  'FAQ',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: help3 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "services";
                    help3 = !help3;
                    help1 = false;
                    help2 = false;
                    help4 = false;
                  });
                },
                child: Text(
                  'Services',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 16,
              height: SizeConfig.blockSizeVertical * 3,
              padding: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeHorizontal * 0.3,
                  left: SizeConfig.blockSizeHorizontal * 0.3),
              color: help4 ? AppColors.lightBlue : AppColors.blueDark,
              margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
                bottom: SizeConfig.blockSizeHorizontal * 1,
              ),
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = "helpline";
                    help4 = !help4;
                    help1 = false;
                    help2 = false;
                    help3 = false;
                  });
                },
                child: Text(
                  'Helpline Number',
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  rightView(type) {
    if (type == 'home') {
      return Container(
        color: AppColors.homeblluebg,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              listdata1 != null
                  ? Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1,
                          top: SizeConfig.blockSizeHorizontal * 1),
                      height: SizeConfig.blockSizeVertical * 5,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              listdata1.length == null ? 0 : listdata1.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 3, left: 10),
                                            child: new Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            )),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 8,
                                          ),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            user1.data.elementAt(index).points,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
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
                      ))
                  : Container(
                      margin: EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      child: resultvalue1 == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(child: Text("")),
                    ),
              Container(
                width: SizeConfig.blockSizeVertical * 150,
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                height: SizeConfig.blockSizeVertical * 30,
                child: Marquee(
                    animationDuration: Duration(milliseconds: 4000),
                    child: Row(
                      children: <Widget>[
                        listdata2 != null
                            ? Container(
                                width: SizeConfig.blockSizeHorizontal * 90,
                                height: SizeConfig.blockSizeVertical * 150,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1,
                                    right: SizeConfig.blockSizeHorizontal * 1,
                                    top: SizeConfig.blockSizeHorizontal * 1),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listdata2.length == null
                                        ? 0
                                        : listdata2.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 0, 20, 20),
                                                      child: Image.network(
                                                        'http://dairy.knickglobal.com/' +
                                                            user2.data
                                                                .elementAt(
                                                                    index)
                                                                .image,
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            25,
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            25,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 50),
                                alignment: Alignment.center,
                                child: resultvalue2 == true
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Center(child: Text('')),
                              ),
                      ],
                    )),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 60,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 20,

                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical * 2),
                      //   width: MediaQuery.of(context).size.width/2,

                      child: Card(
                          child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          listdata3 != null
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      right: SizeConfig.blockSizeHorizontal * 1,
                                      top: SizeConfig.blockSizeHorizontal * 1),
                                  height: SizeConfig.blockSizeVertical * 70,
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: listdata3.length == null
                                          ? 0
                                          : listdata3.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Column(
                                            children: [
                                              fvrtresponse.results
                                                          .elementAt(index)
                                                          .isFavourite ==
                                                      "1"
                                                  ? InkWell(
                                                      onTap: () {
                                                        print('clicked item' +
                                                            fvrtresponse.results
                                                                .elementAt(
                                                                    index)
                                                                .tabName);
                                                        Future.delayed(
                                                            Duration(
                                                                seconds: 1),
                                                            () {
                                                          Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MilkCollection()),
                                                              (route) => false);
                                                        });
                                                      },
                                                      child: Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                top: 8,
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                fvrtresponse
                                                                    .results
                                                                    .elementAt(
                                                                        index)
                                                                    .tabName,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .black,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : Container(
                            height: SizeConfig.blockSizeVertical * 70,
                            width: SizeConfig.blockSizeHorizontal * 15,
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 3,
                                right: SizeConfig.blockSizeHorizontal * 1,
                                top: SizeConfig.blockSizeHorizontal * 1),

                            alignment: Alignment.center,
                            child: resultvalue3 == true
                                ? Center(

                            )
                                : Center(child: Text("")),
                          ),
                        ]),
                      )),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 57,
                      height: SizeConfig.blockSizeVertical * 60,

                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeVertical * 2),
                      //   width: MediaQuery.of(context).size.width/2,

                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20,
                                  left: SizeConfig.blockSizeHorizontal * 2,
                                  right: SizeConfig.blockSizeHorizontal * 2),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'notes'.tr,
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15),
                              ),
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 20,
                              margin: EdgeInsets.only(
                                  top: 20,
                                  left: SizeConfig.blockSizeHorizontal * 2,
                                  right: SizeConfig.blockSizeHorizontal * 2),
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                controller: Controllers.notes,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    labelText: '',
                                    hoverColor: AppColors.lightBlue,
                                    border: OutlineInputBorder()),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter Notes';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            InkWell(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 7,
                                  height: SizeConfig.blockSizeVertical * 4,
                                  margin: EdgeInsets.only(
                                      top: 10,
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 15),
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.yellowLight),
                                ),
                              ),
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  Dialogs.showLoadingDialog(
                                      context, _keyLoader);
                                  addNotes(
                                    _keyLoader,
                                    _userId,
                                    Controllers.notes.text,
                                  );
                                } else {} // TODO submit
                              },
                            ),
                            listdata != null
                                ? Container(
                                    width: SizeConfig.blockSizeHorizontal * 50,
                                    height: SizeConfig.blockSizeVertical * 20,
                                    margin: EdgeInsets.only(top: 20),
                                    child: ListView.builder(
                                        itemCount: listdata.length == null
                                            ? 0
                                            : listdata.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                bottom: SizeConfig
                                                        .blockSizeVertical *
                                                    2),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      user.data
                                                              .elementAt(index)
                                                              .flagval =
                                                          !user.data
                                                              .elementAt(index)
                                                              .flagval;
                                                    });
                                                  },
                                                  child: Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              40,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 8,
                                                          ),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            user.data
                                                                .elementAt(
                                                                    index)
                                                                .note,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    left: 10),
                                                            child: new Icon(
                                                              user.data
                                                                      .elementAt(
                                                                          index)
                                                                      .flagval
                                                                  ? Icons
                                                                      .keyboard_arrow_up
                                                                  : Icons
                                                                      .keyboard_arrow_down,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    maintainSize: true,
                                                    maintainAnimation: true,
                                                    maintainState: true,
                                                    child: Container()),
                                                user.data
                                                            .elementAt(index)
                                                            .flagval ==
                                                        true
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8, left: 10),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          user.data
                                                              .elementAt(index)
                                                              .note,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: 15),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 50),
                                    alignment: Alignment.center,
                                    child: resultvalue == true
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Center(child: Text("")),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else if (type == 'account') {
      return AddAccounts();
    } else if (type == 'all account') {
      return AllAccounts();
    } else if (type == 'add account') {
      return AddAccounts();
    } else if (type == 'bank account') {
      return BankAccounts();
    } else if (type == 'task') {
      return MilkCollection();
    } else if (type == 'milk collection') {
      return MilkCollection();
    } else if (type == 'milk sale') {
      return MilkSale();
    } else if (type == 'item sale') {
      return ItemSale();
    } else if (type == 'payment') {
      return Payments();
    } else if (type == 'stoke update') {
      return StockUpdate();
    } else if (type == 'dispatch') {
      return Dispatch();
    } else if (type == 'deduct') {
      return Deduct();
    } else if (type == 'bonus') {
      return Bonus();
    } else if (type == 'reports') {
      return PurchaseReport();
    } else if (type == 'purchase report') {
      return PurchaseReport();
    } else if (type == 'sale report') {
      return SaleReport();
    } else if (type == 'payment report') {
      return PaymentReport();
    } else if (type == 'stock report') {
      return StockReport();
    } else if (type == 'union report') {
      return UnionReport();
    } else if (type == 'help') {
      return Version();
    } else if (type == 'version') {
      return Version();
    } else if (type == 'faq') {
      return FAQ();
    } else if (type == 'services') {
      return Services();
    } else if (type == 'helpline') {
      return HelpDesk();
    } else if (type == 'setting') {
      return Resolution();
    } else if (type == 'resolution') {
      return Resolution();
    } else if (type == 'language') {
      return Language();
    } else if (type == 'analyze') {
      return Analyze();
    } else if (type == 'weigning') {
      return Weighing();
    } else if (type == 'formatdate') {
      return Formatdate();
    } else if (type == 'editusername') {
      return EditUser();
    } else if (type == 'editpassword') {
      return EditPass();
    }
    // Rate Management
    else if (type == 'rate') {
      return ImportData();
    } else if (type == 'importrate') {
      return ImportData();
    } else if (type == 'flatrate') {
      return FlatRate();
    } else if (type == 'advancerate') {
      return AdvanceRate();
    } else if (type == 'database') {
      return ImportData();
    } else if (type == 'importdata') {
      return ImportData();
    } else if (type == 'profile') {
      return Profile();
    }
  }

  Future<void> getFvrtTabs(int user_id) async {
    final formData = {
      'user_id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getFavouriteTabs',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      fvrtresponse = GetFvrtResponse.fromJson(responseData.data);
      setState(() {
        resultvalue3 = true;
        print('fvrtdata' + fvrtresponse.results.elementAt(0).isFavourite);
        listdata3 = fvrtresponse.results;

      });
      //
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e, context);
      setState(() {
        resultvalue3 = false;
      });
    }
  }

  Future<void> getNotes(int user_id) async {
    final formData = {
      'user_id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/note_list',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user = GetNotesResponse.fromJson(responseData.data);
      setState(() {
        resultvalue = true;
      });
      listdata = user.data;
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e, context);
      setState(() {
        resultvalue = false;
      });
    }
  }

  Future<void> getTopList(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      var userData =
          await _dio.get(ApiBaseUrl.base_url + 'api/starpoints_list');
      user1 = GetTopListResponse.fromJson(userData.data);
      setState(() {
        resultvalue1 = true;
      });
      listdata1 = user1.data;
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e, context);
      setState(() {
        resultvalue = false;
      });
    }
  }

  Future<void> getImages(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      var userData =
          await _dio.get(ApiBaseUrl.base_url + 'api/homeimages_list');
      user2 = GetBannerImagesResponse.fromJson(userData.data);
      setState(() {
        resultvalue2 = true;
      });
      listdata2 = user2.data;
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e, context);
      setState(() {
        resultvalue = false;
      });
    }
  }

  Future<void> addNotes(GlobalKey<State<StatefulWidget>> keyLoader, int userId,
      String text) async {
    final formData = {
      'user_id': userId,
      'note': text,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>('/api/addnote',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url,
              data: formData));

      NotesResponse user = NotesResponse.fromJson(responseData.data);

      if (user.status == 200) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        getNotes(_userId);
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e, context);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
  }

  Future<void> getweight(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id};
    print(formData);
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
          chk = true;
          getWeightValue(_keyLoader, _userId);
        } else if (user1.status == 400) {
          chk = false;
        }
      });
    } catch (e) {
      setState(() {
        chk = false;
      });
    }
  }

  Future<void> getAweight(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': user_id};
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
      setState(() {
        print(formData);
        if (user1.status == 200) {
          chk1 = true;
          getAnalyzValue(_keyLoader, _userId);
        } else if (user1.status == 400) {
          chk1 = false;
        }
      });
    } catch (e) {
      setState(() {
        chk1 = false;
      });
    }
  }

  void getWeightValue(
      GlobalKey<State<StatefulWidget>> keyLoader, int userId) async {
    final formData = {'user_id': userId};
    print(formData);
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
        val1 = 0;
        if (user1.data.elementAt(0).weighing.toString() == "true") {
          showvalue = true;
        } else if (user1.data.elementAt(0).weighing.toString() == "false") {
          showvalue = false;
        }
        // showvalue = user1.data.elementAt(0).weighing.toString();
        print("showvalue-----------" + showvalue.toString());
      });
    } catch (e) {
      setState(() {
        val1 = 1;
      });
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
        val = 0;
        if (user1.data.elementAt(0).analyzer.toString() == "true") {
          showvalue1 = true;
        } else if (user1.data.elementAt(0).analyzer.toString() == "false") {
          showvalue1 = false;
        }
        print("showvalue1-----------" + showvalue1.toString());
      });
    } catch (e) {
      setState(() {
        val = 1;
        // saveAnalyz(_keyLoader, "true");
      });
    }
  }

  void saveWeight(
      GlobalKey<State<StatefulWidget>> keyLoader, String value) async {
    final formData = {'user_id': _userId, 'weighing': value};
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/addsetting',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      SaveWeigResponse user1 = SaveWeigResponse.fromJson(responseData.data);
      setState(() {
        getWeightValue(_keyLoader, _userId);
      });
    } catch (e) {
      setState(() {});
    }
  }

  void saveAnalyz(
      GlobalKey<State<StatefulWidget>> keyLoader, String value) async {
    final formData = {'user_id': _userId, 'analyzer': value};
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/addanalyzersetting',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      SaveAnalzResponse user1 = SaveAnalzResponse.fromJson(responseData.data);
      setState(() {
        getAnalyzValue(_keyLoader, _userId);
      });
    } catch (e) {
      setState(() {});
    }
  }

  void UpdateWeight(
      GlobalKey<State<StatefulWidget>> keyLoader, String value) async {
    final formData = {'user_id': _userId, 'weighing': value};
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/updatesetting',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      UpdateWeigResponse user1 = UpdateWeigResponse.fromJson(responseData.data);
      setState(() {
        getWeightValue(_keyLoader, _userId);
      });
    } catch (e) {
      setState(() {});
    }
  }

  void UpdateAnalyz(
      GlobalKey<State<StatefulWidget>> keyLoader, String value) async {
    final formData = {'user_id': _userId, 'analyzer': value};
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/updateanalyzersetting',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      UpdateAnalzResponse user1 =
          UpdateAnalzResponse.fromJson(responseData.data);
      setState(() {
        getAnalyzValue(_keyLoader, _userId);
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> getProfile(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {
      'user_id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/profile_list',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      userProfile = GetProfileResponse.fromJson(responseData.data);
      print('pstattus'+userProfile.status.toString());
      if (userProfile.status == 200) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();

        setState(() {
          resultvalue5 = true;
          listdata5 = userProfile.data;
        });
      }

      else if(userProfile.status==400){
        resultvalue5 = false;
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e, context);

      setState(() {
        resultvalue5 = false;
      });
    }
  }

  void fvrtTabsClick(String tabName) {

    if(tabName=='Home'){
      type = "home";
    }
    else   if(tabName=='Profile'){
      type = "profile";
    }
    else   if(tabName=='Add Account'){
      type = "add account";
    }
    else   if(tabName=='All Account'){
      type = "all account";
    }
    else   if(tabName=='Bank Account'){
      type = "bank account";
    }

    else if(tabName=='Milk Collection'){
      type = "milk collection";
    }

    else if(tabName=='Milk Sale'){
      type = "milk sale";
    }
    else if(tabName=='Item Sale'){
      type = "item sale";
    }
    else  if(tabName=='Payments'){
      type = "payment";
    }
    else if(tabName=='Stock Update'){
      type = "stock update";
    }
    else if(tabName=='Dispatch'){
      type = "dispatch";
    }
    else if(tabName=='Deduct'){
      type = "deduct";
    }
    else if(tabName=='Bonus'){
      type = "bonus";
    }



    else  if(tabName=='Purchase Report'){
      type = "purchase report";
    }
    else if(tabName=='Sale Report'){
      type = "sale report";
    }
    else if(tabName=='Payment Report'){
      type = "payment report";
    }
    else if(tabName=='Stock Report'){
      type = "stock report";
    }
    else if(tabName=='Union Sale Report'){
      type = "union report";
    }



    else if(tabName=='Import Rate'){
      type = "importrate";
    }
    else if(tabName=='Flat Rate'){
      type = "flatrate";
    }
    else if(tabName=='Advance Rate'){
      type = "advancerate";
    }


    else if(tabName=='Import Data'){
      type = "importdata";
    }



    else if(tabName=='Resolution'){
      type = "resolution";
    }
    else if(tabName=='Language'){
      type = "language";
    }
    else if(tabName=='Analyser Data'){
      type = "analyze";
    }
    else if(tabName=='Weighing Scale'){
      type = "weigning";
    }
    else if(tabName=='Edit SNF Formula'){
      type = "editsnf";
    }
    else if(tabName=='Format Date and Time'){
      type = "formatdate";
    }
    else if(tabName=='Edit Username'){
      type = "editusername";
    }
    else if(tabName=='Edit Password'){
      type = "editpassword";
    }



    else if(tabName=='Version'){
      type = "version";
    }
    else if(tabName=='FAQ'){
      type = "faq";
    }
    else if(tabName=='Services'){
      type = "services";
    }
    else if(tabName=='Helpline Number'){
      type = "helpline";
    }
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
