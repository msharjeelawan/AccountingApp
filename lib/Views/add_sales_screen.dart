
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_accounting/Helper/Constant.dart';

import '../Controller/sales_controller.dart';
import '../widgets/default_button.dart';

class AddSalesScreen extends GetView{
  @override
  final SalesController controller = Get.put(SalesController());
  AddSalesScreen({Key? key}) : super(key: key){
    controller.resetForm();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Add Sales"),
       centerTitle: true,
       elevation: 0.0,
     ),
     body: SingleChildScrollView(
       child: Container(
         padding: const EdgeInsets.all(20),
        // height: getHeight(context)-80,
         child: Form(
           key: controller.formKey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Obx(() {
                return TextFormField(
                  controller: controller.addCustomerFieldController.value,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onTap: () async {
                    var customer = await Get.toNamed('/search',);
                    controller.addCustomerFieldController.value.text = customer;
                  },
                  decoration: InputDecoration(
                      hintText: "Search or add Customer",
                      contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                      suffixIcon: IconButton(
                          onPressed: (){
                            Get.toNamed("/addClient");
                            },
                          icon: const Icon(Icons.add)
                      )
                  ),
                  validator: (name){
                    if(name!.isEmpty){
                      return "Please select customer";
                    }
                  },
                  onSaved: (name){

                  },
                );
              }),
               const SizedBox(height: 10,),
               Obx(() {
                 return TextFormField(
                   keyboardType: TextInputType.text,
                   controller: controller.addProductFieldController.value,
                   decoration: InputDecoration(
                       hintText: "Add Product or Service",
                       contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                       suffixIcon: IconButton(
                           onPressed: (){
                             Get.toNamed("/addProductService");
                         },
                           icon: const Icon(Icons.add)
                       )
                   ),
                   validator: (product){
                     if(product!.isEmpty){
                       return "Please select product or service";
                     }
                   },
                   onSaved: (name){

                   },
                 );
               }),
               const SizedBox(height: 10,),
               TextFormField(
                 keyboardType: TextInputType.number,
                 decoration: const InputDecoration(
                     hintText: "Amount",
                     labelText: "Amount",
                     contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                 ),
                 validator: (amount){
                   if(amount!.isEmpty){
                     return "Please enter amount";
                   }
                 },
                 onSaved: (name){

                 },
                 onChanged: (amount){
                   //save value in subtotal
                   controller.validateSubtotal(amount);
                 },
               ),
               const SizedBox(height: 10,),
               Obx(() {
                 return  TextFormField(
                   controller: controller.dateController.value,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  onTap: () async {
                   var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days:DateTime.now().day)),
                        lastDate: DateTime.now().add(const Duration(days: 200))
                    );
                   if(date!=null){
                     var formatedDate = "${date.day}-${date.month}-${date.year}";
                     controller.dateController.value.text = formatedDate;
                     controller.timeStamp = Timestamp.fromDate(date);
                   }
                  },
                  decoration: const InputDecoration(
                      hintText: "Date",
                      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                      suffixIcon: Icon(Icons.date_range)
                  ),
                  validator: (date){
                    if(date!.isEmpty){
                      return "Please enter date";
                    }
                  },
                  onSaved: (name){

                  },
                );
               }),
               const SizedBox(height: 10,),
               Obx(() {
                 return Column(
                   children: [
                     DropdownButton(
                       value: controller.paymentMethod.value,
                       isExpanded: true,
                       items: ["Select Payment Method","Cash","Loan",].map((item) {
                         return DropdownMenuItem(
                             value: item,
                             child: Text(item)
                         );
                       }).toList(),
                       onChanged: (value){
                         controller.paymentMethod.value=(value as String);
                       },
                     ),
                     controller.paymentMethod.value == "Loan"?
                     DropdownButton(
                       value: controller.paymentTerms.value,
                       isExpanded: true,
                       items: ["Select Terms","15 Days Net","30 Days Net",].map((item) {
                         return DropdownMenuItem(
                             value: item,
                             child: Text(item)
                         );
                       }).toList(),
                       onChanged: (value){
                         controller.paymentTerms.value=(value as String);
                       },
                     )
                         :
                     const SizedBox()
                   ],
                 );
               }),
               const SizedBox(height: 10,),
               Obx(() {
                 return Column(
                   children: [
                     ListTile(
                       leading: const Text("Subtotal"),
                       trailing: Text("OMR ${controller.subTotal.value}"),
                     ),
                     ListTile(
                       leading: const Text("Discount"),
                       trailing: getDiscountTextField(context),
                     ),
                     ListTile(
                       leading: const Text("Total"),
                       trailing: Text("OMR ${controller.total.value}"),
                     ),
                   ],
                 );
               }),

               // Container(
               //   margin: const EdgeInsets.symmetric(horizontal: 5),
               //   decoration: BoxDecoration(
               //       border: Border.all()
               //   ),
               //   child: Row(
               //     children: const [
               //       Icon(Icons.add),
               //       Text("Attachments")
               //     ],
               //   ),
               // ),
               DefaultButton(
                   text: "Save",
                   press:(){
                     controller.validateAllFieldsAndSubmitToFirestore(context);
                   }
               ),
             ],
           ),
         ),
       ),
     ),
   );
  }


  SizedBox getDiscountTextField(context){
    return SizedBox(
      width: getWidth(context)*0.2,
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 2,
        textInputAction: TextInputAction.done,
        controller: controller.discountController.value,
        decoration: const InputDecoration(
          //contentPadding: EdgeInsets.zero,
          suffix: Text("%"),
          counterText: "",
       //   hintStyle: TextStyle(color: Colors.white),
          border: UnderlineInputBorder(
        //      borderSide: BorderSide.none
          ),
          focusedBorder: UnderlineInputBorder(
             borderSide: BorderSide.none
          )
        ),
        onSaved: (name){

        },
        onEditingComplete: (){
          controller.calculateDiscount();
        },
      ),
    );
  }

}