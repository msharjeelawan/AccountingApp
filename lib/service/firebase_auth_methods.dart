
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';
import 'package:travel_accounting/widgets/my_alert_dialog.dart';

import '../Views/otp_screen.dart';

class FirebaseAuthMethods{

  final firebaseAuth=FirebaseAuth.instance;
  final BuildContext context;
  FirebaseAuthMethods({required this.context});

  Future<UserCredential> createUserWithEmailPassword({required email,required password}) async {
   return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).catchError((e){
     MyAlertDialog.hide(context);
     MyScaffold.show(context, e.toString());
    });
  }

  void authUserWithPhone({required number,required fromLoginPage}){
    MyAlertDialog.show(context);
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential){},
        verificationFailed: (FirebaseAuthException e){
          MyScaffold.show(context, e.toString());
        },
        codeSent: (verificationId,resendToken){
          MyAlertDialog.hide(context);
          MyScaffold.show(context, "Otp Send");
          //user can resend otp from otp screen
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
            return OTPScreen(code: verificationId,token: resendToken,isLogin: fromLoginPage);
          }));
        },
        codeAutoRetrievalTimeout: (value){
          print("codeAutoRetrievalTimeout $value");
        }
    ).catchError((e){
      MyAlertDialog.hide(context);
      MyScaffold.show(context, e.toString());
    });;
  }

  Future<UserCredential> loginWithEmailPassword({required email,required password}) async {
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).catchError((e){
      MyAlertDialog.hide(context);
      MyScaffold.show(context, e.toString());
    });
  }
}