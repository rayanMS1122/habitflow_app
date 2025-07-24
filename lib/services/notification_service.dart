// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/foundation.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notifications =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     const initializationSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );

//     await _notifications.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onNotificationTapped,
//     );
//   }

//   static Future<bool> requestPermissions() async {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//       return await androidPlugin?.requestPermission() ?? false;
//     } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//       final iosPlugin = _notifications.resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>();
//       return await iosPlugin?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       ) ?? false;
//     }
//     return false;
//   }

//   static Future<void> scheduleHabitReminder({
//     required int id,
//     required String habitName,
//     required DateTime scheduledTime,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'habit_reminders',
//       'Habit Reminders',
//       channelDescription: 'Notifications for habit reminders',
//       importance: Importance.high,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher',
//     );

//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     const notificationDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _notifications.zonedSchedule(
//       id,
//       'Time for your habit! 🎯',
//       'Don\'t forget to complete "$habitName" today',
//       scheduledTime,
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }

//   static Future<void> cancelNotification(int id) async {
//     await _notifications.cancel(id);
//   }

//   static Future<void> cancelAllNotifications() async {
//     await _notifications.cancelAll();
//   }

//   static void _onNotificationTapped(NotificationResponse response) {
//     // Handle notification tap
//     debugPrint('Notification tapped: ${response.payload}');
//   }

//   static Future<void> showInstantNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'instant_notifications',
//       'Instant Notifications',
//       channelDescription: 'Instant notifications for achievements',
//       importance: Importance.high,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher',
//     );

//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     const notificationDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     await _notifications.show(
//       id,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
// }

