part of 'univer_bloc.dart';

abstract class UniverState {}

class UniverInitial extends UniverState {}

class UniverLoadedState extends UniverState {
  final List<University> univers;
  UniverLoadedState({required this.univers});
}
