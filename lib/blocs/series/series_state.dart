part of 'series_bloc.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();

  @override
  List<Object> get props => [];
}

class SeriesInitial extends SeriesState {}

class SeriesLoadInProgress extends SeriesState {}

class SeriesLoadSuccess extends SeriesState {
  final List<Series> series;

  const SeriesLoadSuccess(this.series);

  @override
  List<Object> get props => [series];
}

class SeriesLoadFailure extends SeriesState {
  final String errorMessage;

  const SeriesLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

