import 'package:weatheriran/core/error/exception.dart';
import 'package:weatheriran/core/network/network_info.dart';

import 'package:weatheriran/features/search/data/datasources/search_remote_data_source.dart';
import 'package:weatheriran/features/search/domain/entities/search_city.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weatheriran/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, SearchCity>> getCity(SearchParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather =
            await remoteDataSource.searchingCity(params.nameCity);
        print('remoteWeather: $remoteWeather');
        return Right(remoteWeather);
      } on ServerException {
        print('remoteWeather: null');

        return Left(ServerFailure());
      } on NotFoundException {
        print('no no ');
        return Left(NoFoundFailure());
      }
    } else {
      print('yesss');
      return Left(ServerFailure());
    }
  }
}
