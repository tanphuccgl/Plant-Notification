import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_notification/src/feature/store/store_page.dart';

part "home_state.dart";

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState());

  final controller = PageController(initialPage: 0, keepPage: false);

  void onPageChanged(int index) {
    emit(state.copyWith(currentPageIndex: index));
  }

  void onStore(BuildContext context) {
    Navigator.restorablePushNamed(context, StorePage.routeName);
  }

  void onArrowBack() {
    controller.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onArrowForward() {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
