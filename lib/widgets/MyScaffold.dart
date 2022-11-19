import 'package:flutter/material.dart';

class MyScaffold{
 static void show(context,message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}