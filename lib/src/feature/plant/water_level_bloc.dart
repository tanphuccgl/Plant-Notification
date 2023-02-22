import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plant_notification/src/feature/account/account_bloc.dart';
import 'package:plant_notification/src/feature/notification/notification_service.dart';

part 'water_level_state.dart';

class WaterLevelBloc extends Cubit<WaterLevelState> {
  final String idPlant;
  WaterLevelBloc(this.idPlant, super.initialState) {
    initial();
  }

  void initial() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(waterLevel: state.waterLevel - 0.01));

      if (state.waterLevel <= 0) {
        timer.cancel();
      }
    });

    GetIt.I<AccountBloc>().updatePlant(idPlant, state.waterLevel);
  }

  void onTapWater() {
    if (state.waterLevel <= 0) return;
    final double waterValue =
        state.waterLevel > 0.8 ? 1 : state.waterLevel + 0.2;
    emit(state.copyWith(waterLevel: waterValue));

    GetIt.I<AccountBloc>().updatePlant(idPlant, waterValue);
    NotificationService.createWateringPlantNotification();
  }

  void onTapScheduleWater() {
    if (state.waterLevel <= 0) return;
    final double waterValue =
        state.waterLevel > 0.9 ? 1 : state.waterLevel + 0.1;
    emit(state.copyWith(waterLevel: waterValue));

    GetIt.I<AccountBloc>().updatePlant(idPlant, waterValue);
    NotificationService.createScheduleWateringPlantNotification(
        (state.waterLevel.abs() * 100).toInt());
  }

  void pushNotificationLocal() {
    // final waterLevel = (state.waterLevel.abs() * 100).toInt();
    // switch (waterLevel) {
    //   case 10:
    //     NotificationService.createWaterReminderNotification(waterLevel);

    //     break;
    //   case 20:
    //     NotificationService.createWaterReminderNotification(waterLevel);

    //     break;
    //   case 30:
    //     NotificationService.createWaterReminderNotification(waterLevel);

    //     break;
    //   case 40:
    //     NotificationService.createWaterReminderNotification(waterLevel);

    //     break;
    //   case 50:
    //     NotificationService.createWaterReminderNotification(waterLevel);

    //     break;
    //   case 60:
    //     NotificationService.createStatePlantNotification(waterLevel);

    //     break;
    //   case 70:
    //     NotificationService.createStatePlantNotification(waterLevel);

    //     break;
    //   case 80:
    //     NotificationService.createStatePlantNotification(waterLevel);

    //     break;
    //   case 90:
    //     NotificationService.createStatePlantNotification(waterLevel);

    //     break;

    //   case 100:
    //     break;
    //   default:
    //     break;
    // }
  }
}
