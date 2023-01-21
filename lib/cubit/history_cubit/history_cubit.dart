import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../service/local_history_service.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  void getHistory() async {
    emit(HistoryLoading());

    final response = LocalHistoryService.point;
    print("isi dari response HISTORY => ${response.length}");

    emit(HistorySucess(pointHistory: response));
  }
}
