import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff2155CD),
          Color(0xff0AA1DD),
          Color(0xff79DAE8),
          Color(0xffE8F9FD),
          // Color(0xff42C2FF),
          // Color(0xff85F4FF),
          // Color(0xffB8FFF9),
          // Color(0xffEFFFFD),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: const FlareActor(
        'assets/loading_weather.flr',
        animation: 'loading',
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
    );
  }
}
