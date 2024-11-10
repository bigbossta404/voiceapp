import 'package:dicoding_voiceapp/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_color.dart';

class FilterButton extends StatelessWidget {
  final int index;
  final String label;
  // final VoidCallback callBack;
  final Bloc homeBloc;

  const FilterButton({super.key, required this.index, required this.label, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
