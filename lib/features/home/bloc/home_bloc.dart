import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ChangePageEvent>((event, emit) {
      if (event.index == 0) {
        if (state is HomeInitial) return;
        emit(HomeInitial());
      } else if (event.index == 1) {
        if (state is HomeActivities) return;
        emit(HomeActivities());
      } else {
        if (state is HomeSettings) return;
        emit(HomeSettings());
      }
    });
  }
}
