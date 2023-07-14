part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class SearchingCity extends SearchEvent {
  final String name;

  const SearchingCity(this.name);

  @override
  List<Object> get props => [name];
}

class RefreshSearching extends SearchEvent {
  const RefreshSearching();

  @override
  List<Object> get props => [];
}
