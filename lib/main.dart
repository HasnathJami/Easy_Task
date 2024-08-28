import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Easy Task',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



