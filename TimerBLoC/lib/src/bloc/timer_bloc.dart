import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timer_bloc/src/services/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

// The first step to implement the BLoC is to set the initial state: 60 seconds
class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _kDuration = 6000;

  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  // We need to add the Ticker from the services directory as a dependency
  // Also we need to start to implement the event handlers
  TimerBloc({required Ticker ticker}): _ticker = ticker, super(const TimerInitial(_kDuration)){
    // With the [on] function we can start the first event passing it the helper function
    on<TimerStarted>(_onTimerStarted);
    on<TimerTicker>(_onTicking);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
  }
  
  // We always need to close the stream to avoid memory leaks
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit){
    // When the [TimerBloc] recieves a [TimerStarted] event it pushes a [TimerRunInProgress] state
    emit(TimerRunInProgress(event.duration));
    // If there was an open tickerSubscription we need to cancel it to deallocate memory
    _tickerSubscription?.cancel();
    // We listen to the [_ticker.ticker] stream function and with it we add a [TimerTicker] event
    _tickerSubscription = _ticker
        .ticker(seconds: event.duration)
        .listen((duration) => add(TimerTicker(duration: duration)));
  }

  void _onTicking(TimerTicker event, Emitter<TimerState> emit){
    // When the [TimerBloc] recieves a [TimerTicker] event it validates if the duration is 0
    // If the duration is 0 then it pushes a [TimerRunInProgress] state with the actual duration
    // If not it pushes the [TimerCompleteState]
    emit(event.duration > 0 ? TimerRunInProgress(event.duration) : const TimerComplete());
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit){
     // if the [state] of the [TimerBloc] is [TimerRunInProgress] we pause [_tickerSubscription]
     // Finally it pushes a [TimerRunPause] state with the duration the state had before the pause
     if(state is TimerRunInProgress) {
       _tickerSubscription?.pause();
       emit(TimerRunPause(state.duration));
     }
  }

  void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
    // if the [state] of the[TimerBloc] is [TimerRunPause] we resume [_tickerSubscription]
    // Finally it pushes a [TimerRunInProgress] state with the duration before it was paused
    if(state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit){
    // When the [TimerBloc] recieves a [TimerReset] event, it cancels the [_tickerSubscription]
    // Finally it pushes a [TimerInitial] state with the original duration
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_kDuration));
  }
}