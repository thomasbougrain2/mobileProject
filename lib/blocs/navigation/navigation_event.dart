import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '/models/movie.dart';

abstract class NavigationEvent {}

class NavigateToHomeEvent extends NavigationEvent {}

class NavigateToComicsListEvent extends NavigationEvent {}

class NavigateToSeriesListEvent extends NavigationEvent {}

class NavigateToMoviesListEvent extends NavigationEvent {}

class NavigateToSearchScreenEvent extends NavigationEvent {}

class NavigateToComicDetailsEvent extends NavigationEvent {}

class NavigateToSeriesDetailsEvent extends NavigationEvent {}

class NavigateToMovieDetailsEvent extends NavigationEvent {
  final Movie movie;

  NavigateToMovieDetailsEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}