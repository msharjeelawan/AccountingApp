
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_accounting/Model/products_services_model.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';

import '../Model/User.dart';
import '../service/firebase_crud_methods.dart';

class ProductServiceController extends GetxController{

  //for product add or update these properties will use
  final formKey = GlobalKey<FormState>();
  String? productName;
  final lengthOfMyProductsInFirestore=0.obs;//will use for rebuild listview

  Future<List<ProductsServicesModel>> getProducts(context) async {
    List<QueryDocumentSnapshot> list = [];
    var myProductIdsList = await FirebaseCrudMethods(context: context).query(collection: "company_services", field: "companyId", isEqualTo: UserModel.myInstance.companyId,showDialog: false);
    var productList = await loadAllProducts(context);
    productList.forEach((productDocument) {
     var id = productDocument.id;
     myProductIdsList.forEach((idDocument) {
       if(id==idDocument.get("serviceId")){
         list.add(productDocument);
       }
     });
    });

    return ProductsServicesModel.mapToModel(list);
  }
  
  Future<List<QueryDocumentSnapshot>> loadAllProducts(context) async {
    return await FirebaseCrudMethods(context: context).readAll(collection: "products_services",showDialog: false);
  }
  
  
  Future<void> addProduct(context) async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      //convert input to pascal case
      productName = convertToPascalCase(productName!);
      //check if product is available in firestore or not
      //if not then add
      var documentList = await FirebaseCrudMethods(context: context).query(collection: "products_services", field: "name", isEqualTo: productName);
      var serviceId = "";
      if(documentList.isEmpty){
        var productMap={"addedBy":FirebaseAuth.instance.currentUser!.uid,"name":productName};
        var documentRef = await FirebaseCrudMethods(context: context).insert(collection: "products_services", map: productMap);
        serviceId = documentRef.id;
      }else{
        serviceId = documentList.first.id;
        //check if user is already have this product or service
        var alreadyAddedDocumentList = await FirebaseCrudMethods(context: context).query(collection: "company_services", field: "serviceId", isEqualTo: serviceId);
        if(alreadyAddedDocumentList.isNotEmpty){
          MyScaffold.show(context, "Product already available in your Product & service list");
          return;
        }
      }

      var productIdWithCompanyIdMap = {"companyId":UserModel.myInstance.companyId,"serviceId":serviceId};
      await FirebaseCrudMethods(context: context).insert(collection: "company_services", map: productIdWithCompanyIdMap);
      //add product in model class
      var list = ProductsServicesModel.addSingleProductInModelList(serviceId, productName!);
      updateProductListLength(list);
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
    return newWord;
  }


  void updateProductListLength(List list){
    lengthOfMyProductsInFirestore.value = list.length;
  }

}