import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/otp_controller.dart';
import 'package:travel_accounting/Helper/Constant.dart';

class OTPScreen extends GetView{
  @override
  final OtpController controller = Get.put(OtpController());
  //otp will use on login as well as register screen so parameter isLogin will
  //check that user is trying to login or register
  OTPScreen({Key? key,required code, required token, required isLogin}) : super(key: key){
    controller.code=code;
    controller.token=token;
    controller.isLogin=isLogin;
  }

  @override
  Widget build(BuildContext context) {
    double width = getWidth(context);
    double height = getHeight(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: primaryColor1,
            statusBarIconBrightness: Brightness.light
        ),
      ),
      body: Stack(
        //fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,left: 0,
            child: Container(
              width: width,
              height: height*0.35,
              decoration: const BoxDecoration(
                  color: primaryColor1,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0),bottomRight: Radius.circular(40.0))
              ),
            ),
          ),
          const Positioned(top:20,right:0,left:0,child: Center(child: Text("Travel",style:TextStyle(fontSize: 25,color: white,fontWeight: FontWeight.bold)))),
          // Image.asset("assets/images/logo.png",width: width*0.4,height: height*0.25,),
          Positioned(
            // height: height*0.6,
            top: 30,
            right: 0,left: 0,
            child:  Form(
              key: controller.formKey,
              child: Container(
                // height: height*0.8,
                margin: const EdgeInsets.only(left: 20.0,right:20.0,top:30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(blurRadius: 5,offset: Offset(0,2),color: Colors.black54)
                    ]
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    const Text("Confirm OTP",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: primaryColor1),),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width*0.1,
                          child:  TextFormField(
                            maxLength: 1,
                            focusNode: controller.f1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) => controller.otp1 = newValue.toString().trim(),
                            onChanged: (value){
                              changeFocus("1",value);
                              //FocusScope.of(context).requestFocus(f2);
                            },
                            textAlign: TextAlign.center,
                            autofocus: true,
                            decoration: InputDecoration(
                                fillColor: white,
                                filled: true,
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width*0.1,
                          child: TextFormField(
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (newValue) => controller.otp2 = newValue.toString().trim(),
                            focusNode:controller.f2,
                            onTap: (){
                              // print("2nd tap");
                            },
                            onChanged: (value){
                              //  print("2nd changed");
                              changeFocus("2",value);
                              //FocusScope.of(context).requestFocus(f3);
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                fillColor: white,
                                filled: true,
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width*0.1,
                          child: TextFormField(
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (newValue) => controller.otp3 = newValue.toString().trim(),
                            focusNode: controller.f3,
                            onChanged: (value){
                              changeFocus("3",value);
                              //FocusScope.of(context).requestFocus(f4);
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                fillColor: white,
                                filled: true,
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: primaryColor1)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: primaryColor1)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width*0.1,
                          child: TextFormField(
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (newValue) => controller.otp4 = newValue.toString().trim(),
                            focusNode: controller.f4,
                            onChanged: (value){
                              changeFocus("4",value);
                              //FocusScope.of(context).unfocus();
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                fillColor: white,
                                filled: true,
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: primaryColor1)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: primaryColor1)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width*0.1,
                          child: TextFormField(
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (newValue) => controller.otp5 = newValue.toString().trim(),
                            focusNode: controller.f5,
                            onChanged: (value){
                              changeFocus("5",value);
                              //FocusScope.of(context).requestFocus(f4);
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                fillColor: white,
                                filled: true,
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width*0.1,
                          child: TextFormField(
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (newValue) => controller.otp6 = newValue.toString().trim(),
                            focusNode: controller.f6,
                            onChanged: (value){
                              changeFocus("6",value);
                              //FocusScope.of(context).unfocus();
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                fillColor: white,
                                filled: true,
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: primaryColor1)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    Obx((){
                      return  CheckboxListTile(
                        value: controller.terms.value,
                        onChanged: (value){
                          controller.checkTerms();
                        },
                        title: const Text("I accept the terms and privacy policy",style:TextStyle(fontSize: 11)),);

                    }),
                    TextButton(
                        onPressed: () async{
                          controller.confirmOTP(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(primaryColor1),
                            minimumSize: MaterialStateProperty.all(Size(width, height*0.07)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),
                        )
                    ),
                   // const SizedBox(height: 5,),
                    //Text(controller.message,style: const TextStyle(fontSize: 18),),
                    const SizedBox(height: 5,),
                    TextButton(
                        onPressed: (){
                          controller.resend(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(primaryColor1),
                            minimumSize: MaterialStateProperty.all(Size(width, height*0.07)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                        child:  const Text(
                          "Resend OTP",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),
                        )
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isNumber(value){
    return int.parse(value)!=null;
  }

  void changeFocus(String focusNode,String value){

    if(focusNode=="1"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        controller.f2.requestFocus();
      }
    }else if(focusNode=="2"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        controller.f3.requestFocus();
      }else{
        controller.f1.requestFocus();
      }
    }else if(focusNode=="3"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        controller.f4.requestFocus();
      }else{
        controller.f2.requestFocus();
      }
    }else if(focusNode=="4"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        controller.f5.requestFocus();
      }else{
        controller.f3.requestFocus();
      }
    }else if(focusNode=="5"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        controller.f6.requestFocus();
      }else{
        controller.f4.requestFocus();
      }
    }else if(focusNode=="6"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        controller.f6.unfocus();
      }else{
        controller.f5.requestFocus();
      }
    }
  }

}