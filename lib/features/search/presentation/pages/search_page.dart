// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weatheriran/features/current_weather/presentation/widgets/widgets.dart';
// import 'package:weatheriran/features/search/presentation/bloc/search_bloc.dart';
// import 'package:weatheriran/injection_container.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<SearchBloc>(),
//       child: const RefreshWeather(),
//     );
//   }
// }

// class RefreshWeather extends StatelessWidget {
//   const RefreshWeather({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<SearchBloc, SearchState>(
//         builder: (context, state) {
//           if (state is EmptyCity) {
//             return const MessageDisplay(message: 'Start searching');
//           } else if (state is LoadingCity) {
//             return const LoadingWidget();
//           } else if (state is LoadedCity) {
//             return const Placeholder();
//           } else if (state is ErrorCity) {
//             return MessageDisplay(message: state.message);
//           } else {
//             return const FlareActor(
//               'assets/loading_weather.flr',
//               animation: 'loading',
//               fit: BoxFit.fill,
//               alignment: Alignment.center,
//             );
//           }
//         },
//       ),
//     );
//   }
// }
