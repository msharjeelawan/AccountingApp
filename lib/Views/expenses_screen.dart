
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Controller/expense_controller.dart';

import '../Helper/Constant.dart';
import '../Model/expense_model.dart';
import '../Model/transaction_model.dart';

class ExpensesScreen extends GetView{
  @override
  ExpenseController controller = Get.put(ExpenseController());
  ExpensesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("Clients"),
        elevation: 0.0,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: controller.getExpense(context),
              builder: (context, snapshot) {

                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }

                if(!snapshot.hasData){
                  return const Center(child: Text("No data found"),);
                }

                var expenseList = snapshot.data as List<TransactionModel>;
                controller.lengthOfMyExpensesInFirestore.value = expenseList.length;

                if(expenseList.isEmpty){
                  //when response return null
                  return const Center(child: Text("No data found"),);
                }

                return Obx(() {
                  return ListView.builder(
                      itemCount: controller.lengthOfMyExpensesInFirestore.value,
                      itemExtent: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      itemBuilder: (context,index){
                        return GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black38),borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.person_pin,size: 50,color: Colors.black54,),
                                Container(
                                  // color: Colors.black38,
                                  width: getWidth(context)*0.45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text(expenseList[index].name,style: TextStyle(fontSize: 3.h,color: Colors.black54,overflow: TextOverflow.ellipsis),),
                                      Text(expenseList[index].date,style: TextStyle(fontSize: 2.h,color: Colors.black54,overflow: TextOverflow.ellipsis),),
                                      Text(expenseList[index].description,style: TextStyle(fontSize: 2.h,color: Colors.black54,overflow: TextOverflow.ellipsis),)
                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.black12,
                                  width: getWidth(context)*0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(child: Text(expenseList[index].paymentMethod,style: TextStyle(fontSize: 2.h,color: Colors.black54),)),
                                      Flexible(child: Text(expenseList[index].billNo,style: TextStyle(fontSize: 2.h,color: Colors.black54),))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                });
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, '/addExpense');
          }
      ),
    );
  }

}