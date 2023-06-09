import 'package:expense_proj/database/models/expense_cat_model.dart';
import 'package:expense_proj/database/models/expense_model.dart';
import 'package:expense_proj/database/my_db_helper.dart';

class Expense_Repo{
My_Db_Helper mdbHelper;
Expense_Repo({required this.mdbHelper});

Future<bool> addExpense(Expense_Model newExpense)async{
bool check = await  mdbHelper.addExpense(newExpense);
return check;
}
Future<List<Expense_Model>> getExpense()async{
 var data = await mdbHelper.getExpense();
 return data;
}

Future<List<Category_Model>> getExpenseCat()async{
 var catdata = await mdbHelper.getExpenseCategory();
 return catdata;
}
}