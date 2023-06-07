part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  Expense_Model newExpense;
  AddExpenseEvent({required this.newExpense});
}

class getExpenseEvent extends ExpenseEvent{}
