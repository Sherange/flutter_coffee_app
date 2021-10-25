import 'package:coffe_app_animations/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainCoffeeApp());
}

class MainCoffeeApp extends StatelessWidget {
  const MainCoffeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee App Animations',
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}
