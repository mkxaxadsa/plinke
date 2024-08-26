part of 'univer_bloc.dart';

abstract class UniverEvent {}

class GetUniversEvent extends UniverEvent {}

class AddUniverEvent extends UniverEvent {
  final University university;
  AddUniverEvent({required this.university});
}

class EditUniverEvent extends UniverEvent {
  final University university;
  EditUniverEvent({required this.university});
}

class DeleteUniverEvent extends UniverEvent {
  final int id;
  DeleteUniverEvent({required this.id});
}
