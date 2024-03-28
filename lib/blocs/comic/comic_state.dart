part of 'comic_bloc.dart';

abstract class ComicState extends Equatable {
  const ComicState();

  @override
  List<Object> get props => [];
}

class ComicInitial extends ComicState {}

class ComicsLoadInProgress extends ComicState {}

class ComicsLoadSuccess extends ComicState {
  final List<Comic> comics;

  const ComicsLoadSuccess(this.comics);

  @override
  List<Object> get props => [comics];
}

class ComicsLoadFailure extends ComicState {
  final String errorMessage;

  const ComicsLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// Ajouter d'autres états si nécessaire
