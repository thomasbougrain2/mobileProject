import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/character.dart';
import '../../services/api_service.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final ApiService apiService;

  CharacterBloc(this.apiService) : super(CharacterInitial());

  @override
  Stream<CharacterState> mapEventToState(CharacterEvent event) async* {
    if (event is LoadCharacters) {
      yield* _mapLoadCharactersToState();
    } else if (event is CharacterSelected) {
      yield CharactersLoadSuccess([event.character]);
    }
  }

  Stream<CharacterState> _mapLoadCharactersToState() async* {
    yield CharactersLoadInProgress();
    try {
      final characters = await ApiService.fetchCharacters();
      yield CharactersLoadSuccess(characters);
    } catch (_) {
      yield CharactersLoadFailure('Failed to load characters');
    }
  }
}
