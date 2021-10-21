import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:flutter/material.dart';

class Dialogs extends Dialog {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: null,
                  children: <Widget>[
                    Center(
                        child: Container(
                          child: Column(children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10,),
                            Text("Loading....",style: TextStyle(color: AppColors.blueDark),)
                          ]),
                        )
                    )
                  ]));
        });
  }
}