// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySucess extends HistoryState {
  List pointHistory;
  HistorySucess({
    required this.pointHistory,
  });
}
