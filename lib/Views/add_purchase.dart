
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Controller/purchase_controller.dart';
import '../Helper/Constant.dart';
import '../widgets/default_button.dart';

class AddPurchase extends GetView{
  @override
  final PurchasesController controller = Get.put(PurchasesController());

  AddPurchase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Add Purchase"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: getHeight(context)-80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  getSupplierDropDownButton(),
                  SizedBox(height: 3.h,),
                  getProductsDropDownButton(),
                  SizedBox(height: 3.h,),
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
                                groupValue: controller.radioBtn.value,
                                onChanged: (value){
                                  controller.radioBtn.value = value as String;
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
                                groupValue: controller.radioBtn.value,
                                onChanged: (value){
                                  controller.radioBtn.value = value as String;
                                }
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 3.h,),
                  getAmountTextField(),
                  SizedBox(height: 3.h,),
                  getDateTextField(context),
                  SizedBox(height: 3.h,),
                  getDescriptionTextField(),
                  SizedBox(height: 3.h,),
                  DefaultButton(
                    text: "Add",
                    press: () {
                      controller.validationOfForm(context);
                    },
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        )
    );
  }

  Obx getSupplierDropDownButton(){
    return Obx(() {
      return DropdownButton(
        value: controller.selectedSupplier.value,
        isExpanded: true,
        items: controller.supplierList.map((role) {
          return DropdownMenuItem(
            value: role,
            child: Text(role),
          );
        }).toList(),
        onChanged: (value){
          controller.selectedSupplier.value=value as String;
        },
      );
    });

  }

  Obx getProductsDropDownButton(){
    return Obx(() {
      return DropdownButton(
        value: controller.selectedProduct.value,
        isExpanded: true,
        items: controller.productList.map((role) {
          return DropdownMenuItem(
            value: role,
            child: Text(role),
          );
        }).toList(),
        onChanged: (value){
          controller.selectedProduct.value=value as String;
        },
      );
    });

  }

  TextFormField getAmountTextField(){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          hintText: "Amount",
          labelText: "Amount",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (amount){
        if(amount!.isEmpty){
          return "Please enter amount";
        }
      },
      onSaved: (amount){
        controller.amount = amount?.trim();
      },
    );
  }

  Obx getDateTextField(context){
    return Obx(() {
      return TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        controller: controller.date.value,
        readOnly: true,
        onTap: () async {
          var dob = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365))
          );
          if(dob!=null) {
            controller.date.value.text = dob.toString().split(" ")[0];
          }
        },
        decoration: const InputDecoration(
            hintText: "Date",
            labelText: "Date",
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
        ),
        validator: (dob){
          if(dob!.isEmpty){
            return "Please enter a valid date";
          }
        },
        onSaved: (dob){
          controller.date.value.text = dob!;
        },
      );
    });
  }

  TextFormField getDescriptionTextField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
          hintText: "Description",
          labelText: "Description",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (amount){

      },
      onSaved: (description){
        controller.description = description?.trim();
      },
    );
  }

}