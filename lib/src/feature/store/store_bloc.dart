import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../models/plant_model.dart';
import '../account/account_bloc.dart';
import '../account/user_local.dart';

part "store_state.dart";

class StoreBloc extends Cubit<StoreState> {
  StoreBloc() : super(const StoreState());

  final controller = PageController(initialPage: 0, keepPage: false);

  void onPageChanged(int index) =>
      emit(state.copyWith(currentPageIndex: index));

  void onArrowBack() => controller.previousPage(
      duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  void onArrowForward() => controller.nextPage(
      duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

  void add(BuildContext context, WPlant value) {
    var cancel = BotToast.showLoading();
    final blocAccount = GetIt.I<AccountBloc>();
    final user = blocAccount.state.user;

    final List<WPlant> items = [...(user.plants), value];
    if (state.userNotEmpty) {
      blocAccount.updateUser(user.copyWith(plants: items));
      BotToast.showText(text: "success");
    } else {
      BotToast.showText(text: "error");
    }
    cancel();
    Navigator.pop(context);
  }
}
