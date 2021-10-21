import 'dart:ui';

import 'package:dairy_newdeskapp/model/ForGotResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/Dialogs.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ChangePasswordScreen.dart';


class ForgotPassScreen extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<ForgotPassScreen> {
  var value = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              Container(
                  color: AppColors.forgotcolor,
                  width: double.infinity,
                  height: 50,
                child: Row(
                  children: <Widget>[
                    InkWell(
                     onTap: (){
                      setState(() {
                       Navigator.of(context).pop();
                      });
                      },
                      child:Container(
                          height: 50,
                          width: 10,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10),
                          child: new Icon(Icons.arrow_back,color: AppColors.white,)
                      ),
                    ),

                    Container(
                     height: 50,
                      width: SizeConfig.blockSizeHorizontal*90,
                      alignment: Alignment.center,
                      child: Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.white, fontSize: 15,),
                      ),
                    )
                  ],
                )

              ),

              Container(
                margin: EdgeInsets.only(left:300,right: 300,top: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: TextStyle(color: AppColors.black, fontSize: 15),
                ),
              ),
              Container(
               margin: EdgeInsets.only(left:300,right: 300,top: 10),
               alignment: Alignment.topLeft,
                child: TextFormField(
                  controller: Controllers.forgot_email,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: '',
                      hoverColor: AppColors.lightBlue,
                      border: OutlineInputBorder()),
                  // ignore: missing_return
                  validator: (value) {
                    // ignore: missing_return
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                  },

                ),
              ),
              InkWell(
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeVertical * 7,
                  margin: EdgeInsets.only(left:300,right: 300,top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'Submit',
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
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        forgotPass(_keyLoader, Controllers.forgot_email.text,);
                        }
                           else {
                        Fluttertoast.showToast(
                          msg: "Agree Terms , Privacy and Notifications",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      }

                       },
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<void> forgotPass(GlobalKey<State<StatefulWidget>> keyLoader, String email) async {

    final formData = {
      'email': email,

    };
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;
         final responseData = await _dio.post<Map<String, dynamic>>('/api/auth/sendPasswordResetLink',
          options: RequestOptions(
             method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      ForGotResponse user = ForGotResponse.fromJson(responseData.data);
      print(user.status);
      if(user.status==200){
        Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(user.message)));
        print(responseData.data);
        nextscreen();
      }

    }
    catch (e) {
      Navigator.of(keyLoader.currentContext, rootNavigator: true).pop();
      final errorMessage = DioExceptions.fromDioError(e,context);
      print("-----"+errorMessage.toString());
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(errorMessage.toString())));
    }

  }
  void nextscreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(),
          settings: RouteSettings(name: 'changepass')),
    );
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
        message = _handleError(context1,dioError.response.statusCode, dioError.response.data);
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

  String _handleError(BuildContext context2,int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        Scaffold.of(context2).showSnackBar(new SnackBar(content: new Text("Email does't found on our database")));
        return 'Email does not found on our database';
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

