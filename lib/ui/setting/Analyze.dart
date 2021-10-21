import 'dart:async';

import 'package:dairy_newdeskapp/model/AddAnalyzeResponse.dart';
import 'package:dairy_newdeskapp/model/AddWeightResponse.dart';
import 'package:dairy_newdeskapp/model/GetAnalyzeResponse.dart';
import 'package:dairy_newdeskapp/ui/home/HomeMainScreen.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Analyze extends StatefulWidget {
  @override
  AnalyzeState createState() => AnalyzeState();
}

class AnalyzeState extends State<Analyze> {
  int select, valueRadio;
  int id = 1;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Timer timer;
  int _userId;
  String value;
  String dropdownValue;
  GetAnalyzeResponse user1;
  List<String> spinnerItems = [
    'Select',
  ];
  String fat, snf, clr;
  @override
  Future<void> initState() {
    super.initState();
    _loadID();
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
      getweight(_keyLoader, _userId);
      getweightUser(_keyLoader, _userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 80,
        height: SizeConfig.blockSizeHorizontal * 100,
        decoration: BoxDecoration(color: AppColors.homeblluebg),
        child: Card(
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Analyze Data',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColors.allaccounttextcolor, fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                width: SizeConfig.blockSizeHorizontal * 50,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                    });
                  },
                  items: spinnerItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              InkWell(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 8,
                  height: SizeConfig.blockSizeVertical * 5,
                  margin: EdgeInsets.only(left: 300, top: 50, bottom: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: AppColors.white, fontSize: 18),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greencolor,
                  ),
                ),
                onTap: () {
                  print("selected value is " + dropdownValue.toString());

                  value == null
                      ? addWAnalyzData(_keyLoader, _userId)
                      : updateWeigning(_keyLoader, _userId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getweight(
      GlobalKey<State<StatefulWidget>> keyLoader, int user_id) async {
    final formData = {'user_id': "NULL"};
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/getanalyzername',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      user1 = GetAnalyzeResponse.fromJson(responseData.data);
      setState(() {
        print(formData);
        fat = user1.data.elementAt(0).fat;
        snf = user1.data.elementAt(0).snf;
        clr = user1.data.elementAt(0).clr;
        for (int i = 0; i < spinnerItems.length; i++) {
          spinnerItems.add(user1.data.elementAt(i).name);
        }
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
      user1 = GetAnalyzeResponse.fromJson(responseData.data);
      setState(() {
        print(formData);
        value = user1.data.elementAt(0).name;
        dropdownValue = user1.data.elementAt(0).name;
        fat = user1.data.elementAt(0).fat;
        snf = user1.data.elementAt(0).snf;
        clr = user1.data.elementAt(0).clr;
        value = user1.data.elementAt(0).name;
        dropdownValue = user1.data.elementAt(0).name;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> addWAnalyzData(
      GlobalKey<State<StatefulWidget>> keyLoader, int userid) async {
    if (dropdownValue == 'Select') {
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text('Please Select Values')));
    } else {
      final formData = {
        'user_id': userid,
        'name': dropdownValue,
        'fat': fat,
        'snf': snf,
        'clr': clr,
      };
      try {
        Dio _dio = new Dio();
        _dio.options.contentType = Headers.formUrlEncodedContentType;
        final responseData = await _dio.post<Map<String, dynamic>>(
            '/api/addanalyzerdata',
            options: RequestOptions(
                method: 'POST',
                headers: <String, dynamic>{},
                baseUrl: ApiBaseUrl.base_url),
            data: formData);
        AddAnalyzeResponse user =
            AddAnalyzeResponse.fromJson(responseData.data);
        if (user.status == 200) {
          getweightUser(_keyLoader, _userId);
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user.message)));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeMainScreen()),
              (route) => false);
        }
      } catch (e) {
        final errorMessage = DioExceptions.fromDioError(e);
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(errorMessage.toString())));
      }
    }
  }

  Future<void> updateWeigning(
      GlobalKey<State<StatefulWidget>> keyLoader, int userid) async {
    if (dropdownValue == 'Select') {
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text('Please Select Values')));
    } else {
      final formData = {
        'user_id': userid,
        'name': dropdownValue,
        'fat': fat,
        'snf': snf,
        'clr': clr,
      };
      print("updates fat values" + formData.toString());
      try {
        Dio _dio = new Dio();
        _dio.options.contentType = Headers.formUrlEncodedContentType;
        final responseData = await _dio.post<Map<String, dynamic>>(
            '/api/updateanalyzerdata',
            options: RequestOptions(
                method: 'POST',
                headers: <String, dynamic>{},
                baseUrl: ApiBaseUrl.base_url),
            data: formData);
        AddAnalyzeResponse user =
            AddAnalyzeResponse.fromJson(responseData.data);
        if (user.status == 200) {
          getweightUser(_keyLoader, _userId);
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text(user.message)));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeMainScreen()),
              (route) => false);
        }
      } catch (e) {
        final errorMessage = DioExceptions.fromDioError(e);
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(errorMessage.toString())));
      }
    }
  }

  Future<void> addWeigning(
      GlobalKey<State<StatefulWidget>> keyLoader, int userid) async {
    if (dropdownValue == 'Select') {
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text('Please Select Values')));
    }

    final formData = {'user_id': userid, 'name': dropdownValue};
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      final responseData = await _dio.post<Map<String, dynamic>>('/api/weight',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      AddWeightResponse user = AddWeightResponse.fromJson(responseData.data);
      if (user.status == 200) {
        getweight(_keyLoader, _userId);
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
      }
    } catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
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
