import 'package:dartz/dartz.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/search/domain/entities/search_city.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchCity>> getCity(SearchParams params);
}
