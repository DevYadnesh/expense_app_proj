import 'package:expense_proj/database/my_db_helper.dart';

class Category_Model{
int? id;
String? title;
String? path;

Category_Model({this.id,this.title,this.path});

factory Category_Model.fromMap(Map<String,dynamic> map){
  return Category_Model(
    id: map[My_Db_Helper.CATEGORY_ID],
    title: map[My_Db_Helper.CATEGORY_TITLE],
    path: map[My_Db_Helper.CATEGORY_IMG],
  );
}

Map<String,dynamic> toMap(){
  return {
    My_Db_Helper.CATEGORY_ID :id,
    My_Db_Helper.CATEGORY_TITLE :title,
    My_Db_Helper.CATEGORY_IMG :path,
  };
}
}