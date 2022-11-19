import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Model/transaction_model.dart';
import 'package:travel_accounting/Views/purchase_detail_screen.dart';

import '../Controller/sales_controller.dart';
import '../Helper/Constant.dart';

class SalesScreen extends GetView {
  @override
  final SalesController controller = Get.put(SalesController());
  SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //load products and suppliers
   // controller.loadSupplierAndServiceList(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("Sales"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: controller.getSales(context),
              builder: (context, snapshot) {

                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }

                if(!snapshot.hasData){
                  return const Center(child: Text("No data found"),);
                }

                var salesList = snapshot.data as List<TransactionModel>;
                controller.lengthOfSalesInFirestore.value = salesList.length;

                // print("length of pruchases ${purchasesList.length}");
                // print("length of pruchases detail ${purchasesList.first.detailList.length}");

                if(salesList.isEmpty){
                  //when response return null
                  return const Center(child: Text("No data found"),);
                }

                return Obx(() {
                  return ListView.builder(
                      itemCount: controller.lengthOfSalesInFirestore.value,
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
                                SizedBox(
                                  // color: Colors.black38,
                                  width: getWidth(context)*0.45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text(salesList[index].userId,style: TextStyle(fontSize: 3.h,color: Colors.black54,overflow: TextOverflow.ellipsis),),
                                      Text(salesList[index].companyId,style: TextStyle(fontSize: 2.h,color: Colors.black54,overflow: TextOverflow.ellipsis),),
                                      Text(salesList[index].date,style: TextStyle(fontSize: 2.h,color: Colors.black54,overflow: TextOverflow.ellipsis),)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // color: Colors.black12,
                                  width: getWidth(context)*0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(child: Text(salesList[index].detailList.first.amount,style: TextStyle(fontSize: 2.h,color: Colors.black54),)),
                                      Flexible(child: Text(salesList[index].detailList.first.entryType.toString(),style: TextStyle(fontSize: 2.h,color: Colors.black54),))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            Get.to(PurchaseDetailScreen(purchaseIndex: index));
                          },
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
            Navigator.pushNamed(context, '/addSale');
          }
      ),
    );
  }
}
