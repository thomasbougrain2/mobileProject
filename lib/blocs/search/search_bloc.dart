import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/api_service.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class DoSearchEvent extends SearchEvent {
  final String query;

  const DoSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitialState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchResultsState extends SearchState {
  final Map<String, List<Map<String, String>>> result;

  const SearchResultsState(this.result);

  @override
  List<Object> get props => [result];
}
class SearchErrorState extends SearchState {
  final String error;

  const SearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}



class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService apiService;

  SearchBloc(this.apiService) : super(SearchInitialState()) {
    on<DoSearchEvent>(_onPerformSearchEvent);
  }

  Future<void> _onPerformSearchEvent(
      DoSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadState());
    try {
      final comicFuture = apiService.searchComics(event.query);
      final serieFuture = apiService.searchSeries(event.query);
      final moviesFuture = apiService.searchMovies(event.query);
      final charactersFuture = apiService.searchCharacters(event.query);
      final comics = await comicFuture;
      final series = await serieFuture;
      final movies = await moviesFuture;
      final characters = await charactersFuture;

      Map<String, List<Map<String, String>>> searchResults = {
        'Comics': comics
            .map((comic) =>
        {'name': comic.title, 'imageUrl': comic.imageUrl})
            .toList(),

        'Series': series
            .map((serie) =>
        {'name': serie.title, 'imageUrl': serie.imageUrl})
            .toList(),

        'Movies': movies
            .map((movie) =>
        {'name': movie.title, 'imageUrl': movie.imageUrl})
            .toList(),

        'Characters': characters
            .map((character) =>
        {'name': character.name, 'imageUrl': character.imageUrl})
            .toList(),
      };

      emit(SearchResultsState(searchResults));
    } catch (e) {
      emit(SearchErrorState('Search failes: $e'));
    }
  }
}
