import 'package:flutter/material.dart';
import 'package:timer_bloc/src/views/widgets/timer_buttons.dart';
import 'package:timer_bloc/src/views/widgets/timer_text.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        TimerText(),
        SizedBox(height: 110),
        TimerTextExtended(),
        SizedBox(height: 50),
        TimerButtons()
      ],
    );
  }
}