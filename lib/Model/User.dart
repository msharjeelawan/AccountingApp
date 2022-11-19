import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? _id, _name, _email, _number, _role, _companyId;
  late bool isLoginFromEmail=true;//only for current login user not for others
  UserModel._constructor();
  static final UserModel myInstance = UserModel._constructor();
  static List<UserModel> userList=[];
  
  UserModel(this._id,this._name,this._email,this._number,this._role,this._companyId);

  static List<UserModel> mapToModel(List<QueryDocumentSnapshot<Map<String, dynamic>>> list){
    userList.clear();
    try{
      list.forEach((document) {
        print(document.data());
        var userId = document.id;
        var name = document.data()["name"] ?? "";
        var email = document.data()["email"] ?? "";
        var number = document.data()["number"] ?? "";
        var companyId = document.data()["companyId"] ?? "";
        var role = document.get("role") ?? "";
        var user = UserModel(userId, name, email, number, role, companyId);
        userList.add(user);
      });
    }catch(e){
      print(e.toString());
    }
    return userList;
  }
  
  
  String? get role => _role;

  String? get number => _number;

  String? get email => _email;

  String? get name => _name;

  String? get id => _id;

  get companyId => _companyId;

  set role(String? value) {
    _role = value;
  }

  set number(String? value) {
    _number = value;
  }

  set email(String? value) {
    _email = value;
  }

  set name(String? value) {
    _name = value;
  }

  set id(String? value) {
    _id = value;
  }

  set companyId(value) {
    _companyId = value;
  }
}