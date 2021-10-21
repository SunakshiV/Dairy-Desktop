import 'package:dairy_newdeskapp/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'SignInScreen.dart';
import 'SignUpScreen.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: TabBar(
              indicatorColor: AppColors.white,
              unselectedLabelColor: AppColors.black,
              labelColor: AppColors.white,
              tabs: [
                Tab(
                  child: Text('Sign Up'),
                ),
                Tab(child: Text('Sign In')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SignUpScreen(),
              SignInScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
