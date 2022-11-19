import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_accounting/Model/transaction_model.dart';

class PurchaseDetailScreen extends GetView{
  int purchaseIndex;
  PurchaseDetailScreen({Key? key,required this.purchaseIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var purchase = TransactionModel.list[purchaseIndex];
   return Scaffold(
     appBar: AppBar(
       title: const Text("Purchase Detail"),
       centerTitle: true,
     ),
     body: Column(
       children: [
         ListTile(title: const Text("Supplier"),trailing: Text(purchase.supplierName),),
         ListTile(title: const Text("Service"),trailing: Text(purchase.serviceName)),
         ListTile(title: const Text("Amount"),trailing: Text(purchase.detailList.first.amount)),
         ListTile(title: const Text("Description"),trailing: Text(purchase.description)),
         ListTile(title: const Text("Date"),trailing: Text(purchase.date)),
         const Divider(),
         const ListTile(title: Text("Account 1"),trailing:  Text("Account 2")),
         ListTile(title:Text(purchase.detailList[0].accountId),trailing: Text(purchase.detailList[1].accountId)),
         ListTile(title:Text(purchase.detailList[0].entryType),trailing: Text(purchase.detailList[1].entryType)),
       ],
     ),
   );
  }



}