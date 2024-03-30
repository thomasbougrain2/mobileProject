import 'package:meta/meta.dart';
import '/models/movie.dart';


@immutable
abstract class NavigationState {}

class HomeNavigationState extends NavigationState {}

class ComicsListNavigationState extends NavigationState {}

class SeriesListNavigationState extends NavigationState {}

class MoviesListNavigationState extends NavigationState {}

class CharacterDetailsNavigationState extends NavigationState {}

class ComicDetailsNavigationState extends NavigationState {}

class SeriesDetailsNavigationState extends NavigationState {}

class MovieDetailsNavigationState extends NavigationState {
  final Movie movie;

  MovieDetailsNavigationState({required this.movie});

  @override
  List<Object> get props => [movie];
}
