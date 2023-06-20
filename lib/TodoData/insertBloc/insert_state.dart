part of 'insert_bloc.dart';

@immutable
abstract class InsertState {}

abstract class InsertActionState extends InsertState{}

class InsertInitial extends InsertState {}

class InsertDataSucessState extends InsertState{}

class InsertedSucessState extends InsertActionState{}

class InsertToHomeNavigateState extends InsertActionState{}


