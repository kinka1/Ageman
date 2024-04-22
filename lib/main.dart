import 'package:flutter/material.dart';
import 'package:toko_baju/home_page.dart';
import 'package:toko_baju/widgets/bajupage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ageman',
      home: HomePage(),
    );
  }
}