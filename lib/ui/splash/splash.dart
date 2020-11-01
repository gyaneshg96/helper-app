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
    /*SharedPreferences.getInstance().then((preferences) {
      if (preferences.getBool("isLoggedIn") ?? false) {
        setState(() {
          authStatus = AuthStatus.LOGGED_IN;
          _userId = preferences.getString("authToken");
        });
      } else {
        setState(() {
          authStatus = AuthStatus.NOT_LOGGED_IN;
          _userId = "";
        });
      }
    });*/

    //remove authentication for now

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

  //guest userid = 0

  @override
  Widget build(BuildContext context) {
    /*switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return getLogoutPage(context);
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId != null && _userId.length > 0) {
          // User user = _getUserData(currentUser);
          return new HomeScreen(userId: _userId);
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
      }*/
    return new HomeScreen();
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

  Widget buildWaitingScreen() {
    return CircularProgressIndicator(backgroundColor: Colors.amber);
  }
}
