import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weatheriran/core/error/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchParams extends Equatable {
  final String nameCity;

  const SearchParams(this.nameCity);
  @override
  List<Object?> get props => [nameCity];
}

class CityParams extends Equatable {
  final double lat;
  final double lon;

  const CityParams(this.lat, this.lon);

  @override
  List<Object?> get props => [lat, lon];
}
