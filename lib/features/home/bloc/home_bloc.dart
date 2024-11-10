import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(SelectedFilterState(0)) {
    on<FilterBtnEvent>(
      (event, emit) async {
        emit(SelectedFilterState(event.index));
      },
    );
  }
}
