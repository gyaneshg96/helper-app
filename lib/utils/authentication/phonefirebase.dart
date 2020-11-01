import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PhoneAuth {
  TextEditingController codeController;
  BuildContext context;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  PhoneAuth(codeController, context);

  void buildVerifyDialog(String verificationId, [int forceResendingToken]) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Enter SMS Code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Done"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () async {
                    final smsCode = codeController.text.trim();

                    final _credential = PhoneAuthProvider.getCredential(
                        verificationId: verificationId, smsCode: smsCode);

                    return await authCallBack(_credential);
                  },
                )
              ],
            ));
  }

  Future authCallBack(AuthCredential authCredential) async {
    AuthResult result =
        await _firebaseAuth.signInWithCredential(authCredential);
    //we need userid
    return result.user.uid;
  }
}
