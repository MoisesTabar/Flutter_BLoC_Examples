import 'package:counter_app/src/services/cubit/counter_cubit.dart';
import 'package:counter_app/src/widgets/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF263238),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, state) => const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CounterButton()
          )
        )
      )
    );
  }
}