import 'package:expense_proj/Constants/Constants.dart';
import 'package:expense_proj/provider/switch_theme_provider.dart';
import 'package:expense_proj/screens/add_expense/add_expense_page.dart';
import 'package:expense_proj/screens/home/bloc/expense/expense_bloc.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../database/models/expense_model.dart';

class Transcation_Page extends StatefulWidget {
  const Transcation_Page({super.key});

  @override
  State<Transcation_Page> createState() => _Transcation_PageState();
}

class _Transcation_PageState extends State<Transcation_Page> {
  var isLight;
  var dumyData = Constants.arrTranscations;

late  List<Expense_Model> arrExpenses ;
List<Map<String,dynamic>> arrDateWiseData = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExpenseBloc>(context).add(getExpenseEvent());
  }


  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        body:Column(
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
            BlocBuilder<ExpenseBloc,ExpenseState>(builder:(context, state) {

              if(state is ExpenseLoadingState){
                return CircularProgressIndicator();
              }else if (state is ExpenseLoadedState){
                arrExpenses = state.listExpense;
                if(arrExpenses.isNotEmpty){
                  filterExpenseDateWise();
                  return Expanded(
                      flex: 14,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 5,
                              child:totalBalanceUi() ),
                          Expanded(
                              flex : 9 ,
                              child:Container(

                                child: ListView.builder(
                                  itemCount: arrDateWiseData.length,
                                  itemBuilder: (context, index) {
                                    return  getAllTransactionDateWise(arrDateWiseData[index]);
                                  },),
                              ) ),
                        ],
                      ));
                }else{
                  return Expanded(
                    flex: 14,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No expenses yet',style: mTextStyle24(mFWeight: FontWeight.bold),),

                        Text('start managing your expenses now',style: mTextStyle12(),)
                      ],
                    ),
                  );
                }
              }else if (state is ExpenseErrorState){
                return Text("Error while adding your expense");
              }else{
                return Container();}
            }, )
          ],
        ),
      ),
    );
  }

  void filterExpenseDateWise(){

    var uniqueDate = [];
    arrDateWiseData.clear();

    for(Expense_Model model in arrExpenses){
      var eachDateFormat = DateTime.parse(model.expense_date!);

      var eachDate = '${eachDateFormat.year}-${eachDateFormat.month.toString().length == 1 ? '0${eachDateFormat.month}' : '${eachDateFormat.month}'}-${eachDateFormat.day.toString().length == 1 ? '0${eachDateFormat.day}' :  '${eachDateFormat.day}'}';

      if(!uniqueDate.contains(eachDate)){
        uniqueDate.add(eachDate);

      }

    }


    for(String eachDate in uniqueDate){
      List<Expense_Model> eachDateTransactions = arrExpenses.where((element) => element.expense_date!.contains(eachDate)).toList();
      Map<String,dynamic> eachDateMap = {};
      eachDateMap['day'] = '$eachDate';
      eachDateMap['amt'] = '1000';
      eachDateMap['Transcations'] = '$eachDateTransactions';
      arrDateWiseData.add(eachDateMap);
    }

  }

  Widget getAllTransactionDateWise(Map<String,dynamic> dayWiseData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 8,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dayWiseData['day'],style: mTextStyle12(mColor: Colors.grey),),
                  Text('\₹${dayWiseData['amt']}',style: mTextStyle12(mColor: Colors.grey),),

                ],
              ),),
            ],
          ),
         Row(

           children: [
             Expanded(child: Container()),
             Expanded(
               flex: 8,
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
            itemCount: (dayWiseData['Transcations']as List).length,
            itemBuilder: (context, index) {
            return getListOfAllTranscationAccToDate((dayWiseData['Transcations'][index]as Expense_Model));
          },)
        ],
      ),
    );
  }
  Widget getListOfAllTranscationAccToDate(Expense_Model dateWiseTransaction){
    return Column(
      children: [

        ListTile(
          leading: Image.asset('assets/expese_icons/bill.png',height: 35,width: 35,),
          title:Text('${ dateWiseTransaction.expense_title}',style: mTextStyle16(mFWeight: FontWeight.bold,mColor: mColorTheme()),),
          subtitle: Text('${dateWiseTransaction.expense_desc}',style: mTextStyle12(mFWeight: FontWeight.w500,mColor: mColorTheme()),),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\₹${dateWiseTransaction.expense_amount}',style: mTextStyle16(mFWeight: FontWeight.bold,mColor: mColorTheme()),),
              Text('\₹${dateWiseTransaction.expense_balance}',style: mTextStyle12(mFWeight: FontWeight.w500,mColor: mColorTheme()),)

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
              text: '584',
              style: mTextStyle43(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '\.40',
              style: mTextStyle24(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            )
          ]
        ))
      ],
    );
  }
}
