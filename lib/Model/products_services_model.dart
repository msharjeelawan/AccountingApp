
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductsServicesModel{
  String? _id,_name;
  late final _isChecked=false.obs;
  ProductsServicesModel(this._id,this._name);

  static List<ProductsServicesModel> list=[];

  //parse all products in single request
  static List<ProductsServicesModel> mapToModel(List<QueryDocumentSnapshot> documentList){
    list.clear();
    documentList.forEach((document){
      list.add(ProductsServicesModel(document.id,document.get("name")));
    });
    return list;
  }

  //parse one product or service in single request
  static List<ProductsServicesModel> addSingleProductInModelList(String id, String name) {
    list.add(ProductsServicesModel(id,name));
    return list;
  }

  RxBool get isChecked => _isChecked;

  String? get name => _name;

  String? get id => _id;

  set isChecked(RxBool rxBool) {
    _isChecked.value = rxBool.value;
  }
}