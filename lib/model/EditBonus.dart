import 'dart:async';

import 'package:dairy_newdeskapp/model/EditDispatchResponse.dart';
import 'package:dairy_newdeskapp/model/GetFatResponse.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import 'GetBonusSingleResponse.dart';

// ignore: must_be_immutable
class EditBonus extends StatefulWidget {
  int _id;
  EditBonus(int id) {
    this._id = id;
  }
  @override
  EditBonusState createState() => EditBonusState();
}

class EditBonusState extends State<EditBonus> {
  int select, valueRadio;
  TimeOfDay selectedTime = TimeOfDay.now();
  var value = false;
  GetBonusSingleResponse user1;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  int _userId;
  final dateController2 = TextEditingController();
  int rate;
  String textValueweight;
  Timer timeHandleweight;

  @override
  Future<void> initState() {
    super.initState();
    setState(() {
      Controllers.edtmilk_vendor_name.text = '';
      Controllers.edtmilk_cattletype.text = '';
      print(widget._id);
      _loadID();
    });
  }

  String textValue;
  Timer timeHandle;
  String textValuefat;
  Timer timeHandlefat;
  int amount;

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

  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
      getAccounts(_keyLoader, widget._id);
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
        Controllers.edtmilk_amount.text = amount.toString();
      });
    });
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(left: 10),
                      child: new Icon(
                        Icons.arrow_back,
                        color: AppColors.black,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 20, left: SizeConfig.blockSizeHorizontal * 1),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Edit Bonus',
                    style: TextStyle(
                        color: AppColors.allaccounttextcolor,
                        fontSize: SizeConfig.blockSizeVertical * 3),
                  ),
                ),
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
                                        'Cow min fat',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height:
                                          SizeConfig.blockSizeVertical * 6.6,
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
                                        controller: Controllers.b_cow_min_fat,
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
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Per unit',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height:
                                          SizeConfig.blockSizeVertical * 6.6,
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.b_cow_per_unit,
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
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Cost',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height:
                                          SizeConfig.blockSizeVertical * 6.6,
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <
                                            TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly
                                        ],
                                        controller: Controllers.b_cow_cost,
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
                                        'Buf min fat',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height:
                                          SizeConfig.blockSizeVertical * 6.6,
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
                                        controller: Controllers.b_buf_min_fat,
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
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Per unit',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height:
                                          SizeConfig.blockSizeVertical * 6.6,
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        controller: Controllers.b_buf_per_unit,
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
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  child: Column(children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Cost',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height:
                                          SizeConfig.blockSizeVertical * 6.6,
                                      alignment: Alignment.topLeft,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <
                                            TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly
                                        ],
                                        controller: Controllers.b_buf_cost,
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
                                'Edit',
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
                                addMilkCollection(_keyLoader);
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

  Future<void> addMilkCollection(
      GlobalKey<State<StatefulWidget>> keyLoader) async {
    final formData = {
      'cow': Controllers.b_cow_min_fat.text,
      'cow_per_unit': Controllers.b_cow_per_unit.text,
      'cow_cost': Controllers.b_cow_cost.text,
      'buff': Controllers.b_buf_min_fat.text,
      'buff_per_unit': Controllers.b_buf_per_unit.text,
      'buff_cost': Controllers.b_buf_cost.text,
      'id': widget._id
    };

    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/updatebonus',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      EditDispatchResponse user =
          EditDispatchResponse.fromJson(responseData.data);
      if (user.status == 200) {
        getAccounts(_keyLoader, widget._id);
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
        print(responseData.data);

        dateController2.text = user.data.date;
        Controllers.edtmilk_time.text = user.data.time;
        Controllers.dairy_code.text = user.data.dairyCode;
        Controllers.avg_fat.text = user.data.avgFat;
        Controllers.avg_snf.text = user.data.avgSnf;
        Controllers.avg_clr.text = user.data.avgClr;
        Controllers.dispatch_rate.text = user.data.rate;
        Controllers.dispatch_weight.text = user.data.weight;
        Controllers.dispatch_no_cans.text = user.data.noOfCans;
        Controllers.dispatch_amount.text = user.data.amount;
        Controllers.dispatch_quantity.text = user.data.quantity;
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e);
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
      print(errorMessage);
    }
  }

  Future<void> getAccounts(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {
      'id': user_id,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/bonussingle',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user1 = GetBonusSingleResponse.fromJson(responseData.data);
      Controllers.b_cow_min_fat.text = user1.data.elementAt(0).cow;
      Controllers.b_cow_per_unit.text = user1.data.elementAt(0).cowPerUnit;
      Controllers.b_cow_cost.text = user1.data.elementAt(0).cowCost;
      Controllers.b_buf_min_fat.text = user1.data.elementAt(0).buff;
      Controllers.b_buf_per_unit.text = user1.data.elementAt(0).buffPerUnit;
      Controllers.b_buf_cost.text = user1.data.elementAt(0).buffCost;
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
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
          Controllers.edtmilk_vendor_name.text =
              user1.data.elementAt(0).vendorName;
          Controllers.edtmilk_rate.text = user1.data.elementAt(0).rate;

          rate = int.parse(user1.data.elementAt(0).rate);
        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        Controllers.edtmilk_vendor_name.text = '';
        Controllers.edtmilk_rate.text = '';
      }
    } catch (e) {
      Controllers.edtmilk_vendor_name.text = '';
      Controllers.edtmilk_rate.text = '';
      final errorMessage = DioExceptions.fromDioError(e);
      print("-----" + errorMessage.toString());
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
    }
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
          Controllers.edtmilk_cattletype.text = user1.data.elementAt(0).cattle;
        });
      } else if (user1.status == 400) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user1.message)));
        Controllers.edtmilk_cattletype.text = '';
      }
    } catch (e) {
      Controllers.edtmilk_cattletype.text = '';
      final errorMessage = DioExceptions.fromDioError(e);
      print("-----" + errorMessage.toString());
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
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
