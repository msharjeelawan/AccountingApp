
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel{
  String? _id, _name, _email, _contact, _address, _passport, _passportExpiry, _dob,
  _idCard, _nationality, _registerDate, _profilePic;

  ClientModel(this._id,this._name,this._email,this._contact,this._address,this._passport,this._passportExpiry,
      this._dob,this._idCard,this._nationality,this._registerDate, this._profilePic);

  static List<ClientModel> list=[];

  //parse all clients in single request
  static List<ClientModel> mapToModel(List<QueryDocumentSnapshot<Map>> documentList){
    list.clear();
    documentList.forEach((document){
      var id = document.id;
      var name = document.data()["name"];
      var email =  document.data()["email"];
      var contact =  document.data()["contact"];
      var address =  document.data()["address"];
      var passport =  document.data()["passport"];
      var passportExpiry =  document.data()["p_expiry"];
      var dob =  document.data()["dob"];
      var idCard =  document.data()["id_card"];
      var nationality =  document.data()["nationality"];
      var registerDate =  document.data()["register_date"];
      var profiePic = document.data()["profile_pic"];
      list.add(ClientModel(id,name,email,contact,address,passport,passportExpiry,dob,idCard,nationality,registerDate,profiePic));
    });
    return list;
  }

  //parse one client in single request
  static List<ClientModel> addSingleSupplierInModelList(id, n, e, no, a, p, pExpiry, dob, idCard, nationality, rDate,pic) {
    list.add(ClientModel(id,n,e,no,a,p,pExpiry,dob,idCard,nationality,rDate,pic));
    return list;
  }


  get nationality => _nationality;

  get idCard => _idCard;

  get dob => _dob;

  get passportExpiry => _passportExpiry;

  get passport => _passport;

  get address => _address;

  get contact => _contact;

  get email => _email;

  get name => _name;

  get id => _id;

  get registerDate => _registerDate;

  set nationality(value) {
    _nationality = value;
  }

  set idCard(value) {
    _idCard = value;
  }

  set dob(value) {
    _dob = value;
  }

  set passportExpiry(value) {
    _passportExpiry = value;
  }

  set passport(value) {
    _passport = value;
  }

  set address(value) {
    _address = value;
  }

  set contact(value) {
    _contact = value;
  }

  set email(value) {
    _email = value;
  }

  set name(value) {
    _name = value;
  }

  set id(value) {
    _id = value;
  }

  set registerDate(value) {
    _registerDate = value;
  }
}