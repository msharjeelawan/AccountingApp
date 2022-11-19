import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';
import 'package:travel_accounting/widgets/my_toast.dart';

import '../Model/User.dart';
import '../Model/transaction_model.dart';
import '../service/firebase_crud_methods.dart';

class SalesController extends GetxController{

  //ADD SALE DATA MEMBERS
  final formKey= GlobalKey<FormState>();
  final addCustomerFieldController = TextEditingController().obs;
  final addProductFieldController = TextEditingController().obs;
  final dateController = TextEditingController().obs;
  Timestamp? timeStamp;
  final paymentMethod = "Select Payment Method".obs;
  final paymentTerms = "Select Terms".obs;
  final subTotal = "0.0".obs;
  final discountController = TextEditingController().obs;
  final total = "0.0".obs;
  final currencyFormat = NumberFormat.simpleCurrency();

  //ADD SALE screen methods
  void validateSubtotal(subtotal){
    if(subtotal.isEmpty){
      subTotal.value = "0.0";
    }else{
      subTotal.value = subtotal;
      total.value = subtotal;
      if(discountController.value.text.isNotEmpty){
        calculateDiscount();
      }
    }
  }

  void calculateDiscount(){
    var subtotal = double.tryParse(subTotal.value);
    var discount = double.tryParse(discountController.value.text);
    if(subtotal != null && discount != null){
      total.value = (subtotal - (subtotal*discount/100)).toString();
    }
  }

  void validateAllFieldsAndSubmitToFirestore(context){
    if(formKey.currentState!.validate()){
      if(paymentMethod.value=="Select Payment Method"){
        print("Select Payment Method");
        MyToast.show("Please select Payment Method");
      }else if(paymentMethod.value=="Loan"){
        if(paymentTerms.value=="Select Terms"){
          MyToast.show("Please select Terms");
        }else{
          //if all fileds are okay then add sale into firestore
          addSale(context);
        }
      }
    }
  }

  Future<void> addSale(context) async {
    // var transactionMap = {
    //   "companyId":UserModel.myInstance.companyId,
    //   "userId": UserModel.myInstance.id,
    //   "serviceId": "uuuu",
    //   "serviceName": "test",
    //   "customerId":"bwebewihb",
    //   "customerName": "kbwebwe",
    //   "type":"Sale",
    //   "date":timeStamp,
    //   "description":"",
    // };
    // var documentReference = await FirebaseCrudMethods(context: context).insert(collection: "transactions", map: transactionMap);
    // //transaction detail inserting
    // for(var a=1; a<=3; a++){
    //   var entryType = a==1? "Dr": "Cr";
    //   var transactionDetailMap = {
    //     "transaction_id":documentReference.id,
    //     "accountId":"cnjkc",
    //     "entryType":entryType,
    //     "amount":"30"
    //   };
    //   FirebaseCrudMethods(context: context).insert(collection: "transactions_detail", map: transactionDetailMap);
    // }
    //clear form state
    resetForm();
  }

  void resetForm(){
    formKey.currentState?.reset();
    addCustomerFieldController.value.text="";
    addProductFieldController.value.text="";
    dateController.value.text="";
    paymentMethod.value="Select Payment Method";
    paymentTerms.value="Select Terms";
    subTotal.value="0.0";
    discountController.value.text="";
    total.value="0.0";
  }



  //ALL SALES DATA MEMBERS
  final lengthOfSalesInFirestore = 0.obs;

  //all sales screen methods
  Future<List<TransactionModel>> getSales(context) async {
    var salesTransactionDocumentList = await FirebaseCrudMethods(context: context).doubleQuery(collection: "transactions", fields: ["companyId","type"], isEqualTo: [UserModel.myInstance.companyId,"Sale"],showDialog: false);
    var transactionList = TransactionModel.fromDocumentListToModel(salesTransactionDocumentList);
    for (var transaction in transactionList){
      await getSalesDetail(context,transaction);
    }
    return transactionList;
  }

  Future<void> getSalesDetail(context,TransactionModel transaction) async {
    var salesTransactionDetailDocumentList = await FirebaseCrudMethods(context: context).query(collection: "transactions_detail", field: "transaction_id", isEqualTo: transaction.id,showDialog: false);
    var list = TransactionModel.fromDetailDocumentListToModel(salesTransactionDetailDocumentList);
    transaction.detailList = list;
  }


}