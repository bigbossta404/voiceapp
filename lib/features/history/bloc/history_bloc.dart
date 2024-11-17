import 'package:bloc/bloc.dart';
import 'package:dicoding_voiceapp/features/history/data/models/history_model.dart';
import 'package:dicoding_voiceapp/features/history/data/sources/source.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(SelectedFilterState(0)) {
    on<FilterBtnEvent>(
      (event, emit) async {
        emit(SelectedFilterState(event.index));
      },
    );

    on<LoadDataHistory>(
      (event, emit) async {
        emit(LoadingGetData());
        await Future.delayed(Duration(seconds: 2), () {
          final List<HistoryNoteModel> notes = HistorySources.notes.map((el) => HistoryNoteModel.fromMap(el)).toList();
          emit(LoadDataState(notes));
        });
      },
    );
  }
}
