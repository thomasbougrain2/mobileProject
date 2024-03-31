part of 'comic_bloc.dart';

abstract class ComicEvent extends Equatable {
  const ComicEvent();

  @override
  List<Object> get props => [];
}

class LoadComics extends ComicEvent {}

class ComicSelected extends ComicEvent {
  final Comic comic;

  const ComicSelected(this.comic);

  @override
  List<Object> get props => [comic];
}

