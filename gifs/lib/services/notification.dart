import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gifs/models/gif_app.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("icono_notificacion");

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> mostrarNotificacion(Gif gif) async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails("your channel id", "your channel name",
          importance: Importance.max, priority: Priority.max);

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(
      1, "¡Felicidades!", "Haz visto ${gif.name}", notificationDetails);
}
