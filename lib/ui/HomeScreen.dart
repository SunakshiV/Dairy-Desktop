import 'dart:async';

import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'MainScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  double percent = 0.0;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    Timer timer;
    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() {
        percent += 1;
        if (percent >= 1) {
          timer.cancel();
        }
        nextScreen();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hieght = MediaQuery.of(context).size.height;
    print(width);
    print(hieght);
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/image/splashbg.png"),
                  fit: BoxFit.cover)),
          child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 300,
                    width: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assests/image/splashlogo.png"),
                            fit: BoxFit.fill))),
                Container(
                  margin: EdgeInsets.all(50),
                  child: Stack(
                    children: <Widget>[
                      //Container
                      Container(
                          width: 300,
                          height: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Container(
                              color: Colors.black,
                            ),
                          )),

                      Container(
                          margin: EdgeInsets.all(10),
                          width: 280,
                          height: 10,
                          child: LinearProgressIndicator(
                            backgroundColor: AppColors.blueDark,
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.lightBlue),
                            minHeight: 10,
                          )),
                      //Container
                      //Container
                    ],
                  ),
                ),

              ],
            ),
          )),
    );
  }

  void nextScreen() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false);
    });
  }
}
