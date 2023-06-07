part of 'cat_bloc.dart';

@immutable
abstract class CatState {}

class CatInitialState extends CatState {}
class CatLoadingState extends CatState {}
class CatLoadedState extends CatState {
  List<Expense_Type_Model> listCat;
  CatLoadedState({required this.listCat});
}
class CatErrorState extends CatState {
  String errorMsg;
  CatErrorState({required this.errorMsg});
}
