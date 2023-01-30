import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.pink,
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              color: Colors.pink,
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
