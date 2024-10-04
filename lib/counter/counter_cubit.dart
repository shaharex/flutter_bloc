/* 

CUBIT: Simplified version of BloC for easy state management

*/

import 'package:flutter_bloc/flutter_bloc.dart';

// every time we make a cubit we have to define the type
class CounterCubit extends Cubit<int> {
  // constructor
  CounterCubit(super.initialState);

  // increment
  void increment() => emit(state + 1);

  // decrement
  void decrement() => emit(state - 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);

    print(change);
  }
}
