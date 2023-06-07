import 'package:expense_proj/database/my_db_helper.dart';

class Expense_Model{
  int? id;
  int? type;
  int? date;
  String? title;
  String? desc;
  int? amount;
  int? balance;

  Expense_Model({this.id,this.type,this.date,this.title,this.desc,this.amount,this.balance});

  factory Expense_Model.fromMap(Map<String,dynamic> map ){
    return Expense_Model(
      id: map[My_Db_Helper.COLUMN_EXPENSE_ID],
      type: map[My_Db_Helper.COLUMN_EXPENSE_TYPE],
      date: map[My_Db_Helper.COLUMN_EXPENSE_DATE],
      title: map[My_Db_Helper.COLUMN_EXPENSE_TITLE],
      desc: map[My_Db_Helper.COLUMN_EXPENSE_DESC],
      amount: map[My_Db_Helper.COLUMN_EXPENSE_AMOUNT],
      balance: map[My_Db_Helper.COLUMN_EXPENSE_BALANCE],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      My_Db_Helper.COLUMN_EXPENSE_ID :id,
      My_Db_Helper.COLUMN_EXPENSE_TYPE :type,
      My_Db_Helper.COLUMN_EXPENSE_DATE :date,
      My_Db_Helper.COLUMN_EXPENSE_TITLE :title,
      My_Db_Helper.COLUMN_EXPENSE_DESC :desc,
      My_Db_Helper.COLUMN_EXPENSE_AMOUNT :amount,
      My_Db_Helper.COLUMN_EXPENSE_BALANCE :balance,
    };
  }
}