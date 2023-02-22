import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:plant_notification/src/app.dart';
import 'package:plant_notification/src/feature/store/store_page.dart';

class NotificationService {
  static final AwesomeNotifications awesomeNotifications =
      AwesomeNotifications();
  static int get _id => DateTime.now().millisecondsSinceEpoch.remainder(100000);

  static void initial() {
    // close app and start
    awesomeNotifications
        .initialize('resource://drawable/res_notification_app_icon', [
      NotificationChannel(
        channelGroupKey: "water",
        channelKey: 'watering_channel',
        channelName: 'Watering Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: "Notification when watering",
      ),
      NotificationChannel(
        channelGroupKey: "water",
        channelKey: 'schedule_watering_channel',
        channelName: 'Schedule Watering Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: "Schedule watering for plants",
      ),
      NotificationChannel(
        channelGroupKey: "plant",
        channelKey: 'schedule_state_plant_channel',
        channelName: 'Schedule Watering Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: "The current state of the tree",
      ),
      NotificationChannel(
        channelGroupKey: "plant",
        channelKey: 'schedule_plant_watering_channel',
        channelName: 'Schedule Plant Watering Notifications',
        defaultColor: Colors.blueAccent,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: "Plants need to be watered",
      ),
      NotificationChannel(
        channelGroupKey: "store",
        channelKey: 'new_plant_channel',
        channelName: 'New Plant Notifications',
        defaultColor: Colors.red,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: "Announcement of new plants in the shop",
      ),
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: 'water', channelGroupName: 'Watering Announcement'),
          NotificationChannelGroup(
          channelGroupkey: 'plant', channelGroupName: 'Plant Announcement'),
          NotificationChannelGroup(
          channelGroupkey: 'store', channelGroupName: 'Store Announcement')
    ]);
  }

  static Future<void> checkNotificationPermissions() async {
    bool isAllowed = await awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;
  }

  static void listenToNotifications() {
    awesomeNotifications.createdStream.listen((notification) {
      BotToast.showText(text: 'channelKey: ${notification.channelKey}');
    });
  }

  static void receivedActionNotification() {
    awesomeNotifications.actionStream.listen((notification) {
      BotToast.showText(text: 'channelKey: ${notification.channelKey}');
      if (notification.channelKey == 'new_plant_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }
      Navigator.restorablePushNamed(
          MyApp.navigatorKey.currentContext!, StorePage.routeName);
    });
  }

  static Future<void> createWateringPlantNotification() async {
    await checkNotificationPermissions();
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        groupKey: 'water',
        id: _id,
        channelKey: 'watering_channel',
        title:
            '${Emojis.icon_sweat_droplets + Emojis.plant_seedling} Vừa nước nước đó à',
      ),
    );
  }

  static Future<void> createScheduleWateringPlantNotification(int value) async {
    await checkNotificationPermissions();
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        groupKey: 'water',
        id: _id,
        channelKey: 'schedule_watering_channel',
        title:
            '${Emojis.icon_sweat_droplets + Emojis.plant_seedling} Tưới nước thành công',
        body: 'Hiện tại, độ ẩm của Cây xanh là $value%',
      ),
      schedule: NotificationCalendar(
        weekday: DateTime.now().weekday,
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
        second: DateTime.now().second + 10,
        millisecond: DateTime.now().millisecond,
        repeats: true,
      ),
    );
  }

  static Future<void> createStatePlantNotification(int value) async {
    await checkNotificationPermissions();
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        groupKey: 'plant',
        id: _id,
        channelKey: 'schedule_state_plant_channel',
        title: '${Emojis.icon_sweat_droplets + Emojis.plant_seedling} Độ ẩm',
        body: 'Hiện tại, độ ẩm của Cây xanh là $value%',
      ),
    );
  }

  static Future<void> createWaterReminderNotification(int value) async {
    await checkNotificationPermissions();
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        groupKey: 'plant',
        id: _id,
        channelKey: 'schedule_plant_watering_channel',
        title: '${Emojis.icon_sweat_droplets + Emojis.plant_seedling} Độ ẩm',
        body:
            'Độ ẩm giảm xuống $value%. Cây xanh sẽ cần được tưới nước. Vui lòng tiếp tục quan tâm đến sức khỏe của Cây xanh.',
        bigPicture: 'asset://assets/images/flutter_logo.png',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  static Future<void> createNewPlantReminderNotification() async {
    await checkNotificationPermissions();
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        groupKey: 'store',
        id: _id,
        channelKey: 'new_plant_channel',
        title:
            '${Emojis.symbols_new_button + Emojis.plant_seedling} Có cây mới',
        body: 'Đã có cây xanh mới. Vào cửa hàng ngay!',
        bigPicture: 'asset://assets/images/flutter_logo.png',
        notificationLayout: NotificationLayout.BigPicture,
         
      ),
      schedule: NotificationCalendar(
        weekday: DateTime.now().weekday,
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
        second: DateTime.now().second + 5,
        millisecond: DateTime.now().millisecond,
        repeats: false,
      ),
    );
  }

  Future<void> cancelScheduledNotifications() async {
    await awesomeNotifications.cancelAllSchedules();
  }

  static void close() {
    awesomeNotifications.actionSink.close();
    awesomeNotifications.createdSink.close();
  }

  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/gifs/bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}
