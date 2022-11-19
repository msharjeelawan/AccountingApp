import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/User.dart';
import '../Model/client_model.dart';
import '../service/firebase_crud_methods.dart';
import '../widgets/MyScaffold.dart';
import '../widgets/my_alert_dialog.dart';

class ClientsController extends GetxController{

  final formKey = GlobalKey<FormState>();
  String? name, email, contactNo, address, passportNo, idCardNo, nationality, profilePicUrl, registerDate;
  final passportExpiry = TextEditingController().obs, dob = TextEditingController().obs;
  final lengthOfMyClientsInFirestore = 0.obs;
  final imageFile = File("").obs;

  Future<List<ClientModel>> getClients(context) async {
    var clientDocumentList = await FirebaseCrudMethods(context: context).query(collection: "clients", field: "companyId", isEqualTo: UserModel.myInstance.companyId,showDialog: false);
    return ClientModel.mapToModel(clientDocumentList);
  }

  Future<void> addClient(context) async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      //convert input to Pascal Case
      name = convertToPascalCase(name!);
      address = convertToPascalCase(address!);
      nationality = convertToPascalCase(nationality!);

      //check if supplier is available in firestore or not
      var documentList = await FirebaseCrudMethods(context: context).doubleQuery(collection: "clients", fields: ["companyId","passport"], isEqualTo: [UserModel.myInstance.companyId,passportNo]);

      if(imageFile.value.path.isNotEmpty && documentList.isEmpty){
        //upload image if available
        //show dialog during image upload
        MyAlertDialog.show(context);
        //upload image
        await uploadImage().then((value) {
          MyAlertDialog.hide(context);
          //MyScaffold.show(context, "Image Uploaded Successfully");
        }).catchError((e){
          MyAlertDialog.hide(context);
          MyScaffold.show(context, e.toString());
        });

      }

      if(documentList.isEmpty){
        //now create client registration date
        registerDate = DateTime.now().toString();
        var clientMap={
          "name":name,
          "email":email,
          "contact":contactNo,
          "address":address,
          "passport":passportNo,
          "id_card":idCardNo,
          "nationality": nationality,
          "profile_pic":profilePicUrl,
          "companyId":UserModel.myInstance.companyId,
          "addedBy":UserModel.myInstance.id,
          "p_expiry":passportExpiry.value.text,
          "dob":dob.value.text,
          "register_date":registerDate
        };
        var documentRef = await FirebaseCrudMethods(context: context).insert(collection: "clients", map: clientMap);

        var list = ClientModel.addSingleSupplierInModelList(documentRef.id, name, email, contactNo, address, passportNo, passportExpiry.value.text, dob.value.text, idCardNo, nationality,registerDate,profilePicUrl);
        updateClientsListLength(list);
      }else{
        MyScaffold.show(context, "Client already available in your Client list");
        return;
      }

      Navigator.pop(context);
    }

  }

  String convertToPascalCase(String value){
    value = value.toLowerCase();
    var wordList = value.split(" ");
    var newWord="";
    wordList.forEach((word) {
      newWord += " ${word.capitalize!}";
    });
    return newWord.trim();
  }

  void updateClientsListLength(List list){
    lengthOfMyClientsInFirestore.value = list.length;
  }

  Future<void> uploadImage() async {
    //upload image in firebase storage and add image url in fb db
    TaskSnapshot snapshot = await FirebaseStorage.instance.ref("clientProfilePics").child(Timestamp.now().microsecondsSinceEpoch.toString()).putFile(imageFile.value);
    profilePicUrl = await snapshot.ref.getDownloadURL();
  }

}