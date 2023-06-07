import 'package:expense_proj/database/my_db_helper.dart';

class Expense_Type_Model{
int? id;
String? title;
String? path;

Expense_Type_Model({this.id,this.title,this.path});

factory Expense_Type_Model.fromMap(Map<String,dynamic> map){
  return Expense_Type_Model(
    id: map[My_Db_Helper.COLUMN_EXP_CAT_ID],
    title: map[My_Db_Helper.COLUMN_EXP_CAT_TITLE],
    path: map[My_Db_Helper.COLUMN_EXP_CAT_PATH],
  );
}

Map<String,dynamic> toMap(){
  return {
    My_Db_Helper.COLUMN_EXP_CAT_ID :id,
    My_Db_Helper.COLUMN_EXP_CAT_TITLE :title,
    My_Db_Helper.COLUMN_EXP_CAT_PATH :path,
  };
}
}