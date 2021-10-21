import 'package:dairy_newdeskapp/ui/TabBarDemo.dart';
import 'package:dairy_newdeskapp/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

import '../main.dart';

void main() => runApp(new MyApp());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
        body: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            decoration: BoxDecoration(color: Colors.white),
            child: TabBarDemo()));
  }

  void tabBar() {
    return tabBar();
  }
}
