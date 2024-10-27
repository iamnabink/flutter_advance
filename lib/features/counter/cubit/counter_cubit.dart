import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    print("Increment CALLLED");
    emit(state + 1);
  }
  void decrement() => emit(state - 1);
}
