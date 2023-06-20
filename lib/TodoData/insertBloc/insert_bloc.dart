import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/TodoData/todobloc/todo_bloc.dart';

part 'insert_event.dart';

part 'insert_state.dart';

class InsertBloc extends Bloc<InsertEvent, InsertState> {
  InsertBloc() : super(InsertInitial()) {
    on<InsterDataEvent>(insterDataEvent);
    on<InsertToHomeNavigate>(insertToHomeNavigate);
    on<UpdateDataEvent>(updateDataEvent);
  }

  FutureOr<void> insterDataEvent(
      InsterDataEvent event, Emitter<InsertState> emit) {
    String qur =
        "INSERT INTO tasks VALUES(NULL,'${event.title}','${event.date}','${event.time}','${event.status}')";

    TodoBloc.database!.rawInsert(qur).then((value) {});
    emit(InsertedSucessState());
  }

  FutureOr<void> insertToHomeNavigate(
      InsertToHomeNavigate event, Emitter<InsertState> emit) {
    emit(InsertToHomeNavigateState());
  }

  FutureOr<void> updateDataEvent(
      UpdateDataEvent event, Emitter<InsertState> emit) {
    String qur =
        "UPDATE tasks SET `title`='${event.title}',`date`='${event.date}',`time`='${event.time}',`status`='${event.status}' where id ='${event.id}'";
    TodoBloc.database!.rawUpdate(qur);
    emit(InsertedSucessState());
  }
}
