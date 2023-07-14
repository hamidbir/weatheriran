import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatheriran/features/current_weather/domain/entities/current_weather.dart';

class WeatherDisplay extends StatefulWidget {
  final CurrentWeather weather;
  const WeatherDisplay({super.key, required this.weather});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay>
    with TickerProviderStateMixin {
  late AnimationController controllerFade;
  late Animation<double> animationFade;
  late Animation<Offset> animationSlide;
  final List<String> cities = [
    'Birjand',
    'Tehran',
    'Bojnourd',
    'Mashhad',
    'Zahedan',
    'Ahvāz',
    'Arak',
    'Ardabil',
    'Bandar abbas',
    'Bushehr',
    'Isfahan',
    'Gorgan',
    'Hamadan',
    'Īlām',
    'Karaj',
    'Kerman',
    'Kermanshah',
    'Khorramabad',
    'Urmia',
    'Qazvin',
    'Qom',
    'Rasht',
    'Sanandij',
    'Sari',
    'Semnan',
    'Shahr-e Kord',
    'Shiraz',
    'Tabriz',
    'Yasuj',
    'Yazd',
    'Zanjān',
  ];

  @override
  void initState() {
    super.initState();
    controllerFade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationFade = CurvedAnimation(
      parent: controllerFade,
      curve: Curves.easeInBack,
    );
    animationSlide = Tween<Offset>(
            begin: const Offset(0.0, -0.5), end: const Offset(0.0, 0.0))
        .animate(controllerFade);

    controllerFade.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          changeSky(widget.weather.sys.sunrise, widget.weather.sys.sunset),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(cities.contains(widget.weather.name)
                            ? 'assets/images/${widget.weather.name}.png'
                            : 'assets/images/Birjand.png'),
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  FadeTransition(
                    opacity: animationFade,
                    child: Text(
                      '${(widget.weather.main.temp - 273.15).toInt()}°C',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 68),
                    ),
                  ),
                  FadeTransition(
                    opacity: animationFade,
                    child: Text(
                      widget.weather.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const Expanded(flex: 2, child: SizedBox()),
                  FadeTransition(
                    opacity: animationFade,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Text('${widget.weather.weather[0].description} ',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                          maxLines: 2,
                          textAlign: TextAlign.left),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SlideTransition(
                    position: animationSlide,
                    child: FadeTransition(
                      opacity: animationFade,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.water_drop_outlined,
                                size: 28,
                                color: Colors.white,
                              ),
                              Text(
                                ' ${widget.weather.main.humidity}%',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.visibility,
                                size: 28,
                                color: Colors.white,
                              ),
                              Text(
                                ' ${widget.weather.visibility}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.wind_power,
                                size: 28,
                                color: Colors.white,
                              ),
                              Text(
                                ' ${widget.weather.wind.speed}km/h',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(flex: 4, child: SizedBox()),
                ],
              )),
              // Placeholder(
              //     child: Expanded(child: selectAnimate(weather.weather[0].main))),
              // // const Expanded(child: Placeholder()),
              // Expanded(
              //   child: Text(
              //     weather.name,
              //     style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Expanded(
              //     child: Center(
              //   child: SingleChildScrollView(
              //     child: Text(
              //       weather.main.temp.toString(),
              //       style: const TextStyle(fontSize: 25),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // )),
            ],
          ),
          Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Align(
                alignment: Alignment.topCenter,
                child: selectAnimate(widget.weather.weather[0].main)),
          ),
        ],
      ),
    );
  }

  Widget changeSky(int sunrise, int sunset) {
    DateTime dateSunset = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    DateTime dateSunrise = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);

    // var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(date);

    // print('time: $time');
    // print('time1: ${time1.timeZoneName}');
    // print('time1: ${time1.timeZoneOffset}');

    // print('date: $date');
    // print('d24: $d24');

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: (DateTime.now().isBefore(dateSunset) &&
                      DateTime.now().isAfter(dateSunrise))
                  ? const [
                      Color(0xff2155CD),
                      Color(0xff0AA1DD),
                      Color(0xff79DAE8),
                      Color(0xffE8F9FD),
                      // Color(0xff42C2FF),
                      // Color(0xff85F4FF),
                      // Color(0xffB8FFF9),
                      // Color(0xffEFFFFD),
                    ]
                  : const [
                      Color(0xff0B2447),
                      Color(0xff19376D),
                      Color(0xff576CBC),
                      Color(0xffA5D7E8),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
    );
  }
}

Widget selectAnimate(String main) {
  switch (main) {
    case 'Clear':
      return const FlareActor(
        "assets/weather.flr",
        alignment: Alignment.center,
        fit: BoxFit.fill,
        animation: "clear",
      );
    case 'Thunderstorm':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "Thounderstorm");
    case 'Drizzle':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "drizzle");
    case 'Rain':
      return const FlareActor(
        "assets/weather.flr",
        alignment: Alignment.topCenter,
        fit: BoxFit.fill,
        animation: "rain",
      );
    case 'Snow':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "snow");
    case 'Mist':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "mist");
    case 'Smoke':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "dust");
    case 'Haze':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "dust");
    case 'Dust':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "dust");
    case 'Fog':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "dust");
    case 'Sand':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "dust");
    case 'Ash':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "mist");
    case 'Squall':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center, fit: BoxFit.contain, animation: "dust");
    case 'Tornado':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "tornado");
    case 'Clouds':
      return const FlareActor("assets/weather.flr",
          alignment: Alignment.topCenter,
          fit: BoxFit.contain,
          animation: "clouds");

    default:
      return Container(
        color: Colors.black,
      );
  }
}
