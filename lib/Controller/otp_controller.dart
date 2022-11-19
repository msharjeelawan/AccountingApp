import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_accounting/Model/User.dart';

import '../service/firebase_crud_methods.dart';
import '../widgets/MyScaffold.dart';

enum Status{
  incorrect,
  match,
  resend
}

class OtpController extends GetxController{

  final FocusNode f1=FocusNode(),f2=FocusNode(),f3=FocusNode(),f4=FocusNode(),
      f5=FocusNode(),f6=FocusNode();
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  String code = "";
  int? token;
  bool isLogin=true;
  final formKey = GlobalKey<FormState>();
  List<String> messageList = ["OTP is incorrect","OTP correct, Please login to continue","OTP resend"];
  String message="Please enter security code which has been sent to your Number";
  final terms=false.obs;

  void checkTerms(){
    terms.value = terms.value? false:true;
  }

  // void showMessage(Status status){
  //   //if you want to show more message then replace ternary operator with switchcase
  //   //status==Status.incorrect? message=messageList[0]:message=messageList[1];
  //   switch(status){
  //     case Status.incorrect:
  //       message=messageList[0];
  //       break;
  //     case Status.match:
  //       message=messageList[1];
  //       break;
  //     case Status.resend:
  //       message=messageList[2];
  //       break;
  //   }
  // }

  void resend(context){
    // showMessage(Status.resend);
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:  UserModel.myInstance.number!,
        forceResendingToken: token,
        verificationCompleted: (PhoneAuthCredential credential){},
        verificationFailed: (FirebaseAuthException e){
          MyScaffold.show(context, e.message!);
        },
        codeSent: (String id,int? resendCode){
          code=id;
          token=resendCode;
          MyScaffold.show(context, "Otp resend");
        },
        codeAutoRetrievalTimeout: (String id){}
    );
  }

  void confirmOTP(context) async {
    if (terms.value) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        String otp = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: code, smsCode: otp);
        await FirebaseAuth.instance.signInWithCredential(credential).then((
            UserCredential credential) async {
          //if user come from login screen
          if (credential.user == null) return;
          if (isLogin) {
            FirebaseCrudMethods(context: context).query(collection: "users", field: "id", isEqualTo: credential.user!.uid)
                .then((documentList) {
                  if(documentList.isEmpty){
                    //if user is login using phone but not register then its need to store in firestore
                    addUserInFirestore(context,credential);
                    return;
                  }
                  saveUserInfoToUserModelInstance(credential: credential, userDocument: documentList.first);
                  if (documentList.first.get("isCompanyCreated")) {
                    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                    MyScaffold.show(context, "Login Successfully");
                  } else {
                    navigateToCompanyRegistration(context);
                  }
                });
          }else {
            addUserInFirestore(context,credential);
          }
        }).catchError((e) {
          //update message value
          MyScaffold.show(context, e.message!);
        });

        ///Navigator.pop(context,otp);
      }
    } else {
      MyScaffold.show(context, "Please check terms of service");
    }
  }

  Future<void> addUserInFirestore(context,credential) async {
    //create user in firestore
    var userMap = {
      //"id": credential.user!.uid,
      "isCompanyCreated": false,
      "number": UserModel.myInstance.number!,
      "name": UserModel.myInstance.name,
      "role": "admin"
    };
    await FirebaseCrudMethods(context: context).insert(
        collection: "users", map: userMap);
    navigateToCompanyRegistration(context);

  }

  void navigateToCompanyRegistration(context){
    Navigator.pushNamedAndRemoveUntil(context, '/companyRegisterScreen', (route) => false);
    MyScaffold.show(context, "Create Company profile with basic info");
  }

  void saveUserInfoToUserModelInstance({credential,userDocument}){
    UserModel.myInstance.id=credential.user!.uid;
    UserModel.myInstance.name=userDocument.get("name");
    UserModel.myInstance.role=userDocument.get("role");
    UserModel.myInstance.number=userDocument.get("number");
    UserModel.myInstance.companyId=userDocument.data()["companyId"] ?? "";
  }
}