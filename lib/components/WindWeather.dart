import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/components/WeatherIcon.dart';
import 'package:http/http.dart' as http;

class WindAPIModel {
  final String wind;

  const WindAPIModel({
    required this.wind,
  });

  factory WindAPIModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "wind": String wind,
      } =>
        WindAPIModel(wind: wind),
      _ => throw const FormatException('Failed to load weather'),
    };
  }
}

Future<WindAPIModel> fetchWind() async {
  final response = await http
      .get(Uri.parse('https://goweather.herokuapp.com/weather/Warsaw'));
  if (response.statusCode == 200) {
    return WindAPIModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Wheater');
  }
}

class _Wind extends State<Wind> {
  late Future<WindAPIModel> futureWind;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WindAPIModel>(
        future: futureWind,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Warsaw',
                    style: TextStyle(
                        
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                  WeatherIcon(description: 'windy', windForce: snapshot.data!.wind ),
                  Text(
                    snapshot.data!.wind.replaceAll(new RegExp('Â'), ''),
                    style: TextStyle(
                        
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                ]);
          } else if (snapshot.hasError) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${snapshot.error}'),
                  Text(
                    'Warsaw',
                    style: TextStyle(
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                  WeatherIcon(description: 'windy', windForce: '30'),
                  Text(
                    '18 Km/h',
                    style: TextStyle(
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                ]);
          }
          return const CircularProgressIndicator();
        });
  }

  @override
  void initState() {
    super.initState();
    futureWind = fetchWind();
  }
}

class Wind extends StatefulWidget {
  const Wind({super.key});
  @override
  State<Wind> createState() => _Wind();
}
