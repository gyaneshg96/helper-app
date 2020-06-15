import 'dart:async';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.lightBlue,
        child: Column(children: <Widget>[
          AppIconWidget(image: 'assets/icons/ic_appicon.png'),
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.signup);
              },
              child: Text('Get Started !')),
          Text('Already a member ?'),
          InkWell(
            child: Text(
              ' Log In',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.login);
            },
          )
        ]));
  }

  startTimer() {
    var _duration = Duration(milliseconds: 5000);
    // return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.signup);
    }
  }
}
