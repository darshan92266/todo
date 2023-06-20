part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

abstract class TodoActionState extends TodoState {}

class TodoInitial extends TodoState {

}

class TodoLoadingSuccessState extends TodoState {
  final List<Map> data;
  TodoLoadingSuccessState(this.data);
}


class HomeToInstertNavigateState extends TodoActionState {
  final Map? data;
  HomeToInstertNavigateState([this.data]);
}
