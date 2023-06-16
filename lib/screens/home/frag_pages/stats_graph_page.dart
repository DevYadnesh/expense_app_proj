import 'dart:ffi';
import 'dart:math';

import 'package:expense_proj/screens/home/bloc/expense/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Constants/Constants.dart';
import '../../../database/models/expense_cat_model.dart';
import '../../../database/models/expense_model.dart';
import '../../../ui_helper.dart';
import '../bloc/category/cat_bloc.dart';

class Satats_Graph_Page extends StatefulWidget {
  const Satats_Graph_Page({super.key});

  @override
  State<Satats_Graph_Page> createState() => _Satats_Graph_PageState();
}
var maxValue = 0.0;

 List<Map<String,dynamic>> arrGraphData = [];

class _Satats_Graph_PageState extends State<Satats_Graph_Page> {

  var isLight;
  var TotalSpent = 0.0;
  var dummyData = Constants.arrTranscations;





  List<Expense_Model> arrExpenseData = [];

  List<Category_Model> arrCat = [];
  List<Map<String,dynamic>> arrDateWiseData = [];

  late DateTime date;
  late String TodayDate;
  late String YestardayDate;
  @override
  void initState() {
    super.initState();

    arrGraphData.forEach((element) {
      var amt = 0.0;

      if(double.parse(element['amt']).isNegative){
        amt = double.parse(element['amt'])*-1;
      }else{
        amt = double.parse(element['amt']);
      }
      if(amt > maxValue){
       maxValue = amt;
      }


    });
    BlocProvider.of<ExpenseBloc>(context).add(getDayWiseExpensesEvent());
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
          children:[
            Expanded(
              child: BlocBuilder<ExpenseBloc,ExpenseState>(
                builder: (context, state) {

                  if(state is ExpenseLoadingState){
                    return Center(child: CircularProgressIndicator());
                  }else if(state is ExpenseLoadedState){
                    arrGraphData= state.listExpense;
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(minimum: 0,maximum: maxValue.toDouble(),interval: 100),
                        series: <ChartSeries<Map<String,dynamic>, String >>[
                          ColumnSeries(
                              color: Colors.black,
                              width: 0.08,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              animationDelay:4 ,


                              dataSource:arrGraphData ,
                              xValueMapper: (Map<String,dynamic> data,_)=>data['day'],
                              yValueMapper: (Map<String,dynamic> data,_)=> double.parse(data['amt']) )
                        ],
                      ),
                    );
                  }else {
                    return  Container();}


                },),
            ),
            Expanded(child: Container())
           
        ])
      ),


    );

  }
  
}
