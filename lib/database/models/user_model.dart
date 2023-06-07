import 'package:expense_proj/database/my_db_helper.dart';

class User_Model {
  int? id;
  String? email;
  String? pass;
  String? mobno;
  String? img;

  User_Model({this.id,this.email,this.pass,this.mobno,this.img});

  factory User_Model.fromMap(Map<String,dynamic> map){
    return User_Model(
      id: map[My_Db_Helper.COLUMN_USER_ID],
      email: map[My_Db_Helper.COLUMN_USER_EMAIL],
      pass: map[My_Db_Helper.COLUMN_USER_PASS],
      mobno: map[My_Db_Helper.COLUMN_USER_MOBNO],
      img: map[My_Db_Helper.COLUMN_USER_IMAGE],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      My_Db_Helper.COLUMN_USER_ID : id,
      My_Db_Helper.COLUMN_USER_EMAIL : email,
      My_Db_Helper.COLUMN_USER_PASS : pass,
      My_Db_Helper.COLUMN_USER_MOBNO : mobno,
      My_Db_Helper.COLUMN_USER_IMAGE : img,
    };
  }
}

