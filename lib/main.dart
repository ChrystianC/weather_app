import 'package:flutter/material.dart';
import 'components/ForcastWheather.dart';
import 'components/TodayWheather.dart';
import 'components/WindForcastWeather.dart';
import 'components/WindWeather.dart';

class _MyPageViewState extends State<MyPageView> {
  late PageController _pageController = PageController();
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void login() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: !isPressed
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => login(),
                      child: Text(
                        'See wheater',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 209, 209, 209)),
                      ),
                    ),
                  ],
                )
              : PageView(
                  controller: _pageController,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TodayWheather(),
                        ElevatedButton(
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: const Text(
                              'See wheater forcast',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ForcastWheater(),
                        ElevatedButton(
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: const Text(
                              'See wind',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Wind(),
                        ElevatedButton(
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  3,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: const Text(
                              'See wind forcast',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ForecastWind(),
                        ElevatedButton(
                            onPressed: () {
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: const Text(
                              'See weather',
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

void main() {
  runApp(
    MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: MyPageView(),
    ),
  );
}
