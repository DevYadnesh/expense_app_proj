part of 'cat_bloc.dart';

@immutable
abstract class CatEvent {}

class AddCatEvent extends CatEvent{}
class GetCatEvent extends CatEvent{}
