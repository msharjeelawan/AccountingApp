import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Helper/Constant.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';
import 'package:travel_accounting/widgets/my_alert_dialog.dart';

import '../Controller/company_register_controller.dart';
import '../widgets/default_button.dart';

class CompanyRegisterScreen extends GetView{
  @override
  final CompanyRegisterController controller = Get.put(CompanyRegisterController());
  CompanyRegisterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
          child: SafeArea(
              child: SizedBox(
                height: getHeight(context)-56,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Company Basic Info",style: TextStyle(fontFamily: "OpenSans",fontWeight: FontWeight.bold,fontSize: 4.h),),
                    const Expanded(child: SizedBox()),
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
                    SizedBox(height: 8.h,),
                    Form(
                      key: controller.formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Business Name",
                          prefixIcon: Icon(Icons.business)
                        ),
                        validator: (name){
                          if(name!.isEmpty){
                            return "Please enter business name";
                          }
                        },
                        onSaved: (name){
                          controller.businessNameFormField=name!;
                        },
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    Obx(() {
                      return DropdownButton(
                        value: controller.selectedFiscalMonth.value,
                        isExpanded: true,
                        items: controller.getFiscalMonths().map((fiscalMonth) {
                          return DropdownMenuItem(
                              value:fiscalMonth,
                              child: Text(fiscalMonth)
                          );
                        }).toList(),
                        onChanged: (value){
                          controller.selectedFiscalMonth.value = value as String;
                        },
                        //borderRadius: BorderRadius.circular(20),
                        underline: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white)),),
                      );
                    }),
                    // TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //       hintText: "Fiscal Year",
                    //       prefixIcon: const Icon(Icons.business),
                    //       suffixIcon: IconButton(
                    //           onPressed: (){
                    //             showDatePicker(
                    //                 context: context,
                    //                 initialDate: DateTime.now(),
                    //                 firstDate: DateTime.now().subtract(Duration(days:DateTime.now().day)),
                    //                 lastDate: DateTime.now().add(Duration(days: 200))
                    //             );
                    //           }, 
                    //           icon: const Icon(Icons.date_range)
                    //       )
                    //   ),
                    //   validator: (name){
                    //
                    //   },
                    //   onSaved: (name){
                    //
                    //   },
                    // ),
                    SizedBox(height: 4.h,),
                    DefaultButton(text: "Next",press:(){
                      controller.next(context);
                    }),
                    const Expanded(child: SizedBox())
                  ],
                ),
              )
          ),
        ),
      ),
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

      // var imageCropper = ImageCropper();
      // File? croppedFile = await imageCropper.cropImage(
      //     sourcePath: xfile.path,
      //     aspectRatioPresets: [
      //       CropAspectRatioPreset.square,
      //       CropAspectRatioPreset.ratio3x2,
      //       CropAspectRatioPreset.original,
      //       CropAspectRatioPreset.ratio4x3,
      //       CropAspectRatioPreset.ratio16x9
      //     ],
      //     androidUiSettings: const AndroidUiSettings(
      //         toolbarTitle: 'Cropper',
      //         toolbarColor: Colors.deepOrange,
      //         toolbarWidgetColor: Colors.white,
      //         initAspectRatio: CropAspectRatioPreset.original,
      //         lockAspectRatio: false),
      //     iosUiSettings: const IOSUiSettings(
      //       minimumAspectRatio: 1.0,
      //     )
      // );

     // image = croppedFile;

      //show dialog during image upload
      MyAlertDialog.show(context);
      //upload image
      await controller.uploadImage().then((value) {
        MyAlertDialog.hide(context);
        MyScaffold.show(context, "Image Uploaded Successfully");
      }).catchError((e){
        MyAlertDialog.hide(context);
        MyScaffold.show(context, e.toString());
      });
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