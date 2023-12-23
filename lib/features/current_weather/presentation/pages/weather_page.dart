import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatheriran/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:weatheriran/features/current_weather/presentation/widgets/widgets.dart';
import 'package:weatheriran/features/search/presentation/bloc/search_bloc.dart';
import 'package:weatheriran/features/search/presentation/widgets/search_widget.dart';
import 'package:weatheriran/injection_container.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff42C2FF),
              Color(0xff85F4FF),
              Color(0xffB8FFF9),
              Color(0xffEFFFFD),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: blocBody(context)),
    );
  }

  MultiBlocProvider blocBody(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CurrentWeatherBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchBloc>(),
        )
      ],
      child: const RefreshWeather(),
    );
  }
}

class WeatherControls extends StatefulWidget {
  const WeatherControls({super.key});

  @override
  State<WeatherControls> createState() => _WeatherControlsState();
}

class _WeatherControlsState extends State<WeatherControls> {
  final controller = TextEditingController();
  late String inputStr;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          dispatchWeather();
        },
        child: const Text('Update weather'));
  }

  void dispatchWeather() {
    controller.clear();
    BlocProvider.of<CurrentWeatherBloc>(context).add(UpdatingWeather());
  }
}

class RefreshWeather extends StatelessWidget {
  const RefreshWeather({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentWeatherBloc>(context).add(UpdatingWeatherWithLoc());
    return Scaffold(
      body: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          if (state is Empty) {
            return const MessageDisplay(message: 'Start searching');
          } else if (state is Loading) {
            return const LoadingWidget();
          } else if (state is Loaded) {
            return Stack(
              children: [
                WeatherDisplay(
                  weather: state.weather,
                ),
                const FlareActor(
                  'assets/loading_weather.flr',
                  animation: 'loaded',
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 8.0,
                      top: 78.0,
                    ),
                    child: SearchWidget(),
                  ),
                ),
              ],
            );
          } else if (state is Error) {
            return MessageDisplay(message: state.message);
          } else {
            return const FlareActor(
              'assets/loading_weather.flr',
              animation: 'loading',
              fit: BoxFit.fill,
              alignment: Alignment.center,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<CurrentWeatherBloc>(context)
              .add(UpdatingWeatherWithLoc());
          BlocProvider.of<SearchBloc>(context).add(const RefreshSearching());
        },
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}
