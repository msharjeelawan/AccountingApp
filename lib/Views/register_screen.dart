import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/service/firebase_auth_methods.dart';
import 'package:travel_accounting/service/firebase_crud_methods.dart';

import '../Helper/Constant.dart';
import '../Model/User.dart';
import '../widgets/default_button.dart';
import '../widgets/my_alert_dialog.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isEmail=true;
  String name="",phone="",email="",password="",confirmedPassword="",registrationType="Select Registration Type";
  String tempPassword="";
  bool _isObscure = true;
  bool _isObscure2 = true;
  double userNameheight=12.h;
  double mobileheight=12.h;
  double emailheight=12.h;
  double passwordheight=12.h;
  double confirmheight=12.h;
  double registraionheight=12.h;
  double buttonheight=8.h;

  @override
  Widget build(BuildContext context) {
  //  LoginSignupController _controller=LoginSignupController(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        actions: [
          IconButton(onPressed: (){
            isEmail = isEmail? false:true;
            setState((){});
            }, icon: Icon(isEmail?Icons.phone_android:Icons.email,color: primaryColor1,))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: getHeight(context)-80,
            padding:  EdgeInsets.symmetric(vertical: 1.h,horizontal: 8.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Registerhere,
                    textAlign: TextAlign.center,
                    style:  GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize:18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: SizedBox(height: 1.h,)),
                  buildUserNameFormField(),
                  SizedBox(height: 1.5.h,),
                  isEmail? buildEmailFormField() : buildPhoneFormField(),
                  SizedBox(height: 1.5.h,),
                  isEmail? buildPasswordFormField() : const SizedBox(),
                  SizedBox(height: 1.5.h,),
                  isEmail? buildConfirmPasswordFormField() : const SizedBox(),
                  SizedBox(height: 1.5.h,),
                  SizedBox(
                    height:buttonheight ,
                    child: DefaultButton(
                      text: "Next",
                      press: () {
                        register();
                      },
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  RichText(
                      text:  const TextSpan(
                          text: "By tapping Register, you agree to our ",
                          style: TextStyle(color: Colors.black45,fontSize: 12),
                          children: [
                            TextSpan(text: "Terms ",style: TextStyle(color: primaryColor1)),
                            TextSpan(text: "and have read and acknowledge our "),
                            TextSpan(text: "Global Privacy Statement",style: TextStyle(color: primaryColor1))
                            ],
                      ),
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                            onTap: () {
                              //KeyboardUtil.hideKeyboard(context);
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                              },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'Already registered? ',    style:  GoogleFonts.openSans(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.normal,
                                )),
                                TextSpan(text: 'Sign In',  style:  GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor1,
                                    fontStyle: FontStyle.normal
                                )),
                              ],
                            ),
                          )
                      ),
                      SizedBox(height: 0.01.h,),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => name = newValue.toString().trim(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter name ";
        }
      },
      decoration:  const InputDecoration(
        hintText: "Name",
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        prefixIcon: Icon(
            Icons.person,

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
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => phone = "+92${newValue.toString().trim()}",
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter mobile number";
        }else if(value.length>14){
            return "Please enter valid mobile number";
        }else if(value.startsWith("+")){
          return "Please remove +";
        }else if(value.startsWith("968")){
          return "Please remove 968";
        }
      },
      decoration:  InputDecoration(
        hintText: "Mobile Number",
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        prefixIcon: Container(
          width: 70,
          //height: 60,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: const [
              Icon(
                  Icons.phone_android_outlined,
              ),
              Text("+968",)
            ],
          ),
        ),
        labelStyle: const TextStyle(
            color:  Colors.black54
        ),
        //floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    FocusNode myFocusNode = FocusNode();
    return TextFormField(
      focusNode: myFocusNode,
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _isObscure,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) => password = newValue.toString().trim(),
      onChanged: (value) {
        password = value.toString().trim();
        /*     if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }*/
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 6) {
          return passwordlength;
        }else if (!alphanumeric.hasMatch(value) ) {
          return passwordformat;
        }else{
          tempPassword=value;
        }
      },

      decoration:  InputDecoration(
        hintText: "Password",
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        prefixIcon: const Icon(
            Icons.lock_outline,

        ),
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: _isObscure2,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => confirmedPassword = newValue.toString().trim(),
      onChanged: (value) {
        /*     if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }*/
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 6) {
          return passwordlength;
        }else if (!alphanumeric.hasMatch(value) ) {
          return passwordformat;
        }else if(tempPassword!=value){
          return "Please enter same password";
        }
      },
      decoration:  InputDecoration(
        hintText: "Confirm Password",
        prefixIcon: const Icon(
            Icons.lock_outline,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        labelStyle: const TextStyle(
            color:  Colors.black54
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
              _isObscure2
                  ? Icons.visibility_off:Icons.visibility,
              color: primaryColor1
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _isObscure2 = !_isObscure2;
            });
          },
        ),
        //   suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  void  register() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if(isEmail){
        MyAlertDialog.show(context);
        //registration using email
        FirebaseAuthMethods(context: context).createUserWithEmailPassword(email: email, password: password)
            .then((userCredential) async {
              if(userCredential.user!=null){
                //create user profile
                var userMap={"isCompanyCreated":false, "email":email,"name":name,"role":"admin"};
                await FirebaseCrudMethods(context: context).insertWithCustomKey(collection: "users", map: userMap, key: userCredential.user!.uid);
                if(mounted){
                  MyAlertDialog.hide(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/companyRegisterScreen', (route) => false);
                }
              }
            });
      }else{
        // save user info into model class for future
        saveUserInfoIntoModel();
        //registration using phone number
        FirebaseAuthMethods(context: context).authUserWithPhone(number: phone,fromLoginPage: false);
      }
    }
  }

  void saveUserInfoIntoModel(){
    var user = UserModel.myInstance;
    user.number=phone;
    user.name=name;
  }

}
