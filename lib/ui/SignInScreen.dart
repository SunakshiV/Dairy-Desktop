import 'dart:ui';

import 'package:dairy_newdeskapp/model/LoginResponse.dart';
import 'package:dairy_newdeskapp/ui/ForgotPassScreen.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/HomeMainScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
// TODO: implement createState

/* @override
 */
}

class SignUpState extends State<SignInScreen> {
  var value = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var showpass = false;
  @override
  Future<void> initState() {
    super.initState();
    Controllers.login_email.text = '';
    Controllers.login_password.text = '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _isChecked = false;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
          margin: EdgeInsets.only(left: 300, right: 300),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email/Phone Number',
                    style: TextStyle(color: AppColors.black, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    controller: Controllers.login_email,
                    decoration: InputDecoration(
                        labelText: '',
                        hoverColor: AppColors.lightBlue,
                        border: OutlineInputBorder()),
                    // ignore: missing_return
                    validator: (value) {
                      // ignore: missing_return, missing_return, missing_return
                      if (value.isEmpty) {
                        return 'Enter Email';
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(color: AppColors.black, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    obscureText: !this.showpass,
                    controller: Controllers.login_password,
                    decoration: InputDecoration(
                        hoverColor: AppColors.lightBlue,
                        border: OutlineInputBorder()),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassScreen(),
                          settings: RouteSettings(name: 'forgotscreen')),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(color: AppColors.homeBlue, fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 20,
                    height: SizeConfig.blockSizeVertical * 7,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),

                        ],
                      ),
                    ),
                  ),
                  onTap: (

                      ) {
                    if (_formKey.currentState.validate()) {
                      Dialogs.showLoadingDialog(context, _keyLoader);
                      signInUser(
                        _keyLoader,
                        Controllers.login_email.text,
                        Controllers.login_password.text,
                      );
                    }
                    else {

                    }
                  },
                )
              ],
            ),
          ))),
    );
  }

  void nextscreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeMainScreen()),
        (route) => false);
  }

  Future<void> signInUser(GlobalKey<State<StatefulWidget>> keyLoader,
      String email, String password) async {

     if (EmailValidator.validate(email)) {
       final formData = {
         'email': email,
         'password': password,
       };
       try {
         Dio _dio = new Dio();
         _dio.options.contentType = Headers.formUrlEncodedContentType;
         final responseData = await _dio.post<Map<String, dynamic>>('/api/login',
             options: RequestOptions(
                 method: 'POST',
                 headers: <String, dynamic>{},
                 baseUrl: ApiBaseUrl.base_url,
                 data: formData));

         LoginResponse user = LoginResponse.fromJson(responseData.data);

         if (user.status == 200) {
           Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
           Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(user.message)));
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setInt(PrefConstant.user_id, user.data.id);
           prefs.setString(PrefConstant.user_name, user.data.name);
           prefs.setString(PrefConstant.user_lname, user.data.lname);
           prefs.setString(PrefConstant.user_email, user.data.email);
           nextscreen();
         }
       } catch (e) {
         Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
         final errorMessage = DioExceptions.fromDioError(e);
         Scaffold.of(context).showSnackBar(
             new SnackBar(content: new Text(errorMessage.toString())));
       }
    }
     else {
       final formData = {
         'phone_number': email,
         'password': password,
       };
       try {
         Dio _dio = new Dio();
         _dio.options.contentType = Headers.formUrlEncodedContentType;
         final responseData = await _dio.post<Map<String, dynamic>>('/api/login',
             options: RequestOptions(
                 method: 'POST',
                 headers: <String, dynamic>{},
                 baseUrl: ApiBaseUrl.base_url,
                 data: formData));

         LoginResponse user = LoginResponse.fromJson(responseData.data);

         if (user.status == 200) {
           Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
           Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(user.message)));
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setInt(PrefConstant.user_id, user.data.id);
           prefs.setString(PrefConstant.user_name, user.data.name);
           prefs.setString(PrefConstant.user_lname, user.data.lname);
           prefs.setString(PrefConstant.user_email, user.data.email);
           nextscreen();
         }
       } catch (e) {
         Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
         final errorMessage = DioExceptions.fromDioError(e);
         Scaffold.of(context).showSnackBar(
             new SnackBar(content: new Text(errorMessage.toString())));
       }
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
        /* Fluttertoast.showToast(
          msg: 'Login Failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
        );*/
        return 'Invalid Credendials';
      case 404:
        /*Fluttertoast.showToast(
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
