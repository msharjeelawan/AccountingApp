import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Controller/product_service_controller.dart';
import '../widgets/default_button.dart';

class AddProductService extends GetView{
  @override
  final ProductServiceController controller = Get.put(ProductServiceController());
  AddProductService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Add Product or Service"),
       elevation: 0,
       centerTitle: true,
     ),
     body: SingleChildScrollView(
       child: Card(
         elevation: 5,
         margin: const EdgeInsets.all(20),
         shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20)
         ),
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
           child: Form(
             key: controller.formKey,
             child: Column(
               children: [
                 SizedBox(height: 2.h,),
                 TextFormField(
                   keyboardType: TextInputType.text,
                   decoration: const InputDecoration(
                       hintText: "Service Name",
                       contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
                   ),
                   validator: (name){
                     if(name!.isEmpty){
                       return "Please enter product or service name";
                     }else if(name.length<3){
                       return "Please enter long product name";
                     }
                   },
                   onSaved: (name){
                     controller.productName=name?.trim();
                   },
                 ),
                 SizedBox(height: 2.h,),
                 // TextFormField(
                 //   keyboardType: TextInputType.text,
                 //   maxLines: 5,
                 //   decoration: const InputDecoration(
                 //       hintText: "Description",
                 //       contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                 //   ),
                 //   validator: (name){
                 //
                 //   },
                 //   onSaved: (name){
                 //
                 //   },
                 // ),
                 SizedBox(height: 2.h,),
                 DefaultButton(text: "Save",press:(){
                   controller.addProduct(context);
                 }),
               ],
             ),
           ),
         )
       ),
     ),
   );
  }

}