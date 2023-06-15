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

Future<List<Map<String,dynamic>>> getExpensesDayWise()async{
 var data = await mdbHelper.getExpense();
 return filterExpenseDateWise(arrExpenseData: data.reversed.toList());
}

Future<List<Map<String,dynamic>>> getExpensesMonthWise()async{
 var data = await mdbHelper.getExpense();
 return filterExpenseMonthWise(arrExpenseData: data.reversed.toList());
}
Future<List<Map<String,dynamic>>> getExpensesYearWise()async{
 var data = await mdbHelper.getExpense();
 return filterExpenseYearWise(arrExpenseData: data.reversed.toList());
}



List<Map<String,dynamic>> filterExpenseDateWise({required List<Expense_Model> arrExpenseData}){
 List<Map<String,dynamic>> arrDateWiseData = [];
 var uniqueDate = [];
 arrDateWiseData.clear();


var today = DateTime.now();
 var yesterday = today.subtract(Duration(days: 1));
var TodayDate ='${today.year}-${today.month.toString().length == 1 ? '0${today.month}' : '${today.month}'}-${today.day.toString().length == 1 ? '0${today.day}' :  '${today.day}'}';
var YestardayDate ='${yesterday.year}-${yesterday.month.toString().length == 1 ? '0${yesterday.month}' : '${yesterday.month}'}-${yesterday.day.toString().length == 1 ? '0${yesterday.day}' :  '${yesterday.day}'}';

 for(Expense_Model model in arrExpenseData){
  var eachDateFormat = DateTime.parse(model.expense_date!);

  var eachDate = '${eachDateFormat.year}-${eachDateFormat.month.toString().length == 1 ? '0${eachDateFormat.month}' : '${eachDateFormat.month}'}-${eachDateFormat.day.toString().length == 1 ? '0${eachDateFormat.day}' :  '${eachDateFormat.day}'}';

  if(!uniqueDate.contains(eachDate)){
   uniqueDate.add(eachDate);

  }

 }


 for(String eachDate in uniqueDate){
  List<Expense_Model> eachDateTransactions = arrExpenseData.where((element) => element.expense_date!.contains(eachDate)).toList();


  if(eachDate == TodayDate){
   eachDate = 'Today';
  }else if (eachDate == YestardayDate){
   eachDate = 'Yesterday';
  }
  print(TodayDate);
  print(YestardayDate);

  var eachDayamt = 0.0;

  eachDateTransactions.forEach((transaction) {
   if(transaction.expense_type == 1){
    eachDayamt -= transaction.expense_amount!;
   }else {
    eachDayamt += transaction.expense_amount!;
   }
  });



  Map<String,dynamic> eachDateMap = {};
  eachDateMap['day'] = '$eachDate';
  eachDateMap['amt'] = eachDayamt.isNegative ? '-$eachDayamt' : '+$eachDayamt';
  eachDateMap['Transcations'] = eachDateTransactions;
  arrDateWiseData.add(eachDateMap);
 }
 return arrDateWiseData;

}

List<Map<String,dynamic>> filterExpenseMonthWise({required List<Expense_Model> arrExpenseData}){
 List<Map<String,dynamic>> arrMonthWiseData = [];
 var uniqueMonths = [];
 arrMonthWiseData.clear();


var today = DateTime.now();
 var yesterday = today.subtract(Duration(days: 30));
var thisMonth ='${today.year}-${today.month.toString().length == 1 ? '0${today.month}' : '${today.month}'}';
var prevMonth ='${yesterday.year}-${yesterday.month.toString().length == 1 ? '0${yesterday.month}' : '${yesterday.month}'}}';

 for(Expense_Model model in arrExpenseData){
  var eachMonthFormat = DateTime.parse(model.expense_date!);

  var eachMonth = '${eachMonthFormat.year}-${eachMonthFormat.month.toString().length == 1 ? '0${eachMonthFormat.month}' : '${eachMonthFormat.month}'}';

  if(!uniqueMonths.contains(eachMonth)){
   uniqueMonths.add(eachMonth);

  }

 }


 for(String eachMonth in uniqueMonths){
  List<Expense_Model> eachMonthTransactions = arrExpenseData.where((element) => element.expense_date!.contains(eachMonth)).toList();


  if(eachMonth == thisMonth){
   eachMonth = 'This Month';
  }else if (eachMonth == prevMonth){
   eachMonth = 'Prevoius Month';
  }
  print(thisMonth);
  print(prevMonth);

  var eachMonthamt = 0.0;

  eachMonthTransactions.forEach((transaction) {
   if(transaction.expense_type == 1){
    eachMonthamt -= transaction.expense_amount!;
   }else {
    eachMonthamt += transaction.expense_amount!;
   }
  });



  Map<String,dynamic> eachDateMap = {};
  eachDateMap['month'] = '$eachMonth';
  eachDateMap['amt'] = eachMonthamt.isNegative ? '-$eachMonthamt' : '+$eachMonthamt';
  eachDateMap['Transcations'] = eachMonthTransactions;
  arrMonthWiseData.add(eachDateMap);
 }
 return arrMonthWiseData;

}

List<Map<String,dynamic>> filterExpenseYearWise({required List<Expense_Model> arrExpenseData}){
 List<Map<String,dynamic>> arrYearWiseData = [];
 var uniqueYears = [];
 arrYearWiseData.clear();


var today = DateTime.now();
 var yesterday = today.subtract(Duration(days: 365));
var thisYear ='${today.year}';
var prevYear ='${yesterday.year}';

 for(Expense_Model model in arrExpenseData){
  var eachYearFormat = DateTime.parse(model.expense_date!);

  var eachYear = '${eachYearFormat.year}';

  if(!uniqueYears.contains(eachYear)){
   uniqueYears.add(eachYear);

  }

 }


 for(String eachYear in uniqueYears){
  List<Expense_Model> eachYearTransactions = arrExpenseData.where((element) => element.expense_date!.contains(eachYear)).toList();


  if(eachYear == thisYear){
   eachYear = 'This Year';
  }else if (eachYear == prevYear){
   eachYear = 'Prevoius Year';
  }
  print(thisYear);
  print(prevYear);

  var eachYearamt = 0.0;

  eachYearTransactions.forEach((transaction) {
   if(transaction.expense_type == 1){
    eachYearamt -= transaction.expense_amount!;
   }else {
    eachYearamt += transaction.expense_amount!;
   }
  });



  Map<String,dynamic> eachYearMap = {};
  eachYearMap['year'] = '$eachYear';
  eachYearMap['amt'] = eachYearamt.isNegative ? '-$eachYearamt' : '+$eachYearamt';
  eachYearMap['Transcations'] = eachYearTransactions;
  arrYearWiseData.add(eachYearMap);
 }
 return arrYearWiseData;

}
}