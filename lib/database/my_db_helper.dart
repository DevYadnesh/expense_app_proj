import 'dart:ui';

import 'package:expense_proj/database/models/expense_cat_model.dart';
import 'package:expense_proj/database/models/expense_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class My_Db_Helper {

  ///////////// Expense db ////////////////

  static const TABLE_EXPENSE ='expense_manager_table';
  static const COLUMN_EXPENSE_TITLE ='e_title';
  static const COLUMN_EXPENSE_DESC ='e_desc';
  static const COLUMN_EXPENSE_DATE ='e_date';
  static const COLUMN_EXPENSE_AMOUNT ='e_amount';
  static const COLUMN_EXPENSE_BALANCE ='e_balance';
  static const COLUMN_EXPENSE_ID ='e_id';
  static const COLUMN_EXPENSE_TYPE ='e_type';


  //////////// User db ///////////////////

  static const TABLE_USER ='user_table';
  static const COLUMN_USER_ID ='u_id';
  static const COLUMN_USER_EMAIL ='u_email';
  static const COLUMN_USER_PASS ='u_pass';
  static const COLUMN_USER_MOBNO ='u_mobno';
  static const COLUMN_USER_IMAGE ='u_img';

  /////////////// Expense type db ////////////////
  static const TABLE_EXPENSE_CATEGORY = 'expense_cat_table';
  static const COLUMN_EXP_CAT_ID = 'exp_cat_id';
  static const COLUMN_EXP_CAT_TITLE = 'exp_cat_title';
  static const COLUMN_EXP_CAT_PATH = 'exp_cat_img';




  Future<Database> openDB()async{
    var mDirectory =  await getApplicationDocumentsDirectory();
    mDirectory.create(recursive: true);

    var mPath = '${mDirectory.path}/expense_manager.db';

   return await openDatabase(mPath,version: 1,onCreate: (db, version) {
      db.execute(
          'create table $TABLE_EXPENSE ('
              '$COLUMN_EXPENSE_ID integer primary key autoincrement,'
              ' $COLUMN_EXPENSE_TITLE text, $COLUMN_EXPENSE_DESC text,'
              ' $COLUMN_EXPENSE_AMOUNT integer, $COLUMN_EXPENSE_BALANCE integer,'
              ' $COLUMN_EXPENSE_TYPE integer, $COLUMN_USER_ID integer)');

      db.execute(
          'create table $TABLE_USER ('
              '$COLUMN_USER_ID integer primary key autoincrement, $COLUMN_USER_EMAIL text,'
              ' $COLUMN_USER_PASS text, $COLUMN_USER_MOBNO integer, $COLUMN_USER_IMAGE text)');

      db.execute('create table $TABLE_EXPENSE_CATEGORY ($COLUMN_EXP_CAT_TITLE text, $COLUMN_EXP_CAT_PATH text)');

      db.insert(TABLE_EXPENSE_CATEGORY, Expense_Type_Model(title: 'Health',path: 'assets/images/expense_type_icons/healthcare.png').toMap());
      db.insert(TABLE_EXPENSE_CATEGORY, Expense_Type_Model(title: 'Rent',path: 'assets/images/expense_type_icons/rent.png').toMap());
      db.insert(TABLE_EXPENSE_CATEGORY, Expense_Type_Model(title: 'Fast food',path: 'assets/images/expense_type_icons/burger.png').toMap());
      db.insert(TABLE_EXPENSE_CATEGORY, Expense_Type_Model(title: 'Loan',path: 'assets/images/expense_type_icons/loan.png').toMap());
      db.insert(TABLE_EXPENSE_CATEGORY, Expense_Type_Model(title: 'Salary',path: 'assets/images/expense_type_icons/salary.png').toMap());
      db.insert(TABLE_EXPENSE_CATEGORY, Expense_Type_Model(title: 'Grocery',path: 'assets/images/expense_type_icons/shopping-bag.png').toMap());
    },);

  }
  
  Future<bool> addExpense(Expense_Model expense)async{
    var mDb = await openDB();
   var check = await mDb.insert(TABLE_EXPENSE,expense.toMap());
   return check>0;
  }

  Future<List<Expense_Model>> getExpense()async{
    var mDb = await openDB();
    List<Map<String,dynamic>> listNote = await mDb.query(TABLE_EXPENSE);

    List<Expense_Model> listNoteModel = [];

    for(Map<String,dynamic> note in listNote ){
      listNoteModel.add(Expense_Model.fromMap(note));
    }
    return listNoteModel;
  }
  Future<bool> updateExpense(Expense_Model expense)async{
    var mDb = await openDB();
   var check = await mDb.update(TABLE_EXPENSE, {COLUMN_EXPENSE_TITLE :expense.title,COLUMN_EXPENSE_DESC : expense.desc},
        where:'$COLUMN_EXPENSE_ID = ? && $COLUMN_EXPENSE_TYPE = ?', whereArgs: ['${expense.id},${expense.type}'] );
   return check >0;
  }

  Future<bool> deleteExpense(Expense_Model expense)async{
    var mDb = await openDB();
  var check = await  mDb.delete(TABLE_EXPENSE,where: '$COLUMN_EXPENSE_ID = ?', whereArgs: ['${expense.id}']);
  return check>0;
  }


  Future<List<Expense_Type_Model>> getExpenseCat()async {
    var mDb = await openDB();
    List<Map<String, dynamic>> expenseCat = await mDb.query(
        TABLE_EXPENSE_CATEGORY);

    List<Expense_Type_Model> listExpenseCatModel = [];

    for (Map<String, dynamic> expense_cat in expenseCat) {
      listExpenseCatModel.add(Expense_Type_Model.fromMap(expense_cat));
    }
    return listExpenseCatModel;
  }

}