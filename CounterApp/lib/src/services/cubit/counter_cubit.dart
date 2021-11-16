import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // Add 1 to the current state which is 0
  void increment () => emit(state + 1);

  // Substract 1 to the current state
  void decrease () => emit(state - 1);
}