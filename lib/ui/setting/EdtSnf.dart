import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditSnf extends StatefulWidget {
  @override
  EditSnfState createState() => EditSnfState();
}

class EditSnfState extends State<EditSnf> {
  int select, valueRadio;
  String radioButtonItem = 'Item Purchase';

  // Group Value for Radio Button.
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 80,
        child: Card(
          color: AppColors.accountbgcolor,
          elevation: 10,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Version: 23.45.2.45 (Starter), Powered by dairy management',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Legal Notices',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
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
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dairy and the Dairy management logo are either registered trademarks or trademarks of Dairy in the United States and/or other countries. ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.centerLeft,
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
                margin: EdgeInsets.all(10),
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
            ],
          ),
        ),
      ),
    );
  }
}
