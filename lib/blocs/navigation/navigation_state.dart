import 'package:meta/meta.dart';

@immutable
abstract class NavigationState {}

class HomeNavigationState extends NavigationState {}

class ComicsListNavigationState extends NavigationState {}

class SeriesListNavigationState extends NavigationState {}

class MoviesListNavigationState extends NavigationState {}

class CharacterDetailsNavigationState extends NavigationState {}

class ComicDetailsNavigationState extends NavigationState {}

class SeriesDetailsNavigationState extends NavigationState {}

class MovieDetailsNavigationState extends NavigationState {}
