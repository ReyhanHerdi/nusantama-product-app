import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MaterialApp(
            title: 'Product App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 255, 207)),
              ),
            home: HomeScreen()
          )
        ),
      ),
    );
  }
}
