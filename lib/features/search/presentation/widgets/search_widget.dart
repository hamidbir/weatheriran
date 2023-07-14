import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatheriran/core/utils/show_snackbar.dart';
import 'package:weatheriran/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:weatheriran/features/search/presentation/bloc/search_bloc.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: ((context, state) {
        if (state is LoadedCity) {
          BlocProvider.of<CurrentWeatherBloc>(context)
              .add(UpdatingWeatherWithGeo(state.city.lat, state.city.lon));
        }
        if (state is ErrorCity) {
          showSnackbar(
              context: context, content: state.message, color: Colors.red);
        }
      }),
      builder: (context, state) {
        if (state is EmptyCity) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.search,
                controller: controller,
                onSubmitted: (value) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchingCity(value));
                  controller.text = '';
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  iconColor: Colors.white,
                  hintText: 'Enter name city',
                  focusColor: Colors.blueGrey,
                  hintStyle: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        } else if (state is LoadingCity) {
          return const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: FlareActor(
                'assets/circle_loading_weather.flr',
                animation: 'loading',
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          );
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.search,
              controller: controller,
              onSubmitted: (value) {
                BlocProvider.of<SearchBloc>(context).add(SearchingCity(value));
                controller.text = '';
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search),
                iconColor: Colors.white,
                hintText: 'Enter name city',
                focusColor: Colors.blueGrey,
                hintStyle: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
