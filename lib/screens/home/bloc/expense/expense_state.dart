part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState{}

class ExpenseLoadedState extends ExpenseState{
  List<Map<String,dynamic>> listExpense;
  ExpenseLoadedState({required this.listExpense});

}

class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});

}

