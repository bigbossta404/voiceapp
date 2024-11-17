part of 'history_bloc.dart';

abstract class HistoryState {}

class SelectedFilterState extends HistoryState {
  final int index;
  SelectedFilterState(this.index);
}

class LoadingGetData extends HistoryState {}

class LoadDataState extends HistoryState {
  final List<HistoryNoteModel> data;
  LoadDataState(this.data);
}
