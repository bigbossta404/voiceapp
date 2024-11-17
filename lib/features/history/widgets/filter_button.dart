import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterButton extends StatelessWidget {
  final int index;
  final String label;
  // final VoidCallback callBack;
  final Bloc historyBloc;

  const FilterButton({super.key, required this.index, required this.label, required this.historyBloc});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
