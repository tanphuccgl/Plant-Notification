import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:plant_notification/src/app.dart';

class NotificationService {
  static final AwesomeNotifications awesomeNotifications =
      AwesomeNotifications();
  static int get _id => DateTime.now().millisecondsSinceEpoch.remainder(100000);

  static void initial() {
    // close app and start
    awesomeNotifications.initialize(
      'resource://drawable/res_notification_app_icon',
      [
        NotificationChannel(
          channelKey: 'watering_channel',
          channelName: 'Watering Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: "fdas",
        ),
        NotificationChannel(
          channelKey: 'watering_channel',
          channelName: 'Watering Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: "fdas",
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: Colors.teal,
          locked: true,
          importance: NotificationImportance.High,
          channelDescription: "fdas",
        ),
      ],
    );
  }

  static Future<void> checkNotificationPermissions() async {
    bool isAllowed = await awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;
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
                        'assets/animated-bell.gif',
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

  static void listenToNotifications() {
    awesomeNotifications.createdStream.listen((notification) {
      // Xử lý thông báo được tạo mới ở đây
      BotToast.showText(text: "oke ");
    });
  }

  static void receivedActionNotification() {
    awesomeNotifications.actionStream.listen((notification) {
      BotToast.showText(text: "oke 1");
      //   if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
      //     AwesomeNotifications().getGlobalBadgeCounter().then(
      //           (value) =>
      //               AwesomeNotifications().setGlobalBadgeCounter(value - 1),
      //         );
      //   }

      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => PlantStatsPage(),
      //     ),
      //     (route) => route.isFirst,
      //   );
    });
  }

  static Future<void> createPlantFoodNotification() async {
    await checkNotificationPermissions();
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: _id,
        channelKey: 'basic_channel',
        title:
            '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
        body: 'Florist at 123 Main St. has 2 in stock',
        bigPicture: 'asset://assets/images/flutter_logo.png',
        notificationLayout: NotificationLayout.BigPicture,
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
}
