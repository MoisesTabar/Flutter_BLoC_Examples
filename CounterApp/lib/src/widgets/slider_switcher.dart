import 'package:counter_app/src/services/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderSwitcher extends StatelessWidget {
  const SliderSwitcher({Key? key}) : super(key: key);

  final Duration _kDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {

    final state = context.watch<CounterCubit>().state;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: const Color(0xFFFFFFFF),
        shape: const CircleBorder(),
        elevation: 5.0,
        child: Center(
          child: AnimatedSwitcher(
            duration: _kDuration,
            transitionBuilder: (child, animation) => ScaleTransition(
              child: child,
              scale: animation
            ),
            child: Text(
              '$state',
              key: const Key('counterCubit_button_key'),
              style: const TextStyle(
                color: Color(0xFF455A64),
                fontSize: 56.0
              )
            )
          )
        )
      ),
    );
  }
}