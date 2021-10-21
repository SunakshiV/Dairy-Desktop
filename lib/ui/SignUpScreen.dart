import 'dart:ui';

import 'package:dairy_newdeskapp/retrofit/registerreponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/HomeMainScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpScreen> {
  var showvalue = false;
  final _formKey = GlobalKey<FormState>();
  bool showpass = false;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();

//  SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _isChecked = false;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
          //  margin: EdgeInsets.only(left:250,right: 250),
          margin: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 20,
              right: SizeConfig.blockSizeHorizontal * 20),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 25,
                        color: AppColors.white,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'First Name',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextFormField(
                              controller: Controllers.firstname,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter First Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 25,
                        color: AppColors.white,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Last Name  ',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextFormField(
                              controller: Controllers.lastname,
                              decoration: InputDecoration(
                                  labelText: '',
                                  hoverColor: AppColors.lightBlue,
                                  border: OutlineInputBorder()),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter Last Name';
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
                  margin: EdgeInsets.only(top: 10, left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(color: AppColors.black, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    controller: Controllers.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: '',
                        hoverColor: AppColors.lightBlue,
                        border: OutlineInputBorder()),
                    // ignore: missing_return
                    validator: (value) {
                      // ignore: missing_return, missing_return, missing_return
                      if (value.isEmpty) {
                        return 'Enter Email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        //   width: MediaQuery.of(context).size.width/2,
                        width: SizeConfig.blockSizeHorizontal * 25,
                        color: AppColors.white,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Phone Number',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextFormField(
                              controller: Controllers.phonenumber,
                              maxLength: 10,
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
                        width: SizeConfig.blockSizeHorizontal * 25,
                        color: AppColors.white,
                        child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Reference Code',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: TextField(
                              controller: Controllers.referencecode,
                              maxLength: 6,
                              decoration: InputDecoration(
                                  labelText: '',
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
                    keyboardType: TextInputType.visiblePassword,
                    controller: Controllers.password,
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
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Confirm Password',
                    style: TextStyle(color: AppColors.black, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: TextFormField(
                    controller: Controllers.confirmpassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !this.showpass,
                    decoration: InputDecoration(

                        hoverColor: AppColors.lightBlue,
                        border: OutlineInputBorder()),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please re-enter password';
                      }

                      if (Controllers.password.text !=
                          Controllers.confirmpassword.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.topLeft,
                  child: CheckboxListTile(
                    value: showvalue,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                        'Creating an account means you’re okay with our Terms of Service, Privacy Policy, and our default Notification Settings.'),
                    onChanged: (bool value) {
                      setState(() {
                        showvalue = value;
                      });
                    },
                  ),
                ),
                InkWell(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 25,
                    height: SizeConfig.blockSizeVertical * 7,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Text(
                      'Create Account',
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
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      if (showvalue) {
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        signUpUser(
                          _keyLoader,
                          Controllers.firstname.text,
                          Controllers.lastname.text,
                          Controllers.email.text,
                          Controllers.phonenumber.text,
                          Controllers.referencecode.text,
                          Controllers.password.text,
                        );
                      } else {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text(
                                'Please Agree Our Terms , Privacy and Notifications')));
                      } // TODO submit

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

  Future<void> signUpUser(
      GlobalKey<State<StatefulWidget>> keyLoader,
      String firstname,
      String lastname,
      String email,
      String phonenumber,
      String referencecode,
      String password) async {
    final formData = {
      'name': firstname,
      'lname': lastname,
      'email': email,
      'phone_number': phonenumber,
      'reference_code': referencecode,
      'password': password,
    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/register',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      registerresponse user = registerresponse.fromJson(responseData.data);
      if (user.status == 200) {
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(PrefConstant.user_id, user.data.id);
        prefs.setString(PrefConstant.user_name, user.data.name);
        prefs.setString(PrefConstant.user_lname, user.data.lname);
        prefs.setString(PrefConstant.user_email, user.data.email);
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text(user.message)));
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
        return 'The email has already been taken.';
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
