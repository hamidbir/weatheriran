part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class GeoCity extends SearchState {
  final double lat;
  final double lon;

  const GeoCity({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon];
}

class LoadingCity extends SearchState {}

class EmptyCity extends SearchState {}

class ErrorCity extends SearchState {
  final String message;

  const ErrorCity(this.message);
  @override
  List<Object> get props => [message];
}

class LoadedCity extends SearchState {
  final SearchCity city;

  const LoadedCity(this.city);

  @override
  List<Object> get props => [city];
}
