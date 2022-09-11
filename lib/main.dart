import 'package:flutter/material.dart';
import 'package:reverse_clocks/ui/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reverse Clocks',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MainPage(),
    );
  }
}
