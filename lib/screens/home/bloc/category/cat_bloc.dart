import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../database/models/expense_cat_model.dart';
import '../../repo/expense_repo.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  Expense_Repo repo;

  CatBloc({required this.repo}) : super(CatInitialState()) {
    on<AddCatEvent>((event, emit) {
      emit(CatLoadingState());



    });

    on<GetCatEvent>((event, emit)async {
      emit(CatLoadingState());
  var allCatData = await repo.getExpenseCat();
  emit(CatLoadedState(listCat: allCatData));
    });
  }
}
