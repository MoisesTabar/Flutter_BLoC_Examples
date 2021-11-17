part of 'timer_bloc.dart';

// All of the TimerStates extend the abstract base class TimerState which has a duration property.
// This is because no matter what state our TimerBloc is in, we want to know how much time is remaining.
// Additionally, TimerState extends Equatable to optimize our code by ensuring that our app does not trigger rebuilds if the same state occurs.

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration);

  @override
  String toString() => 'Initial Duration: $duration';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration) : super(duration);

  @override
  String toString() => 'Paused: $duration';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'In Progress: $duration';
}

class TimerComplete extends TimerState {
  const TimerComplete(): super(0);
}