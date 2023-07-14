import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatheriran/core/error/failure.dart';
import 'package:weatheriran/core/usecases/usecase.dart';
import 'package:weatheriran/features/search/domain/entities/search_city.dart';
import 'package:weatheriran/features/search/domain/usecases/get_geo_city.dart';

part 'search_event.dart';
part 'search_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NOFOUND_FAILURE_MESSAGE = 'There is not city in the world';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetGeoCity geoCity;
  SearchBloc(this.geoCity) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
    on<RefreshSearching>((event, emit) {
      emit(EmptyCity());
    });
    on<SearchingCity>((event, emit) async {
      emit(LoadingCity());
      final failureOrTrivia = await geoCity(SearchParams(event.name));
      failureOrTrivia.fold((failure) {
        emit(ErrorCity(_mapFailureToMessage(failure)));
      }, (city) {
        emit(LoadedCity(city));
      });
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case NoFoundFailure:
      return NOFOUND_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
