import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    splashToOther(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light
        ),
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          //child: Image.asset("assets/images/logo.png"),
          child: Text("Accounting App",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  splashToOther(context){
    Future.delayed(const Duration(seconds: 5),() {
      if(FirebaseAuth.instance.currentUser!=null){
        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).
        get().then((documentSnapshot) {
          bool isCompanyCreated = documentSnapshot.get("isCompanyCreated");
          if(!isCompanyCreated){
            Navigator.pushReplacementNamed(context, "/companyRegisterScreen");
          }else{
            Navigator.pushReplacementNamed(context, "/main");
          }
        }).catchError((e){
          Get.snackbar("error", e.toString());
        });
     }else{
        Navigator.pushReplacementNamed(context, "/login");
       // Navigator.pushNamed(context, "/login");
     }
    });
  }
}
