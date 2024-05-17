import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherIcon extends StatelessWidget {
  final String description;
  String? windForce;
  WeatherIcon({
    super.key,
    required this.description,
    this.windForce,
  });
  @override
  Widget build(BuildContext context) {
      if (description.contains('rain')) {
        return Container(height: 300, width: 300, child: Lottie.asset('assets/rain.json'));
      } else if (description.contains('sunny')) {
        return Container(height: 300, width: 300, child: Lottie.asset('assets/sunny.json'));
      } else if (description.contains('windy')) {
        int wind = int.parse(windForce!.replaceAll(RegExp(r'[^0-9]'), ''));
        if (wind <= 10) {
          return Container(height: 300, width: 300, child: Lottie.asset('assets/wind.json'));
        } else if (wind >= 20) {
          return Container(height: 300, width: 300, child: Lottie.asset('assets/wind-+20km.json'));
        } else {
          return Container(height: 300, width: 300, child: Lottie.asset('assets/wind-20km.json'));
        }
      } else {
        return Container(height: 300, width: 300, child: Lottie.asset('assets/cloudy.json'));
      }
  }
}
