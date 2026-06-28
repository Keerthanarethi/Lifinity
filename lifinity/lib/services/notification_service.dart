import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel =
      AndroidNotificationChannel(
    'lifinity_channel',
    'Lifinity Notifications',
    description: 'Task reminder notifications',
    importance: Importance.max,
  );

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
    );

    tz.initializeTimeZones();

    final String currentTimeZone =
        await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(
      tz.getLocation(currentTimeZone),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
static Future<void> scheduleNotification({
  required int id,
  required String title,
  required String body,
  required DateTime scheduledDateTime,
}) async {

  print("scheduleNotification() called");
  print("ID: $id");
  print("Title: $title");
  print("Time: $scheduledDateTime");

  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'lifinity_channel',
    'Lifinity Notifications',
    channelDescription: 'Task reminder notifications',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(
      scheduledDateTime,
      tz.local,
    ),
    notificationDetails,
    androidScheduleMode:
        AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: null,
  );
}
  static Future<void> cancelNotification(
    int id,
  ) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}