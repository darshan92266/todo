part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class TodoInitialEvent extends TodoEvent {}

class HomeToInstertNavigateEvent extends TodoEvent {
  final Map? data;

  HomeToInstertNavigateEvent([this.data]);
}

class SendNotification extends TodoEvent {
  String title;
  String body;

  SendNotification(this.title, this.body);
}

class DeleteTaskEvent extends TodoEvent{
  int id;

  DeleteTaskEvent(this.id);
}
