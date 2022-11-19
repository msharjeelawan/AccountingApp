import 'package:flutter/material.dart';


//strings

const String welcomelogin = "Welcome to Travel Accounting! \n Login Now";
const String kphoneNullError = "Please enter your mobile number";
const String kInvalidphoneError = "Please enter valid mobile";
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your Password";
const String Remberme="Remember Me";
const String passwordlength="Password length should be more than 6 digits";
const String passwordformat="Password should be alphanumeric";


const String Registerhere="Register Here";
const String forgotPassword="Forgot Password";
const String enterNewPassword="Enter New Password";
const String phonenumberlength="please Enter Valid Mobile Number";
const String passwordReseet="Password Reset";




//assets
const String logoimage = "assets/bulb.png";
const String guidesylogo = "assets/guidesylogo.png";

//colors
//const primaryColor = Color(0xFFF2E966);
const primaryColor1 = Color(0xFF9a46b4);
const primaryColor2 = Color(0xFF9382CE);
const Color white=Colors.white;
const primarySwatch = {
  50: Color.fromRGBO(154,70,180, .1),
  100: Color.fromRGBO(154,70,180, .2),
  200: Color.fromRGBO(154,70,180, .3),
  300: Color.fromRGBO(154,70,180, .4),
  400: Color.fromRGBO(154,70,180, .5),
  500: Color.fromRGBO(154,70,180, .6),
  600: Color.fromRGBO(154,70,180, .7),
  700: Color.fromRGBO(154,70,180, .8),
  800: Color.fromRGBO(154,70,180, .9),
  900: Color.fromRGBO(154,70,180, 1),
};
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp isContainLetter=RegExp( r"^?.*[a-zA-Z]+*");
final RegExp isContainNumber=RegExp( r"^.*[0-9]+*");
final RegExp  alphanumeric=RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])');

//with and height
double? _width, _height;

double getWidth(BuildContext context) {
return _width ??= MediaQuery
    .of(context)
    .size
    .width;
}

double getHeight(BuildContext context) {
return _height ??= MediaQuery
    .of(context)
    .size
    .height;
}