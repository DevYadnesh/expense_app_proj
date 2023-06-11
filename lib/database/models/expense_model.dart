import 'package:expense_proj/database/my_db_helper.dart';

class Expense_Model{
  int? expense_id;
  int? user_id;
  int? expense_type;
  int? expense_cat;
  int? expense_amount;
  int? expense_balance;
  String? expense_date;
  String? expense_title;
  String? expense_desc;


  Expense_Model({this.expense_id,this.user_id,this.expense_type,this.expense_cat,this.expense_amount,this.expense_balance,this.expense_date,this.expense_title,this.expense_desc,});

  factory Expense_Model.fromMap(Map<String,dynamic> map ){
    return Expense_Model(
      expense_id: map[My_Db_Helper.EXPENSE_ID],
      user_id: map[My_Db_Helper.USER_ID],
      expense_type: map[My_Db_Helper.EXPENSE_TYPE],
      expense_cat: map[My_Db_Helper.EXPENSE_CATEGORY],
      expense_amount: map[My_Db_Helper.EXPENSE_AMOUNT],
      expense_balance: map[My_Db_Helper.EXPENSE_BALANCE],
      expense_date: map[My_Db_Helper.EXPENSE_DATE],
      expense_title: map[My_Db_Helper.EXPENSE_TITLE],
      expense_desc: map[My_Db_Helper.EXPENSE_DESC],

    );
  }
  Map<String,dynamic> toMap(){
    return {
      My_Db_Helper.EXPENSE_ID :expense_id,
      My_Db_Helper.USER_ID : user_id,
      My_Db_Helper.EXPENSE_TYPE :expense_type,
      My_Db_Helper.EXPENSE_CATEGORY : expense_cat,
      My_Db_Helper.EXPENSE_AMOUNT :expense_amount,
      My_Db_Helper.EXPENSE_BALANCE :expense_balance,
      My_Db_Helper.EXPENSE_DATE :expense_date,
      My_Db_Helper.EXPENSE_TITLE :expense_title,
      My_Db_Helper.EXPENSE_DESC :expense_desc,


    };
  }
}