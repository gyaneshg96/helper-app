import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInEmail(String email, String password);

  Future<String> signUpEmail(String email, String password);

  // Future<String> signUpPhoneNumber(String phoneNumber, String password);

  // Future<String> signInPhoneNumber(String phoneNumber, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  //Future<void> sendPhoneVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  // Future<bool> isPhoneVerified();
}
