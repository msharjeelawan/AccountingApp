import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_accounting/Model/User.dart';
import 'package:travel_accounting/Model/products_services_model.dart';
import 'package:travel_accounting/service/firebase_crud_methods.dart';


class CompanyRegisterController extends GetxController{

  final formKey = GlobalKey<FormState>();
  final _fiscalMonths = <String>[];
  var selectedFiscalMonth="Select Fiscal Year".obs;
  final imageFile = File("").obs;
  var businessNameFormField = "";
  String imgUrl="";
  var productServices={"Air Ticket":false,"Tourist Visa":false,"Insurance":false,"Tour Packages":false,"Hajj & Umrah":false};

  Future<void> uploadImage() async {
    //upload image in firebase storage and add image url in fb db
    TaskSnapshot snapshot = await FirebaseStorage.instance.ref("companyProfilePics").child(Timestamp.now().microsecondsSinceEpoch.toString()).putFile(imageFile.value);
    imgUrl = await snapshot.ref.getDownloadURL();
  }

  List<String> getFiscalMonths(){
    if(_fiscalMonths.isEmpty){
      _fiscalMonths.add("Select Fiscal Year");
      _fiscalMonths.add("January - December");
      _fiscalMonths.add("February - January");
      _fiscalMonths.add("March - February");
      _fiscalMonths.add("April - March");
      _fiscalMonths.add("May - April");
      _fiscalMonths.add("June - May");
      _fiscalMonths.add("July - June");
      _fiscalMonths.add("August - July");
      _fiscalMonths.add("September August");
      _fiscalMonths.add("October - September");
      _fiscalMonths.add("November - October");
      _fiscalMonths.add("December - November");
    }
    return _fiscalMonths;
  }

  Future<void> next(context) async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      if(selectedFiscalMonth.value==_fiscalMonths.first){
        Get.snackbar("alert", "Please select company fiscal month");
        return;
      }
      //before going to next screen get services from firestore
      await getServicesFromFirestore(context);
    }
  }

  Future<void> createCompanyProfile(context) async {
    //create company map for storing in firestore
    var companyMap = {"name":businessNameFormField,"fiscalYear":selectedFiscalMonth.value,"profileImageUrl":imgUrl};
    var companyDocument = await FirebaseCrudMethods(context: context).insert(collection: "companies", map: companyMap);
    var companyId = companyDocument.id;
    saveCompanyIdInUserModel(companyId);

    //get current login user detail
    var documentList = await FirebaseCrudMethods(context: context).query(collection: "users", field: "id", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    //company has created so now update user profile isCompanyCreated filed in firestore
    FirebaseFirestore.instance.collection("users").doc(documentList.first.id).update({"isCompanyCreated":true,"companyId":companyId});

    addCompaniesServicesIntoFirestore(companyId,context);

    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  }
  
  Future<void> getServicesFromFirestore(context) async {

    var documentList = await FirebaseCrudMethods(context: context).query(collection: "products_services", field: "addedBy", isEqualTo: "0");
    ProductsServicesModel.mapToModel(documentList);
    Get.toNamed("/serviceSelectionScreen");
  }

  void saveCompanyIdInUserModel(companyId){
    UserModel.myInstance.companyId=companyId;
  }

  void addCompaniesServicesIntoFirestore(companyId,context){
    ProductsServicesModel.list.forEach((model) {
      if(!model.isChecked.value){
        return;
      }
      //company services
      var companyServicesMap = {"companyId":companyId,"serviceId":model.id};
      FirebaseCrudMethods(context: context).insert(collection: "company_services", map: companyServicesMap);
    });
  }
}