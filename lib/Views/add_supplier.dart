import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Helper/Constant.dart';

import '../Controller/supplier_controller.dart';
import '../widgets/default_button.dart';

class AddSupplier extends GetView {
  @override
  final SupplierController controller = Get.put(SupplierController());
  AddSupplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Supplier"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(height: 2.h,),
                getNameTextFormField(),
                SizedBox(height: 2.h,),
                getEmailTextFormField(),
                SizedBox(height: 2.h,),
                getPhoneNoTextFormField(),
                SizedBox(height: 2.h,),
                getLocationTextFormField(),
                SizedBox(height: 2.h,),
                getBankAccountTitleTextFormField(),
                SizedBox(height: 2.h,),
                getBankAccountNoTextFormField(),
                SizedBox(height: 2.h,),
                DefaultButton(text: "Add",press:(){
                  controller.addSupplier(context);
                  //Navigator.pushNamedAndRemoveUntil(context, "/dashboard",(route)=> false);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField getNameTextFormField(){
    return  TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Supplier Name",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (name){
        if(name!.length<3){
          return "Please enter a valid supplier Name";
        }
      },
      onSaved: (name){
        controller.supplierName = name?.trim();
      },
    );
  }

  TextFormField getEmailTextFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Email",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (email){
        if(email!.isEmpty){
          return "Please enter email address";
        }else if(!emailValidatorRegExp.hasMatch(email)){
          return "Please enter a valid email address";
        }
      },
      onSaved: (email){
        controller.email = email?.trim();
      },
    );
  }

  TextFormField getPhoneNoTextFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Phone No",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (phone){
        if(phone!.length<4){
          return "Please enter a valid phone number";
        }
      },
      onSaved: (phone){
        controller.phoneNo = phone?.trim();
      },
    );
  }

  TextFormField getLocationTextFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Address",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (location){
        if(location!.isEmpty){
          return "Please enter a address";
        }
      },
      onSaved: (location){
        controller.location = location?.trim();
      },
    );
  }

  TextFormField getBankAccountTitleTextFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Bank Account Title",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (title){
        if(title!.isEmpty){
          return "Please enter a title";
        }
      },
      onSaved: (title){
        controller.bankTitle = title?.trim();
      },
    );
  }

  TextFormField getBankAccountNoTextFormField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Bank Account No",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (name){
        if(name!.isEmpty){
          return "Please enter a bank account number";
        }else if(name.length<5){
          return "Please enter a valid bank account number";
        }
      },
      onSaved: (no){
        controller.bankNo = no?.trim();
      },
    );
  }
}