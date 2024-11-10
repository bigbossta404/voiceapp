part of 'home_bloc.dart';

abstract class HomeState {}

class SelectedFilterState extends HomeState {
  final int index;
  SelectedFilterState(this.index);
}
