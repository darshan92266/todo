part of 'insert_bloc.dart';

@immutable
abstract class InsertEvent {}

class InsterDataEvent extends InsertEvent {
  String title;
  String date;
  String time;
  String status;

  InsterDataEvent(this.title, this.date, this.time, this.status);
}

class UpdateDataEvent extends InsertEvent {
  int id;
  String title;
  String date;
  String time;
  String status;

  UpdateDataEvent(this.id, this.title, this.date, this.time, this.status);
}

class InsertSuccessEvent extends InsertEvent {}

class InsertToHomeNavigate extends InsertEvent {}
