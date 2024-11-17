part of 'history_bloc.dart';

abstract class HistoryEvent {}

// Filter Button
class FilterBtnEvent extends HistoryEvent {
  final int index;
  FilterBtnEvent(this.index);
}

class LoadDataHistory extends HistoryEvent {}
