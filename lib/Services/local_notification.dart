import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart';
// import 'package:wally_the_stupid/Database/dataHandler.dart';
import 'package:wally_the_stupid/Views/Dashboard/dashbaord.dart';

class LocalNotification {
  LocalNotification._();

  static final instance = LocalNotification._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  static final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  Future initialize() async {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  display() {
    final location = getLocation('Asia/Kolkata');
    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Update',
      'Your Score updated',
      TZDateTime(
        location,
        TZDateTime.now(location).year,
        TZDateTime.now(location).month,
        TZDateTime.now(location).day + 2,
        9,
        30,
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'cid_1',
          'updateChannel',
          playSound: true,
          enableLights: true,
          enableVibration: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    await Get.to(
      () => DashBoardPage(
        index: 1,
      ),
    );
  }
}
