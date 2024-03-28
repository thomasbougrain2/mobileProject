import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/comic.dart';
import '../../services/api_service.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final ApiService apiService;

  ComicBloc(this.apiService) : super(ComicInitial());

  @override
  Stream<ComicState> mapEventToState(ComicEvent event) async* {
    if (event is LoadComics) {
      yield* _mapLoadComicsToState();
    } else if (event is ComicSelected) {
      yield ComicsLoadSuccess([event.comic]);
    }
  }

  Stream<ComicState> _mapLoadComicsToState() async* {
    yield ComicsLoadInProgress();
    try {
      final comics = await ApiService.fetchComics();
      yield ComicsLoadSuccess(comics);
    } catch (_) {
      yield ComicsLoadFailure('Failed to load comics');
    }
  }
}
