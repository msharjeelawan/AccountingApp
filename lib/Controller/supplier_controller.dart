import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/User.dart';
import '../Model/supplier_model.dart';
import '../service/firebase_crud_methods.dart';
import '../widgets/MyScaffold.dart';

class SupplierController extends GetxController{

  final formKey = GlobalKey<FormState>();
  String? supplierName, email, phoneNo, location, bankTitle, bankNo;
  final lengthOfMySuppliersInFirestore = 0.obs;

  Future<List<SupplierModel>> getSuppliers(context) async {
    var supplierDocumentList = await FirebaseCrudMethods(context: context).query(collection: "suppliers", field: "companyId", isEqualTo: UserModel.myInstance.companyId,showDialog: false);
    return SupplierModel.mapToModel(supplierDocumentList);
  }

  Future<void> addSupplier(context) async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      //convert input to Pascal Case
      supplierName = convertToPascalCase(supplierName!);
      email = convertToPascalCase(email!);
      phoneNo = convertToPascalCase(phoneNo!);
      location = convertToPascalCase(location!);
      bankTitle = convertToPascalCase(bankTitle!);
      bankNo = convertToPascalCase(bankNo!);
      //check if supplier is available in firestore or not
      //if not then add
      var documentList = await FirebaseCrudMethods(context: context).doubleQuery(collection: "suppliers", fields: ["companyId","name"], isEqualTo: [UserModel.myInstance.companyId,supplierName]);

      if(documentList.isEmpty){
        var supplierMap={
          "name":supplierName,
          "email":email,
          "no":phoneNo,
          "location":location,
          "account_title":bankTitle,
          "account_no":bankNo,
          "companyId":UserModel.myInstance.companyId,
          "addedBy":UserModel.myInstance.id
        };
        var documentRef = await FirebaseCrudMethods(context: context).insert(collection: "suppliers", map: supplierMap);

        var list = SupplierModel.addSingleSupplierInModelList(documentRef.id, supplierName, email, phoneNo, location, bankTitle, bankNo);
        updateSuppliersListLength(list);
      }else{
        MyScaffold.show(context, "Supplier already available in your Supplier list");
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

  void updateSuppliersListLength(List list){
    lengthOfMySuppliersInFirestore.value = list.length;
  }
}