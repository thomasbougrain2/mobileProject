// blocs/navigation/navigation_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../models/movie.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomeNavigationState());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigateToHomeEvent) {
      yield HomeNavigationState();
    } else if (event is NavigateToComicsListEvent) {
      yield ComicsListNavigationState();
    } else if (event is NavigateToSeriesListEvent) {
      yield SeriesListNavigationState();
    } else if (event is NavigateToMoviesListEvent) {
      yield MoviesListNavigationState();
    } else if (event is NavigateToCharacterDetailsEvent) {
      yield CharacterDetailsNavigationState();
    } else if (event is NavigateToMovieDetailsEvent) {
      yield MovieDetailsNavigationState(movie: event.movie);
    }
  }
}


