
import 'package:fluttertoast/fluttertoast.dart';

class MyToast{
  static show(msg){
    return Fluttertoast.showToast(msg: msg);
  }
}