import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/NotificationService/Notificationservice.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  static Database? database;
  List<Map>? data;
  NotificationService notificationService = NotificationService();

  TodoBloc() : super(TodoInitial()) {
    on<TodoInitialEvent>(todoInitialEvent);
    on<HomeToInstertNavigateEvent>(homeToInstertNavigateEvent);
    on<SendNotification>(sendNotification);
    on<DeleteTaskEvent>(deleteTaskEvent);
  }

  Future<FutureOr<void>> todoInitialEvent(
      TodoInitialEvent event, Emitter<TodoState> emit) async {
    notificationService.initializationNotification();

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, time TEXT,status TEXT)');
    });

    String qur = "select * from tasks";
    await database!.rawQuery(qur).then((value) {
      data = value;
    });
    emit(TodoLoadingSuccessState(data!));
  }

  FutureOr<void> homeToInstertNavigateEvent(
      HomeToInstertNavigateEvent event, Emitter<TodoState> emit) {
    print("Button Clicked");
    if (event.data != null)
      emit(HomeToInstertNavigateState(event.data));
    else
      emit(HomeToInstertNavigateState());
  }

  FutureOr<void> sendNotification(
      SendNotification event, Emitter<TodoState> emit) {
    notificationService.sendNotification(event.title, event.body);
  }

  Future<FutureOr<void>> deleteTaskEvent(
      DeleteTaskEvent event, Emitter<TodoState> emit) async {
    String qur = "delete from tasks where id=${event.id}";

    await database!.rawDelete(qur);
  }
}
