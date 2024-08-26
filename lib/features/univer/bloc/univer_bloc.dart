import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/university.dart';
import '../../../core/utils.dart';

part 'univer_event.dart';
part 'univer_state.dart';

class UniverBloc extends Bloc<UniverEvent, UniverState> {
  List<University> _univers = [];

  UniverBloc() : super(UniverInitial()) {
    on<GetUniversEvent>((event, emit) async {
      if (modelsList.isEmpty) {
        _univers = await getModels();
        emit(UniverLoadedState(univers: _univers));
      } else {
        emit(UniverLoadedState(univers: _univers));
      }
    });

    on<AddUniverEvent>((event, emit) async {
      modelsList.add(event.university);
      _univers = await updateModels();
      emit(UniverLoadedState(univers: _univers));
    });

    on<EditUniverEvent>((event, emit) async {
      for (University university in modelsList) {
        if (university.id == event.university.id) {
          university.name = event.university.name;
          university.location = event.university.location;
          university.description = event.university.description;
          university.rate = event.university.rate;
          university.pros = event.university.pros;
          university.cons = event.university.cons;
          university.specialization = event.university.specialization;
          university.priority = event.university.priority;
          university.tuition = event.university.tuition;
          university.studyYears = event.university.studyYears;
        }
      }

      _univers = await updateModels();

      emit(UniverLoadedState(univers: _univers));
    });

    on<DeleteUniverEvent>((event, emit) async {
      modelsList.removeWhere((element) => element.id == event.id);
      _univers = await updateModels();
      emit(UniverLoadedState(univers: _univers));
    });
  }
}
