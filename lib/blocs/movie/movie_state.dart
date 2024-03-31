part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MoviesLoadInProgress extends MovieState {}

class MoviesLoadSuccess extends MovieState {
  final List<Movie> movies;

  const MoviesLoadSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesLoadFailure extends MovieState {
  final String errorMessage;

  const MoviesLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}


