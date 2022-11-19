import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';
import 'package:travel_accounting/widgets/my_alert_dialog.dart';

class FirebaseCrudMethods{

  final BuildContext context;
  final fbInstance=FirebaseFirestore.instance;
  FirebaseCrudMethods({required this.context});

  Future<DocumentReference<Map<String, dynamic>>> insert({required String collection, required map}) async {
    MyAlertDialog.show(context);
    return await fbInstance.collection(collection).add(map).then((document) {
      MyAlertDialog.hide(context);
      MyScaffold.show(context, "Added successfully");
      return document;
    }).catchError((e){
      MyAlertDialog.hide(context);
      MyScaffold.show(context, e.toString());
    });
  }

  Future<void> insertWithCustomKey({required String collection,required String key, required map}) async {
    MyAlertDialog.show(context);
     await fbInstance.collection(collection).doc(key).set(map).then((document) {
      MyAlertDialog.hide(context);
      MyScaffold.show(context, "Added successfully");
      return document;
    }).catchError((e){
      MyAlertDialog.hide(context);
      MyScaffold.show(context, e.toString());
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String,dynamic>>>> query({required String collection,required field,required isEqualTo,bool showDialog=true}) async {
    _showDialog(context: context,showDialog: showDialog);
    return await fbInstance.collection(collection).where(field,isEqualTo: isEqualTo).get().then((query){
      _hideDialog(context: context,showDialog: showDialog);
      return query.docs;
    }).catchError((e){
      _hideDialog(context: context,showDialog: showDialog);
      MyScaffold.show(context, e.toString());
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String,dynamic>>>> doubleQuery({required String collection,required fields,required isEqualTo,bool showDialog=true}) async {
    _showDialog(context: context,showDialog: showDialog);
    // print(fields.first);
    // print(isEqualTo.first);
    // print(fields[1]);
    // print(isEqualTo[1]);
    //
    return await fbInstance.collection(collection).where(fields.first,isEqualTo: isEqualTo.first)
        .where(fields[1],isEqualTo: isEqualTo[1]).get().then((query){
      _hideDialog(context: context,showDialog: showDialog);
      return query.docs;
    }).catchError((e){
      _hideDialog(context: context,showDialog: showDialog);
      MyScaffold.show(context, e.toString());
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String,dynamic>>>> readAll({required String collection,bool showDialog=true}) async {
    _showDialog(context: context,showDialog: showDialog);
    return await fbInstance.collection(collection).get().then((query){
      _hideDialog(context: context,showDialog: showDialog);
      return query.docs;
    }).catchError((e){
      _hideDialog(context: context,showDialog: showDialog);
      MyScaffold.show(context, e.toString());
    });
  }

  void update({required String collection,required documentId,required data}){
    MyAlertDialog.show(context);
    fbInstance.collection(collection).doc(documentId).update(data).then((document){
      MyAlertDialog.hide(context);
    }).catchError((e){
      MyAlertDialog.hide(context);
      MyScaffold.show(context, e.toString());
    });
  }

  void delete(){

  }

  void _showDialog({context,bool showDialog=true}){
    showDialog==true? MyAlertDialog.show(context):null;
  }

  void _hideDialog({context,bool showDialog=true}){
    showDialog==true? MyAlertDialog.hide(context):null;
  }
}