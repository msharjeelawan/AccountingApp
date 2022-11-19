
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel{
  String? _id, _date, _amount, _paymentMethod, _type, _description, _billNo;

  ExpenseModel(this._id,this._date,this._amount,this._paymentMethod,this._type,this._description,this._billNo);

  static List<ExpenseModel> list = [];

  static fromMap(List<QueryDocumentSnapshot> documentList){
    list.clear();
  }

  get billNo => _billNo;

  get description => _description;

  get type => _type;

  get paymentMethod => _paymentMethod;

  get amount => _amount;

  get date => _date;

   get id => _id;
}