import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/WeatherIcon.dart';
import 'package:http/http.dart' as http;

class WindForcastAPIModel {
  final List<dynamic> windForcast;

  const WindForcastAPIModel({
    required this.windForcast,
  });

  factory WindForcastAPIModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "forecast": List<dynamic> windForcast,
      } =>
        WindForcastAPIModel(windForcast: windForcast),
      _ => throw const FormatException('Failed to load weather'),
    };
  }
}

Future<WindForcastAPIModel> fetchWindForecast() async {
  final response = await http
      .get(Uri.parse('https://goweather.herokuapp.com/weather/Warsaw'));
  if (response.statusCode == 200) {
    return WindForcastAPIModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Wheater');
  }
}

class _ForecastWind extends State<ForecastWind> {
  late Future<WindForcastAPIModel> futureWind;
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WindForcastAPIModel>(
        future: futureWind,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      (DateFormat('EEEE').format(today.add(Duration(
                              days: int.parse(
                                  snapshot.data!.windForcast[0]['day'])))))
                          .toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 209, 209, 209)),
                    ),
                    WeatherIcon(description: 'windy', windForce: snapshot.data!.windForcast[0]['wind']),
                    Text(
                      snapshot.data!.windForcast[0]['wind'],
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                 Column(
                   children: [
                     Text(
                       (DateFormat('EEEE').format(today.add(Duration(
                               days: int.parse(
                                   snapshot.data!.windForcast[1]['day'])))))
                           .toString(),
                       style: TextStyle(
                           color: Color.fromARGB(255, 209, 209, 209)),
                     ),
                     WeatherIcon(description: 'windy', windForce: snapshot.data!.windForcast[1]['wind'],),
                     Text(
                       snapshot.data!.windForcast[1]['wind'],
                       style: TextStyle(color: Colors.white),
                     )
                   ],
                 ),
                Padding(padding: EdgeInsets.only(left: 20)),
                  Column(
                    children: [
                      Text(
                        (DateFormat('EEEE').format(today.add(Duration(
                                days: int.parse(
                                    snapshot.data!.windForcast[2]['day'])))))
                            .toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                      WeatherIcon(description: 'windy', windForce: snapshot.data!.windForcast[2]['wind']),
                      Text(
                        snapshot.data!.windForcast[2]['wind'],
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text( '${snapshot.error}',
                style: TextStyle( color: Colors.white));
          }
          return const CircularProgressIndicator();
        });
  }

  @override
  void initState() {
    super.initState();
    futureWind = fetchWindForecast();
  }
}

class ForecastWind extends StatefulWidget {
  const ForecastWind({super.key});
  @override
  State<ForecastWind> createState() => _ForecastWind();
}
