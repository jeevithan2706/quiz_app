import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_screen.dart';
import 'views/quiz_screen.dart';
import 'views/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () =>  HomeScreen()),
        GetPage(name: '/quiz', page: () => QuizScreen()),
        GetPage(name: '/results', page: () => ResultsScreen()),
      ],
    );
  }
}