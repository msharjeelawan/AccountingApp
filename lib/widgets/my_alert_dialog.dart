import 'package:flutter/material.dart';

class MyAlertDialog{

  static void show(context){
    showDialog(
        context: context, barrierDismissible: false, builder: (context) {
      return AlertDialog(
        title: const Text("Please wait"),
        content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator()
            ]
        ),
      );
    });
  }

  static void hide(context){
    Navigator.pop(context);
  }
}