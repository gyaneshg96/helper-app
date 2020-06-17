import 'package:boilerplate/ui/profiles/helperProfile.dart';
import 'package:flutter/material.dart';

import 'ui/home/home.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';
import 'ui/signup/signup.dart';
import 'ui/started/started.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String userProfile = '/userProfile';
  static const String helperProfile = '/helperProfile';
  static const String started = '/started';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    signup: (BuildContext context) => SignupScreen(),
    started: (BuildContext context) => StartedScreen(),
    helperProfile: (BuildContext context) => HelperProfile(),
  };
}
