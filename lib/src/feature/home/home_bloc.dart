import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "home_state.dart";

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState());
  final controller = PageController(initialPage: 0, keepPage: false);

  void onPageChanged(int index) =>
      emit(state.copyWith(currentPageIndex: index));
}
