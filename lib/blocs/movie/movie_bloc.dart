import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/movie.dart';
import '../../services/api_service.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ApiService apiService;

  MovieBloc(this.apiService) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is LoadMovies) {
      yield* _mapLoadMoviesToState();
    } else if (event is MovieSelected) {
      yield MoviesLoadSuccess([event.movie]);
    }
  }

  Stream<MovieState> _mapLoadMoviesToState() async* {
    yield MoviesLoadInProgress();
    try {
      final movies = await ApiService.fetchMovies();  // Appel statique correct
      yield MoviesLoadSuccess(movies);
    } catch (_) {
      yield MoviesLoadFailure('Failed to load movies');
    }
  }
}
