
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/expense_controller.dart';
import 'package:travel_accounting/Helper/Constant.dart';

import '../widgets/default_button.dart';

class AddExpenseScreen extends GetView{
  @override
  final ExpenseController controller = Get.put(ExpenseController());
  var dropDownValue="Select Expense Type";
  AddExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Add Expense"),
       elevation: 0,
       centerTitle: true,
     ),
     body: SingleChildScrollView(
       child: Column(
         children: [
           Container(
             padding: const EdgeInsets.all(10),
             margin: const EdgeInsets.all(10),
             height: getHeight(context)*0.3,
             width: getWidth(context),
             decoration:  BoxDecoration(
                 border: Border.all(color: Colors.black38)
             ),
             child: Row(
               children: [
                 Flexible(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       TextFormField(
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
                             // controller.dateController.value.text = formatedDate;
                             // controller.timeStamp = Timestamp.fromDate(date);
                           }
                         },
                         decoration: const InputDecoration(
                             hintText: "Date",
                             suffixIcon: Icon(Icons.date_range)
                         ),
                         validator: (name){

                         },
                         onSaved: (name){

                         },
                       ),
                       TextFormField(
                         keyboardType: TextInputType.text,
                         decoration: const InputDecoration(
                           hintText: "Amount",
                         ),
                         validator: (name){

                         },
                         onSaved: (name){

                         },
                       ),
                     ],
                   ),
                 ),
                 Container(
                   margin: const EdgeInsets.all(10),
                   width: getWidth(context)*0.4,
                   decoration: BoxDecoration(
                     border: const Border(),
                     borderRadius: BorderRadius.circular(20),
                     color: primaryColor1.withAlpha(100)
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: const [
                       Icon(Icons.attach_file,size: 30,color: Colors.black,),
                       Text("Attach Bill")
                     ],
                   ),
                 )
               ],
             ),
           ),
           Container(
             padding: const EdgeInsets.all(10),
             margin: const EdgeInsets.all(10),
             height: getHeight(context)*0.6,
             width: getWidth(context),
             decoration:  BoxDecoration(
                 border: Border.all(color: Colors.black38)
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Obx(() {
                   return Row(
                     children: [
                       SizedBox(
                         width: getWidth(context)*0.4,
                         child: ListTile(
                           contentPadding: EdgeInsets.zero,
                           title: const Text("Cash"),
                           leading:  Radio(
                               value: "Cash",
                               groupValue: controller.paymentMethod.value,
                               onChanged: (value){
                                 controller.paymentMethod.value = value as String;
                               }
                           ),
                         ),
                       ),
                       SizedBox(
                         width: getWidth(context)*0.4,
                         child: ListTile(
                           contentPadding: EdgeInsets.zero,
                           title: const Text("Loan"),
                           leading:  Radio(
                               value: "Loan",
                               groupValue: controller.paymentMethod.value,
                               onChanged: (value){
                                 controller.paymentMethod.value = value as String;
                               }
                           ),
                         ),
                       ),
                     ],
                   );
                 }),
                 TextFormField(
                   keyboardType: TextInputType.text,
                   decoration: const InputDecoration(
                     hintText: "Bill No (optional)",
                   ),
                   validator: (name){

                   },
                   onSaved: (name){

                   },
                 ),
                 TextFormField(
                   keyboardType: TextInputType.text,
                   decoration: const InputDecoration(
                     hintText: "Description (optional)",
                   ),
                   validator: (name){

                   },
                   onSaved: (name){

                   },
                 ),
                 DropdownButton(
                   value: dropDownValue,
                   isExpanded: true,
                   items: ["Select Expense Type","rent","bill","monthly pay",].map((item) {
                     return DropdownMenuItem(
                         value: item,
                         child: Text(item)
                     );
                   }).toList(),
                   onChanged: (value){
                     dropDownValue=(value as String);
                   },
                 ),
                 DefaultButton(text: "Save",press:(){
                 }),
               ],
             ),
           )
         ],
       ),
     ),
   );
  }


}