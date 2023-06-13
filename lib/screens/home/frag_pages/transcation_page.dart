import 'package:expense_proj/Constants/Constants.dart';
import 'package:expense_proj/database/models/expense_cat_model.dart';

import 'package:expense_proj/screens/add_expense/add_expense_page.dart';
import 'package:expense_proj/screens/home/bloc/expense/expense_bloc.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../database/models/expense_model.dart';
import '../bloc/category/cat_bloc.dart';

class Transcation_Page extends StatefulWidget {
  const Transcation_Page({super.key});

  @override
  State<Transcation_Page> createState() => _Transcation_PageState();
}

class _Transcation_PageState extends State<Transcation_Page> {
  var isLight;
  var TotalSpent = 0.0;
  var dummyData = Constants.arrTranscations;





late List<Expense_Model> arrExpenseData;
List<Map<String,dynamic>> arrDateWiseData = [];
List<Category_Model> arrCat = [];

late DateTime date;
late String TodayDate;
late String YestardayDate;


  @override
  void initState() {
    super.initState();

    date = DateTime.now();
    var yesterday = date.subtract(Duration(days: 1));
    TodayDate ='${date.year}-${date.month.toString().length == 1 ? '0${date.month}' : '${date.month}'}-${date.day.toString().length == 1 ? '0${date.day}' :  '${date.day}'}';
    YestardayDate ='${yesterday.year}-${yesterday.month.toString().length == 1 ? '0${yesterday.month}' : '${yesterday.month}'}-${yesterday.day.toString().length == 1 ? '0${yesterday.day}' :  '${yesterday.day}'}';

   BlocProvider.of<ExpenseBloc>(context).add(getExpenseEvent());
    BlocProvider.of<CatBloc>(context).add(GetCatEvent());
  }


  @override
  Widget build(BuildContext context) {

    isLight = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        body:BlocListener<CatBloc,CatState>(
          listener: (ctx, state) {
            if(state is CatLoadedState){
              arrCat = state.listCat;
            }

        },child: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12,top: 6,bottom: 2),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Expense_Page(),));
                      },
                      child: CircleAvatar(
                        backgroundColor: isLight ? Colors.black : Colors.white ,
                        child: Icon(Icons.add,color: isLight ? Colors.white : Colors.black,),
                      ),
                    ),
                  ),
                ) ),
            BlocBuilder<ExpenseBloc,ExpenseState>(
              builder:(ctx, state) {
                if (state is ExpenseLoadingState) {
                  return CircularProgressIndicator();
                }
                if (state is ExpenseLoadedState) {
                  arrExpenseData = state.listExpense.reversed.toList();
                  print(arrExpenseData.length);
                  if (arrExpenseData.isNotEmpty) {
                    filterExpenseDateWise();
                    return Expanded(
                        flex: 14,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 5,
                                child: totalBalanceUi()),
                            Expanded(
                                flex: 9,
                                child: ListView.builder(
                                  itemCount: arrDateWiseData.length,
                                  itemBuilder: (context, index) {
                                    return getAllTransactionDateWise(
                                        arrDateWiseData[index]);
                                  },)),
                          ],
                        ));
                  }
                  else {
                    return Expanded(
                      flex: 14,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No expenses yet',
                            style: mTextStyle24(mFWeight: FontWeight.bold),),

                          Text('start managing your expenses now',
                            style: mTextStyle12(),)
                        ],
                      ),
                    );
                  }
                }
                if (state is ExpenseErrorState) {
                  return Text('${state.errorMsg}');
                }
                return Container();
              }
             )
          ],
        ),),
      ),
    );
  }

  void filterExpenseDateWise(){

    var uniqueDate = [];
    arrDateWiseData.clear();

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

  }

  Widget getAllTransactionDateWise( Map<String , dynamic> dayWiseData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 8,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(dayWiseData['day'],style: mTextStyle12(mColor: Colors.grey),),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 6),
                      child: Text('\₹${dayWiseData['amt']}',style: mTextStyle12(mColor: Colors.grey),),
                    ),

                  ],
                ),),
              ],
            ),
          ),
         Row(

           children: [
             Expanded(child: Container()),
             Expanded(
               flex: 5,
               child: Container(
                 margin: EdgeInsets.only(right: 10),
               height: 1,
               width: double.infinity,
               color: Colors.grey,
             ),),
           ],
         ),
          mHeightSpacer(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:  (dayWiseData['Transcations']as List).length,
            itemBuilder: (ctx, index) {
            return getListOfAllTranscationAccToDate((dayWiseData['Transcations'][index]as Expense_Model));
          },)
        ],
      ),
    );
  }

  Widget getListOfAllTranscationAccToDate( Expense_Model dateWiseTransaction){

    var imgPath= "";
    for(var catModel in arrCat ){
      if(catModel.id == dateWiseTransaction.expense_cat){
        imgPath = catModel.path!;
        break;
      }
    }
    var isDebit = dateWiseTransaction.expense_type ==1;

    return Column(
      children: [

        ListTile(
          leading: Image.asset(imgPath,height: 40,width: 40,),
          title:Text('${ dateWiseTransaction.expense_title}',style: mTextStyle16(mFWeight: FontWeight.bold,mColor:mColorTheme() ),),
          subtitle: Text('${dateWiseTransaction.expense_desc}',style: mTextStyle12(mFWeight: FontWeight.w500,mColor: mColorTheme()),),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${isDebit?'-':'+'}\₹${dateWiseTransaction.expense_amount}',style: mTextStyle16(mFWeight: FontWeight.bold,mColor: dateWiseTransaction.expense_type == 1 ? Colors.red : Colors.green ),),
              Text('\₹${dateWiseTransaction.expense_balance}',style: mTextStyle12(mFWeight: FontWeight.w500,mColor: dateWiseTransaction.expense_type == 1 ? Colors.red : Colors.green ),)

            ],

          ),

        ),


      ],
    );
  }
  Color  mColorTheme(){
    return isLight ? Colors.black : Colors.white;
  }


  Widget totalBalanceUi(){
    CalculateTotalSpent();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Spent Till Now',style: mTextStyle12(mColor: isLight ? Colors.black : Colors.white), ),
        mHeightSpacer(),
        RichText(text: TextSpan(
          children: [
            TextSpan(
              text: '\₹ ',
              style: mTextStyle24(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '${TotalSpent!= 0.0 ? TotalSpent.toString().split('.')[0]: '000'}',
              style: mTextStyle43(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '.${TotalSpent!= 0.0 ? TotalSpent.toString().split('.')[1]: '00'}',
              style: mTextStyle24(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            )
          ]
        ))
      ],
    );
  }

  void CalculateTotalSpent (){
    TotalSpent =0.0;

    arrExpenseData.forEach((expense) {
      if(expense.expense_type == 1){
        TotalSpent -= expense.expense_amount!;
      }else{
        TotalSpent += expense.expense_amount!;
      }

    });
    print(TotalSpent);

  }

}
