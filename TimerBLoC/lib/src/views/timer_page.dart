import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/src/bloc/timer_bloc.dart';
import 'package:timer_bloc/src/services/ticker.dart';
import 'package:timer_bloc/src/views/timer_view.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => TimerBloc(ticker: const Ticker()),
          child: const TimerView()
        ),
      ),
    );
  }
}
