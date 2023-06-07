import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_proj/database/models/expense_model.dart';
import 'package:meta/meta.dart';

import '../../repo/expense_repo.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  Expense_Repo repo;

  ExpenseBloc({required this.repo}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit)async {
      emit(ExpenseLoadingState());
    var check = await repo.addExpense(event.newExpense);
    if(check){
    var allExpenses =  await repo.getExpense();
    emit(ExpenseLoadedState(listExpense: allExpenses));
    }else{
      emit(ExpenseErrorState(errorMsg: 'Error while adding Expense'));
    }

    });

    on<getExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExpenses =  await repo.getExpense();
      emit(ExpenseLoadedState(listExpense: allExpenses));
    });
  }
}
