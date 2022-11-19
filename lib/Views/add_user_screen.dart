import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Model/User.dart';
import 'package:travel_accounting/service/firebase_auth_methods.dart';
import 'package:travel_accounting/service/firebase_crud_methods.dart';
import 'package:travel_accounting/widgets/MyScaffold.dart';
import 'package:travel_accounting/widgets/my_alert_dialog.dart';

import '../Helper/Constant.dart';
import '../widgets/default_button.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEmail=true;
  String name="",phone="",email="",password="",confirmedPassword="",registrationType="Select Registration Type";
  List<String> roles=["Select Role","Admin","Sub-user"];
  String selectedRole="Select Role";
  String tempPassword="";
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Add User"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: getHeight(context)-80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  buildNameFormField(),
                  SizedBox(height: 3.h,),
                  isEmail? buildEmailFormField(): buildPhoneFormField(),
                  SizedBox(height: 3.h,),
                  isEmail? buildPasswordFormField():const SizedBox(),
                  SizedBox(height: 3.h,),
                  isEmail? buildConfirmPasswordFormField():const SizedBox(),
                  SizedBox(height: 3.h,),
                  DropdownButton(
                    value: selectedRole,
                    isExpanded: true,
                    items: roles.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                    }).toList(),
                    onChanged: (value){
                      selectedRole=value as String;
                      setState((){});
                      },
                  ),
                  SizedBox(height: 3.h,),
                  DefaultButton(
                    text: "Add User",
                    press: () {
                      addUser();
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

  TextFormField buildNameFormField() {
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

  void addUser(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      if(selectedRole=="Select Role"){
        MyScaffold.show(context, "Please select user role");
        return;
      }
      if(isEmail){
        MyAlertDialog.show(context);
        //registration using email
        FirebaseAuthMethods(context: context).createUserWithEmailPassword(email: email, password: password)
            .then((userCredential) async {
          if(userCredential.user!=null){
            //create user profile
            var userMap={"id":userCredential.user!.uid, "isCompanyCreated":true, "email":email,"name":name,
            "companyId":UserModel.myInstance.companyId,"role":selectedRole,};
            await FirebaseCrudMethods(context: context).insert(collection: "users", map: userMap);
            if(mounted){
              MyAlertDialog.hide(context);
              Navigator.pop(context);
            }
          }
        });
      }else{
        //registration using phone number
        FirebaseAuthMethods(context: context).authUserWithPhone(number: phone,fromLoginPage: false);
      }
    }
  }
}