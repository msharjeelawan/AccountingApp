import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Controller/clients_controller.dart';

import '../Helper/Constant.dart';
import '../widgets/default_button.dart';

class AddClient extends GetView{
  @override
  final ClientsController controller = Get.put(ClientsController());
  AddClient({Key? key}) : super(key: key){
    controller.imageFile.value=File("");
    controller.passportExpiry.value.text="";
    controller.dob.value.text="";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Client"),
        elevation: 0.0,
        centerTitle: true,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 15),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Form(
                key: controller.formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx((){
                      return GestureDetector(
                        onTap: (){
                          showPicker(context);
                        },
                        child: CircleAvatar(
                          radius: 60,
                          foregroundImage: getProfileImage(),
                        ),
                      );
                    }),
                    SizedBox(height: 2.h,),
                    getNameTextField(),
                    SizedBox(height: 2.h,),
                    getEmailTextField(),
                    SizedBox(height: 2.h,),
                    getContactTextField(),
                    SizedBox(height: 2.h,),
                    getAddressTextField(),
                    SizedBox(height: 2.h,),
                    getPassportTextField(),
                    SizedBox(height: 2.h,),
                    getPassportExpiryTextField(context),
                    SizedBox(height: 2.h,),
                    getDOBTextField(context),
                    SizedBox(height: 2.h,),
                    getIdCardTextField(),
                    SizedBox(height: 2.h,),
                    getNationalityTextField(),
                    SizedBox(height: 2.h,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          Text("Attachments")
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    DefaultButton(text: "Add Customer",press:(){
                      controller.addClient(context);
                    }),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  TextFormField getNameTextField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          hintText: "Name",
          labelText: "Name",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (name){
        if(name!.isEmpty){
          return "Please enter name";
        }
      },
      onSaved: (name){
        controller.name=name!.trim();
      },
    );
  }

  TextFormField getEmailTextField(){
    return  TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          hintText: "Email",
          labelText: "Email",
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
        controller.email = email?.trim().toLowerCase();
      },
    );
  }

  TextFormField getContactTextField(){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          hintText: "Phone No",
          labelText: "Phone No",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (phone){
        if(phone!.length<4){
          return "Please enter a valid phone number";
        }
      },
      onSaved: (phone){
        controller.contactNo = phone?.trim();
      },
    );
  }

  TextFormField getAddressTextField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          hintText: "Address",
          labelText: "Address",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (address){
        if(address!.isEmpty){
          return "Please enter a address";
        }
      },
      onSaved: (address){
        controller.address = address!.trim();
      },
    );
  }

  TextFormField getPassportTextField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          hintText: "Passport No",
          labelText: "Passport No",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (passportNo){
        if(passportNo!.length<5){
          return "Please enter a valid Passport No";
        }
      },
      onSaved: (passportNo){
        controller.passportNo = passportNo!.trim().toUpperCase();
      },
    );
  }

  Obx getPassportExpiryTextField(context){
    return Obx(() {
      return TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        controller: controller.passportExpiry.value,
        readOnly: true,
        onTap: () async {
          var expiry = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 4000))
          );
          controller.passportExpiry.value.text = expiry.toString().split(" ")[0];
        },
        decoration: const InputDecoration(
            hintText: "Passport Expiry",
            labelText: "Passport Expiry",
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
        ),
        validator: (expiry){
          if(expiry!.isEmpty){
            return "Please enter a valid Passport Expiry";
          }
        },
        onSaved: (expiry){
          controller.passportExpiry.value.text = expiry!;
        },
      );
    });
  }

  Obx getDOBTextField(context){
    return Obx(() {
      return TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        controller: controller.dob.value,
        readOnly: true,
        onTap: () async {
          var dob = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(const Duration(days: 10000)),
              firstDate: DateTime.parse("1950-01-01 00:00:00.000"),
              lastDate: DateTime.now().subtract(const Duration(days: 6200))
          );
          controller.dob.value.text = dob.toString().split(" ")[0];
        },
        decoration: const InputDecoration(
            hintText: "DOB",
            labelText: "DOB",
            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
        ),
        validator: (dob){
          if(dob!.isEmpty){
            return "Please enter a valid Date of Birth";
          }
        },
        onSaved: (dob){
          controller.dob.value.text = dob!;
        },
      );
    });
  }

  TextFormField getIdCardTextField(){
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          hintText: "Id Card No",
          labelText: "Id Card No",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (cardNo){
        if(cardNo!.length<5){
          return "Please enter a valid id card number";
        }
      },
      onSaved: (cardNo){
        controller.idCardNo = cardNo!.trim();
      },
    );
  }

  TextFormField getNationalityTextField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
          hintText: "Nationality",
          labelText: "Nationality",
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10)
      ),
      validator: (nationality){
        if(nationality!.isEmpty){
          return "Please enter nationality";
        }
      },
      onSaved: (nationality){
        controller.nationality = nationality!.trim();
      },
    );
  }

  //show bottom sheet for selection of image source either from camera or gallery
  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      pickImage(ImageSource.gallery,context);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    pickImage(ImageSource.camera,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  //image selection
  Future<void> pickImage(source,context) async {
    // print("pick file");
    final picker=ImagePicker();
    XFile? xfile = await  picker.pickImage(source: source);
    if(xfile!=null){
      controller.imageFile.value = File(xfile.path);
    }
  }

  //profile image
  ImageProvider getProfileImage(){
    //if profile image is not available default image will show using image asset
    if(controller.imageFile.value.path.isEmpty){
      //show default image
      return Image.asset("assets/icons/profile.png").image;
    }else{
      //if user select image using picker then it will show using image file
      return Image.file(controller.imageFile.value).image;
    }
    //if profile image is available then it will show using image network
  }

}