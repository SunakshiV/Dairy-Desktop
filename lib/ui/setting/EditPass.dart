import 'package:dairy_newdeskapp/model/ChangePass.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPass extends StatefulWidget {
  @override
  EditPassState createState() => EditPassState();
}

class EditPassState extends State<EditPass> {
  int _userId;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int id = 1;
  final _formKey = GlobalKey<FormState>();
  bool showpass = false;
  @override
  Future<void> initState()  {
    super.initState();
    _loadID();

  }
  _loadID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt(PrefConstant.user_id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: SizeConfig.blockSizeHorizontal * 100,
          decoration: BoxDecoration(color: AppColors.homeblluebg),
          padding: EdgeInsets.all(20),


          child: SingleChildScrollView(

            child:Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(

                          //   width: MediaQuery.of(context).size.width/2,
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Edit Password',
                                style: TextStyle(
                                    color: AppColors.allaccounttextcolor, fontSize: 18),
                              ),
                            ),


                            Container(
                              margin: EdgeInsets.only( top: 30,),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Old Password',
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          //   width: MediaQuery.of(context).size.width/2,
                          width: SizeConfig.blockSizeHorizontal * 23,
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 50, left: 60),
                              height: SizeConfig.blockSizeVertical * 5,
                              alignment: Alignment.topLeft,
                              child: TextFormField(

                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !this.showpass,
                                controller: Controllers.oldpass,
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
                    child: Row(
                      children: <Widget>[
                        Container(
                          //   width: MediaQuery.of(context).size.width/2,
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 14, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'New Password',
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          //   width: MediaQuery.of(context).size.width/2,
                          width: SizeConfig.blockSizeHorizontal * 23.7,
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20, left: 70),
                              height: SizeConfig.blockSizeVertical * 5,
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !this.showpass,
                                controller: Controllers.newpass,
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
                    child: Row(
                      children: <Widget>[
                        Container(
                          //   width: MediaQuery.of(context).size.width/2,
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 14, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Confirm New Password',
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          //   width: MediaQuery.of(context).size.width/2,
                          width: SizeConfig.blockSizeHorizontal * 20,
                          child: Column(children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20, left: 10),
                              height: SizeConfig.blockSizeVertical * 5,
                              alignment: Alignment.topLeft,
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !this.showpass,
                                controller: Controllers.confirmpass,
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
                  InkWell(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeVertical * 5,
                      margin: EdgeInsets.only(top: 40,left: 200),
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
                      if (Controllers.newpass.text !=
                          Controllers.confirmpass.text){
                        Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text(
                                'Password Should Match')));
                      }
                      else {
                           changePassSever(_keyLoader,_userId);
                      }

                      //   nextscreen();
                    },
                  )
                ],
              ),
            ),

          )),
    );
  }

  Future<void> changePassSever(
      GlobalKey<State<StatefulWidget>> keyLoader,int userid) async {
    final formData = {
      'current_password': Controllers.oldpass.text,
      'new_password': Controllers.newpass.text,
      'new_password_confirmation': Controllers.newpass.text,
      'user_id': _userId
    };
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/password',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);
      ChangePass user = ChangePass.fromJson(responseData.data);
      if (user.status == 200) {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(user.message.toString())));
        Controllers.oldpass.text='';
        Controllers.newpass.text='';
        Controllers.confirmpass.text='';
      }
      else if(user.status==400){
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(user.message.toString())));
      }
    }

    catch (e) {
      final errorMessage = DioExceptions.fromDioError(e, context);
      print("-----" + errorMessage.toString());
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: new Text(errorMessage.toString())));
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
        Scaffold.of(context2).showSnackBar(new SnackBar(
            content: new Text("Your current password does not matches with the password you provided. Please try again.")));
        return 'Your current password does not matches with the password you provided. Please try again.';
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