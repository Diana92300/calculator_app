import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_controller.dart';
import 'calculator_screen.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => CalculatorController(),
    child: const CalculatorApp(),
  ),
);

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scientific Calculator',
      home: const CalculatorScreen(),
    );
  }
}
