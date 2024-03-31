part of 'character_bloc.dart';


abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharacterEvent {}

class CharacterSelected extends CharacterEvent {
  final Character character;

  const CharacterSelected(this.character);

  @override
  List<Object> get props => [character];
}


