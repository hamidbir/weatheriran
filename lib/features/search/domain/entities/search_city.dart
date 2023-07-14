import 'package:equatable/equatable.dart';

class SearchCity extends Equatable {
  final double lat;
  final double lon;

  const SearchCity({required this.lat, required this.lon});
  @override
  List<Object?> get props => [lat, lon];
}
