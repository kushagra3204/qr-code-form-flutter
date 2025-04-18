import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final int counter;

  const CounterDisplay({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}