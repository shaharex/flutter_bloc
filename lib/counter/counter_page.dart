/*

COUNTER PAGE: responsible for providing CounterCubit to CounterView (UI)

- use BloC Provider

*/

import 'package:bloc_learning/counter/counter_cubit.dart';
import 'package:bloc_learning/counter/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(0),
      child: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          // show pop up dialog when it reaches ten
          if (state == 10) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text('Congrats you reached 10'),
                );
              },
            );
          }
          if (state == 11) {
            context.read<CounterCubit>().close();
            print('cubit closed');
          }
        },
        child: const CounterView(),
      ),
    );
  }
}
