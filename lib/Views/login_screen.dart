import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import 'package:travel_accounting/service/firebase_auth_methods.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';
import 'package:travel_accounting/widgets/my_alert_dialog.dart';

import '../Helper/Constant.dart';
import '../Model/User.dart';
import '../widgets/default_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
 String phone="",password="",email="";
  bool _isObscure = true;
  bool isRememberMe = false;
  bool isEmail=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            isEmail = isEmail? false:true;
            setState((){});
            },
              icon: Icon(isEmail?Icons.phone_android:Icons.email,color: primaryColor1,semanticLabel: "login",)
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: getHeight(context)-80,
            padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal: 8.w),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      welcomelogin,
                      textAlign: TextAlign.center,
                      style:  GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize:16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "LOGO",
                      textAlign: TextAlign.center,
                      style:  GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize:16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Image.asset(
                    //   logoimage,
                    //   height:20.h,
                    //   width: 20.w,
                    // ),
                    const Expanded(child: SizedBox()),
                    isEmail? buildEmailFormField() : buildPhoneFormField(),
                    SizedBox(height: 2.h,),
                    isEmail? buildPasswordFormField() : const SizedBox(),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: primaryColor1,
                          value: isRememberMe,
                          onChanged:(value){
                          isRememberMe = isRememberMe?false:true;
                          setState((){});
                          },
                        ),
                        Text(Remberme,
                          style: GoogleFonts.openSans(
                            color: Colors.black54,
                            fontSize:14.sp,
                          ),
                        )
                      ],
                    ),
                    !isEmail? const SizedBox() : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/forgot'),
                            child: Text("Forgot Password?",
                                style:  GoogleFonts.openSans(
                              color: Colors.black54,
                                  fontSize:14.sp,
                              textStyle:const TextStyle(fontStyle: FontStyle.italic,
                              ),
                            ))
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    DefaultButton(
                      text: "Login",
                      press: () {
                        login();
                      },
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/register'),
                            child:RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: 'Don\'t have an account? ',    style:  GoogleFonts.openSans(
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic,
                                  )),
                                  TextSpan(text: 'Register Here',  style:  GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor1,
                                      fontStyle: FontStyle.italic
                                  )),
                                ],
                              ),
                            )
                        ),
                        SizedBox(height: 1.h),
                        // StreamBuilder(
                        //     stream: _controller.stream,
                        //     initialData: false,
                        //     builder: (context, snapshot) {
                        //       return snapshot.data == true
                        //           ? const Center(
                        //         child: CircularProgressIndicator(),
                        //       )
                        //           : Container();
                        //     }),
                      ],
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue.toString().trim(),
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
      },
      decoration:  const InputDecoration(
        hintText: "Email",
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        prefixIcon: Icon(
          Icons.email,
        ),
        labelStyle: TextStyle(
            color:  Colors.black54
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = "+92${newValue.toString().trim()}",
      validator: (value) {
        if (value!.isEmpty) {
          return kphoneNullError;
        }
        else if(value.length>14){
          return "Please enter valid phone number";
        }
      },
      decoration:  const InputDecoration(
        hintText: "Mobile Number",
        prefixIcon: Icon(
          Icons.phone_android_outlined,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        labelStyle: TextStyle(
            color:  Colors.black54
        ),
      ),
    );
  }
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _isObscure,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) => password = newValue.toString().trim(),
      onChanged: (value) {
   /*     if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }*/
       // return;
      },
      validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          } else if (value.length < 6) {
            return passwordlength;
          }else if (!alphanumeric.hasMatch(value) ) {
            return passwordformat;
          }
      },
      decoration:  InputDecoration(
        hintText: "Password",
        prefixIcon: const Icon(
            Icons.lock_outline,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        labelStyle: const TextStyle(
            color:  Colors.black54
        ),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _isObscure
                ? Icons.visibility_off:Icons.visibility,
            color: primaryColor1
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
    );
  }

  void login(){
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(isEmail){
        MyAlertDialog.show(context);
        FirebaseAuthMethods(context: context).loginWithEmailPassword(email: email, password: password)
            .then((credential) async {
              FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get()
              .then((documentList) {
                MyAlertDialog.hide(context);
                //save user info in user class for later use
                saveUserInfoToUserModelInstance(credential:credential, userDocument:documentList);

                if(documentList.get("isCompanyCreated")){
                  MyScaffold.show(context, "Login Successfully");
                  Navigator.pushReplacementNamed(context, '/main');
                }else{
                  Navigator.pushNamedAndRemoveUntil(context, '/companyRegisterScreen', (route) => false);
                  MyScaffold.show(context, "Create Company profile with basic info");
                }
              });
        });
      }else{
        // save user info into model class for future
        saveUserInfoToUserModelInstance();
        FirebaseAuthMethods(context: context).authUserWithPhone(number: phone, fromLoginPage: true);
      }
    }
  }

  void saveUserInfoToUserModelInstance({credential,userDocument}){
    if(!isEmail){
      UserModel.myInstance.number=phone;
      return;
    }
    UserModel.myInstance.email=email;
    UserModel.myInstance.id=credential.user!.uid;
    UserModel.myInstance.name=userDocument.get("name");
    UserModel.myInstance.role=userDocument.get("role");
    UserModel.myInstance.companyId=userDocument.data()["companyId"] ?? "";
  }
}
