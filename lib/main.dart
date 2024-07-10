import 'package:flutter/material.dart';
import 'package:my_xogame/constants/colors.dart';
import 'package:my_xogame/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch:
              Colors.deepPurple, // Use primarySwatch to set primary colors
        ),
        scaffoldBackgroundColor:
            Colors.transparent, // Make scaffold background transparent
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true, // Extend body behind appbar
        body: Container(
          decoration: BoxDecoration(gradient: MainColor.bgGradient),
          child: MyHomePage(),
        ),
      ),
    );
  }
}
