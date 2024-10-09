// ignore_for_file: unused_local_variable

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // Initialize the flutter local notifications instance
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(NotificationResponse notificationResponse) async{}

  // initialize the notification plugin
  static Future<void> init() async{
    // define the Android initialization settings
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    // define the IOS initialization settings
    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    // combine android and ios initialization settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings
    );

    // Initialize the plugin with the specified settings

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification
    );

    // request notification permission for android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  // show on instant Notification
  static Future<void> showInstantNotification(String title, String body) async{
    // Define notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_Id', 
        'channel_Name',
        importance: Importance.high,
        priority: Priority.high
      ),
      iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  // show a schedule notification
  static Future<void> scheduleNotification(String title, String body, DateTime scheduledDate) async{
    // Define notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_Id', 
        'channel_Name',
        importance: Importance.high,
        priority: Priority.high
      ),
      iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, 
      title, 
      body, 
      tz.TZDateTime.from(scheduledDate, tz.local), 
      platformChannelSpecifics, 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents:  DateTimeComponents.time
    );
  }
}