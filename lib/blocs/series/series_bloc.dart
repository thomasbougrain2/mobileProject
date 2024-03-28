import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/series.dart';
import '../../services/api_service.dart';

part 'series_event.dart';
part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final ApiService apiService;

  SeriesBloc(this.apiService) : super(SeriesInitial());

  @override
  Stream<SeriesState> mapEventToState(SeriesEvent event) async* {
    if (event is LoadSeries) {
      yield* _mapLoadSeriesToState();
    } else if (event is SeriesSelected) {
      yield SeriesLoadSuccess([event.series]);
    }
  }

  Stream<SeriesState> _mapLoadSeriesToState() async* {
    yield SeriesLoadInProgress();
    try {
      final series = await ApiService.fetchSeries();
      yield SeriesLoadSuccess(series);
    } catch (_) {
      yield SeriesLoadFailure('Failed to load series');
    }
  }
}
