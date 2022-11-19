import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Model/products_services_model.dart';

import '../Controller/company_register_controller.dart';
import '../widgets/default_button.dart';

class ServiceSelectionScreen extends GetView{
  @override
  final CompanyRegisterController controller = Get.put(CompanyRegisterController());
  ServiceSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Services"),
       centerTitle: true,
       elevation: 0.0,
     ),
     body: Column(
       children: [
         ListView.builder(
           padding: const EdgeInsets.symmetric(horizontal: 10),
             itemCount: 5,
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             itemBuilder: (context,index){
               var services = controller.productServices.keys.toList();
               var service = services[index];
               return  Obx((){
                 print(index);
                 return CheckboxListTile(
                     title: Text(service),
                     value: ProductsServicesModel.list[index].isChecked.value,
                     onChanged: (isCheck){
                       ProductsServicesModel.list[index].isChecked.value=isCheck!;
                     }
                 );
               }
               );
             }
         ),
         SizedBox(height: 1.h,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: DefaultButton(text: "Complete Profile",press:(){
             controller.createCompanyProfile(context);
           }),
         ),
       ],
     ),
   );
  }

}