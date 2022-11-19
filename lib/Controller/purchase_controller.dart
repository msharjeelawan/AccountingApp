import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/product_service_controller.dart';
import 'package:travel_accounting/Controller/supplier_controller.dart';
import 'package:travel_accounting/Model/products_services_model.dart';
import 'package:travel_accounting/Model/supplier_model.dart';
import 'package:travel_accounting/Model/transaction_model.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';

import '../Model/User.dart';
import '../service/firebase_crud_methods.dart';

class PurchasesController extends GetxController{

  @override
  void onInit() {
    ever(selectedSupplier, (callback) {
      selectedSupplier.addListener(GetStream(onListen: (){
        if(selectedSupplier.value != "Select Supplier"){
          SupplierModel.list.forEach((supplier) {
            if(supplier.name==selectedSupplier.value){
              supplierId = supplier.id;
            }
          });
        }
      }));

      ever(selectedProduct, (callback) {
        selectedProduct.addListener(GetStream(onListen: (){
          if(selectedProduct.value != "Select Product"){
            ProductsServicesModel.list.forEach((service) {
              if(service.name==selectedProduct.value){
                serviceId = service.id;
              }
            });
          }
        }));
      });
    });
    super.onInit();
  }
  //add purchase data members
  final formKey = GlobalKey<FormState>();
  String? account, amount, description, serviceId, supplierId;
  final selectedProduct="Select Product".obs;
  final selectedSupplier="Select Supplier".obs;
  final radioBtn="".obs;
  final date = TextEditingController().obs;
  List<String> productList = [];
  List<String> supplierList = [];

  //all purchase data members
  final lengthOfPurchasesInFirestore = 0.obs;

  //add purchase methods
  Future<void> loadSupplierAndServiceList(context) async {
    supplierList.clear();
    productList.clear();
    await Get.put(SupplierController()).getSuppliers(context);
    await Get.put(ProductServiceController()).getProducts(context);
    //loading supplier
    if(SupplierModel.list.isNotEmpty){
      SupplierModel.list.forEach((supplier) {
        if(supplierList.isEmpty){
          supplierList.add("Select Supplier");
        }
          supplierList.add(supplier.name);
      });
    }
    //loading product service
    if(ProductsServicesModel.list.isNotEmpty){
      ProductsServicesModel.list.forEach((service) {
        if(productList.isEmpty){
          productList.add("Select Product");
        }
          productList.add(service.name!);
      });
    }
    //update dropdown list of supplier and products
    selectedProduct.update((val) { });
    selectedSupplier.update((val) { });
  }

  void validationOfForm(context){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      if(selectedSupplier.value=="Select Supplier"){
        MyScaffold.show(context, "Please select supplier");
      }else if(selectedProduct.value=="Select Product"){
        MyScaffold.show(context, "Please select product");
      }else if(radioBtn.value==""){
        MyScaffold.show(context, "Please select account");
      }else{
        addPurchase(context);
      }
    }
  }

  Future<void> addPurchase(context) async {
    var transactionMap = {
      "companyId":UserModel.myInstance.companyId,
      "userId": UserModel.myInstance.id,
      "serviceId": serviceId,
      "serviceName": selectedProduct.value,
      "supplierId":supplierId,
      "supplierName": selectedSupplier.value,
      "type":"Purchase",
      "date":date.value.text,
      "description":description,
    };
   var documentReference = await FirebaseCrudMethods(context: context).insert(collection: "transactions", map: transactionMap);
   //transaction detail inserting
    for(var a=1; a<=2; a++){
      var entryType = a==1? "Dr": "Cr";
      var transactionDetailMap = {
        "transaction_id":documentReference.id,
        "accountId":"",
        "entryType":entryType,
        "amount":amount
      };
      FirebaseCrudMethods(context: context).insert(collection: "transactions_detail", map: transactionDetailMap);
    }
    //clear form state
    resetForm();
  }

  void resetForm(){
    formKey.currentState!.reset();
    radioBtn.value="";
    selectedProduct.value="Select Product";
    selectedSupplier.value="Select Supplier";
    date.value.text="";
  }

  //all purchase screen methods
  Future<List<TransactionModel>> getPurchases(context) async {
    var purchasesTransactionDocumentList = await FirebaseCrudMethods(context: context).doubleQuery(collection: "transactions", fields: ["companyId","type"], isEqualTo: [UserModel.myInstance.companyId,"Purchase"],showDialog: false);
    var transactionList = TransactionModel.fromDocumentListToModel(purchasesTransactionDocumentList,);
    for (var transaction in transactionList){
      await getPurchasesDetail(context,transaction);
    }
    return transactionList;
  }

  Future<void> getPurchasesDetail(context,TransactionModel transaction) async {
    var purchasesTransactionDetailDocumentList = await FirebaseCrudMethods(context: context).query(collection: "transactions_detail", field: "transaction_id", isEqualTo: transaction.id,showDialog: false);
    var list = TransactionModel.fromDetailDocumentListToModel(purchasesTransactionDetailDocumentList);
    transaction.detailList = list;
  }

  //purchase detail screen methods


}