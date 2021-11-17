import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/src/bloc/timer_bloc.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if(state is TimerInitial) _GradientFloatingActionButton(
              onPressed: () => context.read<TimerBloc>().add(TimerStarted(duration: state.duration)),
              icon: Icons.play_arrow,
            ),
            if(state is TimerRunInProgress) ...[
              _GradientFloatingActionButton(
                onPressed: () => context.read<TimerBloc>().add(const TimerPaused()),
                icon: Icons.pause
              ),
              _GradientFloatingActionButton(
                onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
                icon: Icons.replay
              )
            ],
            if(state is TimerRunPause) ...[
              _GradientFloatingActionButton(
                icon: Icons.play_arrow,
                onPressed: () => context.read<TimerBloc>().add(const TimerResumed()),
              ),
              _GradientFloatingActionButton(
                icon: Icons.replay,
                onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
              )
            ],
            if (state is TimerComplete) ...[
              _GradientFloatingActionButton(
                icon: Icons.replay,
                onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
              )
            ]
          ],
        );
      }
    );
  }
}

class _GradientFloatingActionButton extends StatelessWidget {
  const _GradientFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.icon
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFF90A4AE)
            ]
          )
        ),
        child: Icon(icon, color: const Color(0xFF546E7A)),
      ),
    );
  }
}