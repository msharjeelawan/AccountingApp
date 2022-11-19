
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/product_service_controller.dart';
import 'package:travel_accounting/Model/products_services_model.dart';

class ProductServiceScreen extends GetView{
  @override
  final ProductServiceController controller = Get.put(ProductServiceController());
  ProductServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product or Services"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body:  SafeArea(
          child: FutureBuilder(
            future: controller.getProducts(context),
            builder: (context, snapshot) {

              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(!snapshot.hasData){
                return const Center(child: Text("No data found"),);
              }

              var productList = snapshot.data as List<ProductsServicesModel>;
              if(productList.isEmpty){
                //when response return null
                return const Center(child: Text("No data found"),);
              }
              //this will help listview for rebuilding when data change
              controller.lengthOfMyProductsInFirestore.value = productList.length;

              return Obx((){
                return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.lengthOfMyProductsInFirestore.value,
                    itemExtent: 75,
                    itemBuilder: (context,index){
                      return Card(
                        shape: RoundedRectangleBorder(
                          //side: const BorderSide(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          title: Text(productList[index].name!),
                          subtitle: Text(productList[index].id!),
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
            Navigator.pushNamed(context, '/addProductService');
          }
      ),
    );
  }
}