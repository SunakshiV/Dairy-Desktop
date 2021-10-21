import 'package:dairy_newdeskapp/model/FaqResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FAQ extends StatefulWidget {
  @override
  FAQState createState() => FAQState();
}

class FAQState extends State<FAQ> {
  int select, valueRadio;
  String radioButtonItem = 'Item Purchase';
  int _userId;
  int id = 1;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
        width: SizeConfig.blockSizeHorizontal * 80,
        child: Card(
          color: AppColors.accountbgcolor,
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  'FAQ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,fontWeight:FontWeight.bold
                  ),
                ),
              ),
              Container(

                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  '© 2016-2021 Dairy Management. All rights reserved.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 50,

                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 8,
                child: Text(
                  'Dairy and the Dairy management logo are either registered trademarks or trademarks of Dairy in the United States and/or other countries. ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 8,
                child: Text(
                  'Third Party notices, terms and conditions pertaining to third party software can be found at http://www.adobe.com/go/thirdparty_eula/ and are incorporated by reference. ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 50,

                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 10,
                child: Text(
                  'Fonts will be sent to your device(s) when you preview on mobile. Please be aware that certain font vendors do not allow for the transfer, display and distribution of their fonts. You are responsible for ensuring that you respect the font license agreement between you and the applicable font vendor',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

              Container(
                width: 700,
                child:   Column(

                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only( left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Notes',
                        style: TextStyle(
                            color: AppColors.black, fontSize: 15),
                      ),
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 10,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: TextField(
                        controller: Controllers.faqnotes,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            labelText: 'type here',
                            hoverColor: AppColors.lightBlue,
                            border: OutlineInputBorder()),
                      ),
                    ),
                    InkWell(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 7,
                          height: SizeConfig.blockSizeVertical * 4,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeVertical * 2),
                          alignment: Alignment.center,
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18),
                          ),
                          decoration:
                          BoxDecoration(color: AppColors.yellow),
                        ),
                      ),
                      onTap: () {
                         addFaq(_keyLoader,_userId);

                        // Scaffold.of(context).showSnackBar(new SnackBar(
                        //     content: new Text("Sent Email")));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> addFaq(
      GlobalKey<State<StatefulWidget>> keyLoader,int userid) async {
    final formData = {
      'note': Controllers.faqnotes.text,
      'user_id': _userId
    };
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/help_faq',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      FaqResponse user = FaqResponse.fromJson(responseData.data);
      if (user.status == 200) {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(user.message.toString())));
        Controllers.faqnotes.text='';
      }
    } catch (e) {

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
