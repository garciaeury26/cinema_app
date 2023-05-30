import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
    );
  }
}
