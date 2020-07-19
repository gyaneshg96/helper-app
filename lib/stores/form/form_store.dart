import 'dart:convert';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/authentication/baseauth.dart';
import 'package:boilerplate/utils/authentication/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();
  final Firestore store = Firestore.instance;

  static const String USERS_JSON = "assets/dummy/users.json";

  BaseAuth auth = FBAuth();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _FormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => fullName, validateFullName),
      reaction((_) => password, validatePassword),
      reaction((_) => phoneNumber, validatePhoneNumber),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = 'gyanu@gmail.com';

  @observable
  String password = 'sallubhai';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  String fullName = 'Gyanesh';

  @observable
  String phoneNumber = '7054620753';

  @computed
  bool get canLoginEmail =>
      !formErrorStore.hasErrorsInEmailLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;
  @computed
  bool get canLoginPhone =>
      !formErrorStore.hasErrorsInPhoneLogin &&
      phoneNumber.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegisterEmail =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      fullName.isNotEmpty;

  @computed
  bool get canRegisterPhoneNumber =>
      !formErrorStore.hasErrorsInRegister &&
      phoneNumber.isNotEmpty &&
      password.isNotEmpty &&
      fullName.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setFullName(String value) {
    fullName = value;
  }

  @action
  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validateFullName(String value) {
    if (value.isEmpty) {
      formErrorStore.fullName = "Full Name cannot be empty";
    } else {
      formErrorStore.fullName = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      formErrorStore.fullName = "Phone Number cannot be empty";
    } else if (isPhoneNumber(value)) {
      formErrorStore.fullName = "Invalid Phone Number";
    } else {
      formErrorStore.fullName = null;
    }
  }

  @action
  Future register() async {
    success = false;
    loading = true;
    try {
      var future = await signupUtil2();
      //widget.auth.sendEmailVerification();
      //_showVerifyEmailSentDialog();

      //write into database
      await store
          .collection('users')
          .document(future)
          .setData({"emailId": userEmail, "fullName": fullName});

      //
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool(Preferences.is_logged_in, true);
      preferences.setString(Preferences.auth_token, future);
      return future;
    } catch (e) {
      success = false;
      errorStore.errorMessage = e.message;
      print(e);
    } finally {
      loading = false;
    }
    return "";
  }

  @action
  Future login() async {
    loading = true;
    try {
      var future = await loginUtil2();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool(Preferences.is_logged_in, true);
      preferences.setString(Preferences.auth_token, future);
      return future;
    } catch (e) {
      success = false;
      errorStore.errorMessage = e.message;
    } finally {
      loading = false;
    }
    return "";
  }

  Future signupUtil() async {
    List<dynamic> dyn =
        json.decode(await rootBundle.loadString(USERS_JSON))["users"] as List;
    Iterable<User> users = dyn.map((json) => new User(
        id: int.parse(json["id"]),
        fullname: json["fullname"],
        phoneNumber: json["phoneNumber"],
        male: json["male"] == "true",
        password: json["password"]));
    User newuser = new User(
        fullname: fullName, phoneNumber: phoneNumber, password: password);
    users.toList().add(newuser);
  }

  Future loginUtil() async {
    List<dynamic> dyn =
        json.decode(await rootBundle.loadString(USERS_JSON))["users"] as List;
    Iterable<User> users = dyn.map((json) => new User(
        id: int.parse(json["id"]),
        fullname: json["fullname"],
        phoneNumber: json["phoneNumber"],
        male: json["male"] == "true",
        password: json["password"]));
    for (User user in users) {
      if (user.phoneNumber == phoneNumber) {
        if (user.password == password) {
          return user;
        } else {
          return 1;
        }
      }
    }
    return 2;
  }

  Future loginUtil2() async {
    return auth.signInEmail(userEmail, password);
  }

  Future signupUtil2() async {
    return auth.signUpEmail(userEmail, password);
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  bool isPhoneNumber(String value) {
    return (value.length == 10) && (isNumeric(value));
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
    validateFullName(fullName);
    validatePhoneNumber(phoneNumber);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String userEmail;

  @observable
  String password;

  @observable
  String confirmPassword;

  @observable
  String phoneNumber;

  @observable
  String fullName;

  @computed
  bool get hasErrorsInEmailLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInPhoneLogin => phoneNumber != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null ||
      password != null ||
      confirmPassword != null ||
      fullName != null ||
      phoneNumber != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;
}
