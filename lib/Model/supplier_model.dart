
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_accounting/Model/products_services_model.dart';

class SupplierModel {
  String? _id, _name, _email, _no, _location, _bankAccountTitle, _bankAccountNo;
  List<ProductsServicesModel> products=[];
  SupplierModel(this._id, this._name,this._email,this._no,this._location,this._bankAccountTitle,this._bankAccountNo);

  static List<SupplierModel> list=[];

  //parse all suppliers in single request
  static List<SupplierModel> mapToModel(List<QueryDocumentSnapshot<Map>> documentList){
    list.clear();
    documentList.forEach((document){
      var id = document.id;
      var name = document.data()["name"];
      var email =  document.data()["email"];
      var no =  document.data()["no"];
      var location =  document.data()["location"];
      var accountTitle =  document.data()["account_title"];
      var accountNo =  document.data()["account_no"];
      list.add(SupplierModel(id,name,email,no,location,accountTitle,accountNo));
    });
    return list;
  }

  //parse one supplier in single request
  static List<SupplierModel> addSingleSupplierInModelList(String id, name, email, no, location, accountTitle, accountNo) {
    list.add(SupplierModel(id,name,email,no,location,accountTitle,accountNo));
    return list;
  }

  get bankAccountNo => _bankAccountNo;

  get bankAccountTitle => _bankAccountTitle;

  get location => _location;

  get no => _no;

  get email => _email;

  get name => _name;

  get id => _id;
}