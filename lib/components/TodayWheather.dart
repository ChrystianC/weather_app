import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/components/WeatherIcon.dart';
import 'package:http/http.dart' as http;

class WeatherAPIModel {
  final String temperature;
  final String description;

  const WeatherAPIModel({
    required this.temperature,
    required this.description,
  });

  factory WeatherAPIModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "temperature": String temperature,
        "description": String description,
      } =>
        WeatherAPIModel(temperature: temperature, description: description),
      _ => throw const FormatException('Failed to load weather'),
    };
  }
}

Future<WeatherAPIModel> fetchWeather() async {
  final response = await http
      .get(Uri.parse('https://goweather.herokuapp.com/weather/Warsaw'));
  if (response.statusCode == 200) {
    return WeatherAPIModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Wheater');
  }
}

class _TodayWheatherState extends State<TodayWheather> {
  late Future<WeatherAPIModel> futureWeather;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherAPIModel>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Warsaw',
                    style: TextStyle(
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                  WeatherIcon(description: snapshot.data!.description),
                  Text(
                    snapshot.data!.temperature
                        .replaceAll(new RegExp('Â'), ''),
                    style: const TextStyle(
                        
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                  Text(
                    snapshot.data!.description,
                    style: const TextStyle(
                        
                        color: Color.fromARGB(255, 209, 209, 209)),
                  )
                ]);
          } else if (snapshot.hasError) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${snapshot.error}',
                    style: const TextStyle(
                       
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                  WeatherIcon(description: 'rain'),
                  const Text(
                    '14 \u2103',
                    style: TextStyle(
                        
                        color: Color.fromARGB(255, 209, 209, 209)),
                  ),
                  const Text(
                    'Raining',
                    style: TextStyle(
                        
                        color: Color.fromARGB(255, 209, 209, 209)),
                  )
                ]);
          }
          return const CircularProgressIndicator();
        });
  }

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }
}

class TodayWheather extends StatefulWidget {
  const TodayWheather({super.key});
  @override
  State<TodayWheather> createState() => _TodayWheatherState();
}
