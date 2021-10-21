import 'dart:async';

import 'package:dairy_newdeskapp/model/AddAccountResponse.dart';
import 'package:dairy_newdeskapp/model/AddToFvrtResponse.dart';
import 'package:dairy_newdeskapp/model/GetAddToFvrtResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
// ignore: must_be_immutable
class AddAccounts extends StatefulWidget {
  @override
  AddAccountsState createState() => AddAccountsState();
}

class AddAccountsState extends State<AddAccounts> {
  int select, valueRadio;
  var value = false;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  int _userId;
  String isfvrt;
  Timer timer;
  bool fav;

  @override
  Future<void> initState() {
    super.initState();
    gettabfvrt();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.blockSizeHorizontal * 100,
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
                          'addaccounts'.tr,
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


                Container(
                    height: 140,
                    width: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assests/image/profile.png"),
                            fit: BoxFit.fill))),
                Container(
                    margin: EdgeInsets.only(
                        top: 20,
                        left: SizeConfig.blockSizeHorizontal * 1,
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'vendorcode'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: TextFormField(
                                        controller: Controllers.acc_vendor_code,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'vendorname'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_vendor_name,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Vendor Name';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'fathername'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_father_name,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Father Name';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'address'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_addrress,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Address';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  //   width: MediaQuery.of(context).size.width/2,
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'phonenumber'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller:
                                            Controllers.acc_phone_number,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Phone Number';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'mobilenumber'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller:
                                            Controllers.acc_mobile_number,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Mobile Number';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'gstinnumber'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller:
                                            Controllers.acc_gstin_number,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter GSTIN Number';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'emailaddress'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: Controllers.acc_email,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        // ignore: missing_return
                                        validator: (value) {
                                          // ignore: missing_return, missing_return, missing_return
                                          if (value.isEmpty) {
                                            return 'Enter Email';
                                          } else if (!EmailValidator.validate(
                                              value)) {
                                            return 'Please enter a valid email';
                                          }
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  //   width: MediaQuery.of(context).size.width/2,
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'pannumber'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_pan,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter PAN Number';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'aadharnumber'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_aadhar,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Aadhaar Number';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'bankname'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_bank_name,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Bank Name';
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'bankbranch'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_bank_branch,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Bank Branch';
                                          }
                                          return null;
                                        },
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
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'accountnumber'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller:
                                            Controllers.acc_account_number,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter Account Number';
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
                                  margin: EdgeInsets.only(left: 85),
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'ifsc'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_ifsc,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter IFSC Code';
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
                                  margin: EdgeInsets.only(left: 85),
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'city'.tr,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.acc_city,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                            labelText: '',
                                            hoverColor: AppColors.lightBlue,
                                            border: OutlineInputBorder()),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Enter City';
                                          }
                                          return null;
                                        },
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
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'save'.tr,
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 18),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.blueDark,
                              ),
                            ),
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                Dialogs.showLoadingDialog(context, _keyLoader);
                                addAccountByServer(_keyLoader);
                              }
                            },
                          )
                        ],
                      ),
                    )),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<void> addAccountByServer(GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'image': '',
      'vendor_code': Controllers.acc_vendor_code.text,
      'vendor_name': Controllers.acc_vendor_name.text,
      'father': Controllers.acc_father_name.text,
      'address': Controllers.acc_addrress.text,
      'phone_number': Controllers.acc_phone_number.text,
      'mobile_number': Controllers.acc_mobile_number.text,
      'gst_number': Controllers.acc_gstin_number.text,
      'email_address': Controllers.acc_email.text,
      'pan_number': Controllers.acc_pan.text,
      'aadhaar_number': Controllers.acc_aadhar.text,
      'bank_name': Controllers.acc_bank_name.text,
      'bank_branch': Controllers.acc_bank_branch.text,
      'account_number': Controllers.acc_account_number.text,
      'ifsc_number': Controllers.acc_ifsc.text,
      'city': Controllers.acc_city.text,
      'user_id': _userId
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/addaccount',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      AddAccountResponse user = AddAccountResponse.fromJson(responseData.data);
      print("account"+user.status.toString());
      if (user.status == 200) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(responseData.data);
        Controllers.acc_vendor_code.text = '';
        Controllers.acc_vendor_name.text = '';
        Controllers.acc_father_name.text = '';
        Controllers.acc_addrress.text = '';
        Controllers.acc_phone_number.text = '';
        Controllers.acc_mobile_number.text = '';
        Controllers.acc_gstin_number.text = '';
        Controllers.acc_email.text = '';
        Controllers.acc_pan.text = '';
        Controllers.acc_aadhar.text = '';
        Controllers.acc_bank_name.text = '';
        Controllers.acc_bank_branch.text = '';
        Controllers.acc_account_number.text = '';
        Controllers.acc_city.text = '';
        Controllers.acc_ifsc.text = '';
      }
      else if (user.status==400){
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(user.message.toString())));
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
      print(errorMessage);
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
      'tab_name': 'Add Accounts',
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
      'user_id': _userId.toString(),
      'tab_name': 'Add Accounts',
    };
    print('checkingfvrt1: '+formData.toString());
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getFavouriteByTabName',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      GetAddToFvrtResponse  user = GetAddToFvrtResponse.fromJson(responseData.data);
      if (user.status == 200) {
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
      else if (user.status == 400) {
        print('checkingfvrt3'+isfvrt);
      }
    } catch (e) {
      print('checkingfvrt4'+isfvrt);
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
        return 'Error : Account not added';
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
