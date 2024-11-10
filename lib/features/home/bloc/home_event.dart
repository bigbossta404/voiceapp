part of 'home_bloc.dart';

abstract class HomeEvent {}

// Filter Button
class FilterBtnEvent extends HomeEvent {
  final int index;
  FilterBtnEvent(this.index);
}
