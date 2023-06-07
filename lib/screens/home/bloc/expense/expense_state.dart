part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState{}

class ExpenseLoadedState extends ExpenseState{
  List<Expense_Model> listExpense;
  ExpenseLoadedState({required this.listExpense});

}

class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});

}

