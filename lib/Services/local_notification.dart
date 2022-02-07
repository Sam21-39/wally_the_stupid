import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
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

  display() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Update',
      'LeaderBoard updated',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'cid_1',
          'updateChannel',
          playSound: true,
        ),
      ),
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
