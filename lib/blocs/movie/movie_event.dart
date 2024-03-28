part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class LoadMovies extends MovieEvent {}

class MovieSelected extends MovieEvent {
  final Movie movie;

  const MovieSelected(this.movie);

  @override
  List<Object> get props => [movie];
}

// Ajouter d'autres événements si nécessaire
