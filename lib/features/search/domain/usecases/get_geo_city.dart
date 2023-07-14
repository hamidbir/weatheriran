import 'package:weatheriran/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/search/domain/entities/search_city.dart';
import 'package:weatheriran/features/search/domain/repositories/search_repository.dart';

class GetGeoCity extends Usecase<SearchCity, SearchParams> {
  final SearchRepository repository;

  GetGeoCity(this.repository);
  @override
  Future<Either<Failure, SearchCity>> call(SearchParams params) async {
    return await repository.getCity(params);
  }
}
