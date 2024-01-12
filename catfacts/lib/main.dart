import 'package:flutter/material.dart';
import "package:catfacts/Cat_Main.dart";

void main() {
  runApp(const CatFact());
}

class CatFact extends StatelessWidget {
  const CatFact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const Cat_Main(),
    );
  }
}
