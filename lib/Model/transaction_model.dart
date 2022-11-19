
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? _id, _companyId, _userId, _serviceId, _serviceName, _supplierId, _supplierName, _date,  _description, _type, _customerId,
      _customerName, _name, _paymentMethod, _paymentAccountId, _billNo;

  // TransactionModel(this._id, this._companyId, this._userId, this._serviceId, this._serviceName, this._date, this._description,this._type,{String? supplierId,String? supplierName,String? customerId,String? customerName}){
  //   if(serviceId!=null){
  //     _serviceId=serviceId;
  //     _serviceName=_serviceName;
  //   }else{
  //     _customerId=customerId;
  //     _customerName=customerName;
  //   }
  // }

  TransactionModel.purchase(this._id, this._companyId, this._userId, this._date, this._description,this._type, this._serviceId, this._serviceName, this._supplierId, this._supplierName);

  TransactionModel.sale(this._id, this._companyId, this._userId, this._date, this._description, this._type,this._serviceId, this._serviceName, this._customerId, this._customerName);

  TransactionModel.expense(this._id, this._companyId, this._userId, this._date, this._description,this._type, this._paymentMethod, this._paymentAccountId, this._billNo, this._name);

  List<TransactionDetail> detailList=[];
  static List<TransactionModel> list=[];
  static List<TransactionModel> fromDocumentListToModel(List<QueryDocumentSnapshot<Map<String,dynamic>>> documentList){
    list.clear();
    documentList.forEach((document){
      var id = document.id;
      var companyId = document.data()["companyId"];
      var userId =  document.data()["userId"];
      var serviceId =  document.data()["serviceId"];
      var serviceName = document.data()["serviceName"];
      var date =  document.data()["date"];
      var description =  document.data()["description"];
      var type =  document.data()["type"];
      var paymentMethod = document.data()["paymentMethod"];
      var paymentAccountId = document.data()["paymentAccountId"];

      //for purchase transaction
      var supplierId =  document.data()["supplierId"];
      var supplierName = document.data()["supplierName"];
      //for sale transaction
      var customerId = document.data()["customerId"];
      var customerName = document.data()["customerName"];
      //for expense
      var name = document.data()["name"];
      var billNo = document.data()["billNo"];


      //fetch each transaction detail
      if(type=="Purchase"){
        //purchase from supplier
        list.add(TransactionModel.purchase(id, companyId, userId, date, description, type, serviceId, serviceName, supplierId, supplierName));
      }else if(type=="Sale"){
        //sale to customer
        list.add(TransactionModel.sale(id, companyId, userId, date, description, type, serviceId, serviceName, customerId, customerName));
      }else if(type=="Expense"){
        //expense of company
        list.add(TransactionModel.expense(id, companyId, userId, date, description, type, paymentMethod, paymentAccountId, billNo, name));
      }

    });
    return list;
  }

  static List<TransactionDetail> fromDetailDocumentListToModel(List<QueryDocumentSnapshot<Map<String,dynamic>>> documentList){
    List<TransactionDetail> list = [];
    documentList.forEach((document){
      var accountId = document.data()["accountId"];
      var amount =  document.data()["amount"];
      var entry =  document.data()["entryType"];
      list.add(TransactionDetail(accountId,amount,entry));
    });
    return list;
  }

  get id => _id;

  get companyId => _companyId;

  get description => _description;

  get serviceId => _serviceId;

  get serviceName => _serviceName;

  get supplierId => _supplierId;

  get supplierName => _supplierName;

  get date => _date;

  get userId => _userId;

  get type => _type;

  get customerName => _customerName;

  get customerId => _customerId;

  get billNo => _billNo;

  get paymentAccountId => _paymentAccountId;

  get paymentMethod => _paymentMethod;

  get name => _name;
}



class TransactionDetail{
  String? _accountId, _amount, _entryType;
  TransactionDetail(this._accountId,this._amount,this._entryType);

  get entryType => _entryType;

  get amount => _amount;

  get accountId => _accountId;
}