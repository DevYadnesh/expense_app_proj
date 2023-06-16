import 'package:expense_proj/screens/home/bloc/expense/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Satats_Graph_Page extends StatefulWidget {
  const Satats_Graph_Page({super.key});

  @override
  State<Satats_Graph_Page> createState() => _Satats_Graph_PageState();
}
var maxValue = 0;
List<Map<String,dynamic>> graphData =[
  {
    'month' : 'jan',
    'amt' : 6580,
  },
  {
    'month' : 'feb',
    'amt' : 5680,
  },
  {
    'month' : 'mar',
    'amt' : 10000,
  },
  {
    'month' : 'apr',
    'amt' : 9877,
  }
];

class _Satats_Graph_PageState extends State<Satats_Graph_Page> {
  @override
  void initState() {
    super.initState();
  /*  graphData.forEach((element) {
      if(element['amt']>maxValue){
        maxValue = element['amt'];
      }
    }); */
    BlocProvider.of<ExpenseBloc>(context).add(getExpensesMonthWise());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<ExpenseBloc,ExpenseState>(
        builder: (context, state) {

          if(state is ExpenseLoadingState){
            return Center(child: CircularProgressIndicator());
          }else if(state is ExpenseLoadedState){
            var arrData = state.listExpense;
            return  SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0,maximum: maxValue.toDouble(),interval: 1000),
              series: <ChartSeries<Map<String,dynamic>, String >>[
                ColumnSeries(
                    color: Colors.black,
                    dataSource:graphData ,
                    xValueMapper: (Map<String,dynamic> data,_)=> data['month'],
                    yValueMapper: (Map<String,dynamic> data,_)=> data['amt'])
              ],
            );
          }else {
            return  Container();}


      },)
    );
  }
}
