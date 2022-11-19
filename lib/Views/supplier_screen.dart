import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/supplier_controller.dart';
import '../Model/supplier_model.dart';

class SupplierScreen extends GetView{
  @override
  final SupplierController controller = Get.put(SupplierController());
  SupplierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suppliers"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body:  SafeArea(
          child: FutureBuilder(
            future: controller.getSuppliers(context),
            builder: (context, snapshot) {

              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(!snapshot.hasData){
                return const Center(child: Text("No data found"),);
              }

              var supplierList = snapshot.data as List<SupplierModel>;
              if(supplierList.isEmpty){
                //when response return null
                return const Center(child: Text("No data found"),);
              }
              //this will help listview for rebuilding when data change
              controller.lengthOfMySuppliersInFirestore.value = supplierList.length;

              return Obx((){
                return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.lengthOfMySuppliersInFirestore.value,
                    itemExtent: 75,
                    itemBuilder: (context,index){
                      return Card(
                        shape: RoundedRectangleBorder(
                          //side: const BorderSide(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          title: Text("Name: ${supplierList[index].name}"),
                          subtitle: Text("Email: ${supplierList[index].email}"),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Location: ${supplierList[index].location}"),
                              Text("No: ${supplierList[index].no}"),
                            ],
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
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
            Navigator.pushNamed(context, '/addSupplier');
          }
      ),
    );
  }
}