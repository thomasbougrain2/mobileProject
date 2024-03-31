part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharactersLoadInProgress extends CharacterState {}

class CharactersLoadSuccess extends CharacterState {
  final List<Character> characters;

  const CharactersLoadSuccess(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharactersLoadFailure extends CharacterState {
  final String errorMessage;

  const CharactersLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

