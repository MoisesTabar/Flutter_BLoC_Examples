import 'package:flutter/material.dart';
import 'package:timer_bloc/src/bloc/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int _duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final _minutes = ((_duration / 60) % 60).floor().toString().padLeft(2, '0');
    final _seconds = (_duration % 60).floor().toString().padLeft(2, '0');

    return Text('$_minutes:$_seconds', style: Theme.of(context).textTheme.headline3);
  }
}

class TimerTextExtended extends StatelessWidget {
  const TimerTextExtended({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int _duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final _hour = (((_duration / 60) / 60) % 60).floor().toString().padLeft(2, '0');
    final _minutes = ((_duration / 60) % 60).floor().toString().padLeft(2, '0');
    final _seconds = (_duration % 60).floor().toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: [
            Text(_hour),
            const SizedBox(height: 20),
            const Text('Hours'),
          ],
        ),
        Column(
          children: [
            Text(_minutes),
            const SizedBox(height: 20),
            const Text('Minutes'),
          ],
        ),
        Column(
          children: [
            Text(_seconds),
            const SizedBox(height: 20),
            const Text('Seconds'),
          ],
        )
      ],
    );
  }
}