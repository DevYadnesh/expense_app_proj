import 'package:expense_proj/database/my_db_helper.dart';

class User_Model {
  int? user_id;
  String? user_name;
  String? user_email;
  String? user_pass;
  String? user_mobno;
  String? user_img;

  User_Model({this.user_id,this.user_name,this.user_email,this.user_pass,this.user_mobno,this.user_img});

  factory User_Model.fromMap(Map<String,dynamic> map){
    return User_Model(
      user_id: map[My_Db_Helper.USER_ID],
      user_name: map[My_Db_Helper.USER_NAME],
      user_email: map[My_Db_Helper.USER_EMAIL],
      user_pass: map[My_Db_Helper.USER_PASS],
      user_mobno: map[My_Db_Helper.USER_MOBNO],
      user_img: map[My_Db_Helper.USER_IMAGE],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      My_Db_Helper.USER_ID : user_id,
      My_Db_Helper.USER_NAME :user_name,
      My_Db_Helper.USER_EMAIL : user_email,
      My_Db_Helper.USER_PASS : user_pass,
      My_Db_Helper.USER_MOBNO : user_mobno,
      My_Db_Helper.USER_IMAGE : user_img,
    };
  }
}

