import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_service.dart';

part 'notification_state.dart';

class NotificationBloc extends Cubit<NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    startListeningNotificationEvents();
    //pushNotification();
  }

  Future<void> startListeningNotificationEvents() async {
    NotificationService.listenToNotifications();
    NotificationService.receivedActionNotification();
  }

  Future<void> pushNotification() async {
    NotificationService.createNewPlantReminderNotification();
  }

  @override
  Future<void> close() {
    NotificationService.close();
    return super.close();
  }
}
