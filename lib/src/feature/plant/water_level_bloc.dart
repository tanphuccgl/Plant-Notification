import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plant_notification/src/feature/account/account_bloc.dart';
import 'package:plant_notification/src/feature/notification/notification_service.dart';
import 'package:plant_notification/src/models/plant_model.dart';

part 'water_level_state.dart';

class WaterLevelBloc extends Cubit<WaterLevelState> {
  final String idPlant;
  WaterLevelBloc(this.idPlant, super.initialState) {
    initial();
  }

  void initial() {
    double currentWaterLevel = state.waterLevel;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(waterLevel: state.waterLevel - 0.01));

      if (state.waterLevel <= 0) {
        timer.cancel();
      }
    });
    final blocAccount = GetIt.I<AccountBloc>();
    final user = blocAccount.state.user;
    int index = user.plants.indexWhere((e) => e.id == idPlant);

    List<WPlant> updatedList = List.from(user.plants);
    updatedList[index] =
        updatedList[index].copyWith(humidity: state.waterLevel);

// Sử dụng phương thức replaceRange để thay thế đối tượng cũ bằng đối tượng mới trong danh sách
    user.plants.replaceRange(index, index + 1, updatedList);

    blocAccount.updateUser(user.copyWith(plants: user.plants));
  }

  void onTapWater() {
    emit(state.copyWith(
        waterLevel: state.waterLevel > 0.8 ? 1 : state.waterLevel + 0.2));
    final blocAccount = GetIt.I<AccountBloc>();
    final user = blocAccount.state.user;
    int index = user.plants.indexWhere((e) => e.id == idPlant);

    List<WPlant> updatedList = List.from(user.plants);
    updatedList[index] =
        updatedList[index].copyWith(humidity: state.waterLevel + 0.2);

    user.plants.replaceRange(index, index + 1, updatedList);

    blocAccount.updateUser(user.copyWith(plants: user.plants));
    NotificationService.createPlantFoodNotification();
    user.plants.where((element) {
      print(element.humidity.toString());
      return true;
    });
  }
}
