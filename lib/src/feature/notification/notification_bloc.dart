import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_service.dart';

part 'notification_state.dart';

class NotificationBloc extends Cubit<NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    startListeningNotificationEvents();
  }

  Future<void> startListeningNotificationEvents() async {
    NotificationService.listenToNotifications();
    NotificationService.receivedActionNotification();
  }

  void onTapWater() {
    NotificationService.createPlantFoodNotification();
  }

  // Future<void> createWaterReminderNotification(
  //     NotificationWeekAndTime notificationSchedule) async {
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: state.id,
  //       channelKey: 'scheduled_channel',
  //       title: '${Emojis.wheater_droplet} Add some water to your plant!',
  //       body: 'Water your plant regularly to keep it healthy.',
  //       notificationLayout: NotificationLayout.Default,
  //     ),
  //     actionButtons: [
  //       NotificationActionButton(
  //         key: 'MARK_DONE',
  //         label: 'Mark Done',
  //       ),
  //     ],
  //     schedule: NotificationCalendar(
  //       weekday: notificationSchedule.dayOfTheWeek,
  //       hour: notificationSchedule.timeOfDay.hour,
  //       minute: notificationSchedule.timeOfDay.minute,
  //       second: 0,
  //       millisecond: 0,
  //       repeats: true,
  //     ),
  //   );
  // }

  @override
  Future<void> close() {
    NotificationService.close();
    return super.close();
  }
}
