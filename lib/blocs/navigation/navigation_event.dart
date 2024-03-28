import 'package:meta/meta.dart';

abstract class NavigationEvent {}

class NavigateToHomeEvent extends NavigationEvent {}

class NavigateToComicsListEvent extends NavigationEvent {}

class NavigateToSeriesListEvent extends NavigationEvent {}

class NavigateToMoviesListEvent extends NavigationEvent {}

class NavigateToCharacterDetailsEvent extends NavigationEvent {}

class NavigateToComicDetailsEvent extends NavigationEvent {}

class NavigateToSeriesDetailsEvent extends NavigationEvent {}

class NavigateToMovieDetailsEvent extends NavigationEvent {}
