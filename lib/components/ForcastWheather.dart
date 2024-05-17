import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:weather_app/components/WeatherIcon.dart';
import 'package:http/http.dart' as http;

class WeatherAPIModel {
  final List<dynamic> Forecast;

  const WeatherAPIModel({
    required this.Forecast,
  });

  factory WeatherAPIModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "forecast": List<dynamic> forecast,
      } =>
        WeatherAPIModel(Forecast: forecast),
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

class _ForcastWheaterrState extends State<ForcastWheater> {
  late Future<WeatherAPIModel> futureWeather;
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherAPIModel>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10)),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherIcon(
                        description: 'rain',
                      ),
                      Text(
                        (DateFormat('EEEE').format(today.add(Duration(
                                days: int.parse(
                                    snapshot.data!.Forecast[0]['day'])))))
                            .toString(),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Text(
                        snapshot.data!.Forecast[0]['temperature']
                            .replaceAll(new RegExp('Â'), ''),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10)),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherIcon(
                        description: 'cloudy',
                      ),
                      Text(
                        (DateFormat('EEEE').format(today.add(Duration(
                                days: int.parse(
                                    snapshot.data!.Forecast[1]['day'])))))
                            .toString(),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Text(
                        snapshot.data!.Forecast[1]['temperature']
                            .replaceAll(new RegExp('Â'), ''),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10)),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherIcon(
                        description: 'sunny',
                      ),
                      Text(
                        (DateFormat('EEEE').format(today.add(Duration(
                                days: int.parse(
                                    snapshot.data!.Forecast[2]['day'])))))
                            .toString(),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Text(
                        snapshot.data!.Forecast[2]['temperature']
                            .replaceAll(new RegExp('Â'), ''),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text(
                   '${snapshot.error}',
                  style: TextStyle(
                      
                      color: Color.fromARGB(255, 209, 209, 209)),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherIcon(
                        description: 'rain',
                      ),
                      Text(
                        (DateFormat('EEEE')
                                .format(today.add(Duration(days: 1))))
                            .toString(),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Text(
                        '15 \u2103',
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherIcon(
                        description: 'cloudy',
                      ),
                      Text(
                        (DateFormat('EEEE')
                                .format(today.add(Duration(days: 3))))
                            .toString(),
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Text(
                        '15 \u2103',
                        style: TextStyle(
                            
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherIcon(
                        description: 'sunny',
                      ),
                      Text(
                        (DateFormat('EEEE')
                                .format(today.add(Duration(days: 2))))
                            .toString(),
                        style: TextStyle(  
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Text(
                        '15 \u2103',
                        style: TextStyle(  
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ],
                  ),
                ),
              ],
            );
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

class ForcastWheater extends StatefulWidget {
  const ForcastWheater({super.key});
  @override
  State<ForcastWheater> createState() => _ForcastWheaterrState();
}
