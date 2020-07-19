import 'dart:async';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/utils/authentication/baseauth.dart';
import 'package:boilerplate/utils/authentication/firebase_auth.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class SplashScreen extends StatefulWidget {
  final BaseAuth auth = new FBAuth();

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthStatus authStatus;
  String _userId;

  @override
  void initState() {
    super.initState();
    // startTimer();
    SharedPreferences.getInstance().then((preferences) {
      if (preferences.getBool(Preferences.is_logged_in) ?? false) {
        setState(() {
          authStatus = AuthStatus.NOT_LOGGED_IN;
          _userId = "";
        });
      } else {
        setState(() {
          authStatus = AuthStatus.LOGGED_IN;
          _userId = preferences.getString(Preferences.auth_token);
        });
      }
    });
    /*setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });*/
    /*widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });*/
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return getLogoutPage(context);
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          // User user = _getUserData(currentUser);
          return new HomeScreen(userId: _userId);
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }

  Widget getLogoutPage(BuildContext context) {
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

  /*navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ??
        false && preferences.getString(Preferences.auth_token) == "") {
      authStatus = AuthStatus.NOT_LOGGED_IN;
    } else {
      authStatus = AuthStatus.LOGGED_IN;
    }
  }*/

  Widget buildWaitingScreen() {
    return CircularProgressIndicator(backgroundColor: Colors.amber);
  }
}
