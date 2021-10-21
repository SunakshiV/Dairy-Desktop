import 'package:dairy_newdeskapp/model/FaqResponse.dart';
import 'package:dairy_newdeskapp/utils/ApiBaseUrl.dart';
import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/Controllers.dart';
import 'package:dairy_newdeskapp/utils/PrefConstant.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpDesk extends StatefulWidget {
  @override
  HelpDeskState createState() => HelpDeskState();
}

class HelpDeskState extends State<HelpDesk> {
  int select, valueRadio;
  String radioButtonItem = 'Item Purchase';

  int _userId;
  GlobalKey<State> _keyLoader = new GlobalKey<State>();
  int id = 1;
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
                  'Helpline Number',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,fontWeight:FontWeight.bold
                  ),
                ),
              ),

              Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 10,
                child: Text(
                  'Helpline Number 0178-0203986, 0172-0265854 contact us for more information.',
                  textAlign: TextAlign.start,
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
                        controller: Controllers.helpnotes,
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
      'note': Controllers.helpnotes.text,
      'user_id': _userId
    };
    print(formData);
    try {
      Dio _dio = new Dio();
      _dio.options.contentType = Headers.formUrlEncodedContentType;

      final responseData = await _dio.post<Map<String, dynamic>>(
          '/api/help_helpline',
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              baseUrl: ApiBaseUrl.base_url),
          data: formData);

      FaqResponse user = FaqResponse.fromJson(responseData.data);
      if (user.status == 200) {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(user.message.toString())));
        Controllers.helpnotes.text='';
      }
    } catch (e) {

    }
  }
}
