import 'dart:ui';

import 'package:expense_proj/database/models/expense_cat_model.dart';
import 'package:expense_proj/database/models/expense_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'models/user_model.dart';

class My_Db_Helper {
  ///////////// Expense db ////////////////

  static const TABLE_EXPENSE = 'expense_manager_table';
  static const EXPENSE_TITLE = 'e_title';
  static const EXPENSE_DESC = 'e_desc';
  static const EXPENSE_DATE = 'e_date';
  static const EXPENSE_AMOUNT = 'e_amount';
  static const EXPENSE_BALANCE = 'e_balance';
  static const EXPENSE_ID = 'e_id';
  static const EXPENSE_TYPE = 'e_type';
  static const EXPENSE_CATEGORY = 'e_cat';

  //////////// User db ///////////////////

  static const TABLE_USER = 'user_table';
  static const USER_ID = 'u_id';
  static const USER_NAME = 'u_name';
  static const USER_EMAIL = 'u_email';
  static const USER_PASS = 'u_pass';
  static const USER_MOBNO = 'u_mobno';
  static const USER_IMAGE = 'u_img';

  /////////////// Expense type db ////////////////
  static const TABLE_EXPENSE_CATEGORY = 'expense_cat_table';
  static const CATEGORY_ID = 'exp_cat_id';
  static const CATEGORY_TITLE = 'exp_cat_title';
  static const CATEGORY_IMG = 'exp_cat_img';

  Future<Database> openDB() async {
    var mDirectory = await getApplicationDocumentsDirectory();
    mDirectory.create(recursive: true);

    var mPath = '${mDirectory.path}/expense_manager.db';

    return await openDatabase(
      mPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('create table $TABLE_EXPENSE ('
            '$EXPENSE_ID integer primary key autoincrement,'
            ' $EXPENSE_TITLE text, $EXPENSE_DESC text,'
            ' $EXPENSE_AMOUNT integer, $EXPENSE_BALANCE integer,'
            ' $EXPENSE_TYPE integer, $USER_ID integer,$EXPENSE_DATE text,$EXPENSE_CATEGORY integer)');

        db.execute('create table $TABLE_USER ('
            '$USER_ID integer primary key autoincrement, $USER_EMAIL text,'
            '$USER_PASS text, $USER_MOBNO integer, $USER_IMAGE text,$USER_NAME text)');

        db.execute(
            'create table $TABLE_EXPENSE_CATEGORY  ('
                '$CATEGORY_ID integer primary key autoincrement,'
                '$CATEGORY_TITLE text,'
                '$CATEGORY_IMG text)');

        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                    title: 'Bills', path: 'assets/expense_icons/bill.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                    title: 'Rent', path: 'assets/expense_icons/rent.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                    title: 'Fast food', path: 'assets/expense_icons/burger.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                    title: 'Gifts', path: 'assets/expense_icons/giftbox.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                    title: 'Mechanic', path: 'assets/expense_icons/mechanic.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                    title: 'Recharge/Bill', path: 'assets/expense_icons/recharge.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                title: 'Books', path: 'assets/expense_icons/book.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                title: 'Health', path: 'assets/expense_icons/healthcare.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                title: 'Mess/Food', path: 'assets/expense_icons/lunch-time.png')
                .toMap());
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                title: 'Loan', path: 'assets/expense_icons/loan.png')
                .toMap());
       
        db.insert(
            TABLE_EXPENSE_CATEGORY,
            Category_Model(
                title: 'Shopping', path: 'assets/expense_icons/shopping-bag.png')
                .toMap());
      },
    );
  }

  Future<bool> addExpense(Expense_Model expense) async {
    var mDb = await openDB();
    var check = await mDb.insert(TABLE_EXPENSE, expense.toMap());
    return check > 0;
  }

  Future<List<Expense_Model>> getExpense() async {
    var mDb = await openDB();
    var sp = await SharedPreferences.getInstance();
    var id = sp.getInt('u_id');
    var ListExpense = await mDb
        .query(TABLE_EXPENSE, where: '$USER_ID=?', whereArgs: ['$id}']);
    List<Expense_Model> ListExpenseModel = [];
    for (Map<String, dynamic> expense in ListExpense) {
      ListExpenseModel.add(Expense_Model.fromMap(expense));
    }
    return ListExpenseModel;
  }

  Future<bool> deleteExpense(Expense_Model expense) async {
    var mDb = await openDB();
    var check = await mDb.delete(TABLE_EXPENSE,
        where: '$EXPENSE_ID = ?', whereArgs: ['${expense.expense_id}']);
    return check > 0;
  }


///////////////////// EXPENSE CATEGORY DATA FETCHING ///////////////////
  Future<List<Category_Model>> getExpenseCategory() async {
    var mDb = await openDB();
    var catData = await mDb.query(TABLE_EXPENSE_CATEGORY);
    List<Category_Model> listCatModel =[];
    for(Map<String,dynamic>cat in catData){
      listCatModel.add(Category_Model.fromMap(cat));
    }
    return listCatModel;
      
  }

  //////////////////////////////// LOGIN/SIGNUP ////////////////////////////////////

  Future<int> SignUp(User_Model user) async {
    var mDb = await openDB();
    int check;
    if (!await checkIfEmailAlreadyExist(user.user_email!)) {
      check = await mDb.insert(TABLE_USER, user.toMap());
    } else {
      check = -1;
    }
    return check;
  }

  Future<bool> checkIfEmailAlreadyExist(String email) async {
    var mDb = await openDB();
    List<Map<String, dynamic>> data = await mDb
        .query(TABLE_USER, where: '$USER_EMAIL= ?', whereArgs: [email]);
    return data.isNotEmpty;
  }

  Future<bool> SignIn(String email, String pass) async {
    var mDb = await openDB();
    List<Map<String, dynamic>> data = await mDb.query(TABLE_USER,
        where: '$USER_EMAIL = ? and $USER_PASS = ?',
        whereArgs: [email, pass]);
    if (data.isNotEmpty) {
      var sp = await SharedPreferences.getInstance();
      sp.setInt('user_id', data[0][USER_ID]);
    }
    return data.isNotEmpty;
  }
}
