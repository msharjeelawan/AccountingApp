

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/User.dart';
import '../Model/transaction_model.dart';
import '../service/firebase_crud_methods.dart';

class ExpenseController extends GetxController{

  //add expense data member
  final lengthOfMyExpensesInFirestore = 0.obs;
  final paymentMethod = "".obs;
  final dateController = TextEditingController().obs;

  //all expense screen methods
  Future<List<TransactionModel>> getExpense(context) async {
    var expenseTransactionDocumentList = await FirebaseCrudMethods(context: context).doubleQuery(collection: "transactions", fields: ["companyId","type"], isEqualTo: [UserModel.myInstance.companyId,"Expense"],showDialog: false);
    var transactionList = TransactionModel.fromDocumentListToModel(expenseTransactionDocumentList);
    for (var transaction in transactionList){
      await _getExpenseDetail(context,transaction);
    }
    return transactionList;
  }

  Future<void> _getExpenseDetail(context,TransactionModel transaction) async {
    var expenseTransactionDetailDocumentList = await FirebaseCrudMethods(context: context).query(collection: "transactions_detail", field: "transaction_id", isEqualTo: transaction.id,showDialog: false);
    var list = TransactionModel.fromDetailDocumentListToModel(expenseTransactionDetailDocumentList);
    transaction.detailList = list;
  }


}