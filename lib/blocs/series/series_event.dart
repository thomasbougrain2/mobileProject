part of 'series_bloc.dart';

abstract class SeriesEvent extends Equatable {
  const SeriesEvent();

  @override
  List<Object> get props => [];
}

class LoadSeries extends SeriesEvent {}

class SeriesSelected extends SeriesEvent {
  final Series series;

  const SeriesSelected(this.series);

  @override
  List<Object> get props => [series];
}
