import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraUtils {
  static Future<void> logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Navigator.of(context).popUntil((route) => route.isFirst);
    preferences.setBool(Preferences.is_logged_in, false);
    preferences.setString(Preferences.auth_token, "");
    Navigator.of(context).pushReplacementNamed(Routes.splash);
  }
}
