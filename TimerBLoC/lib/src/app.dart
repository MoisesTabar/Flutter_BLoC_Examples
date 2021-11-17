import 'package:flutter/material.dart';
import 'package:timer_bloc/src/views/timer_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: const TextTheme(
          headline3: TextStyle(
            color: Color(0xFF303030),
            fontWeight: FontWeight.w600,
            fontSize: 55.0
          ),
          bodyText1: TextStyle(
            color: Color(0xFF90A4AE),
            fontWeight: FontWeight.bold,
            fontSize: 18.5,
          ),
          bodyText2: TextStyle(
            color: Color(0xFF90A4AE),
            fontWeight: FontWeight.w300,
            fontSize: 18.5
          )
        )
      ),
      home: const TimerPage(),
    );
  }
}