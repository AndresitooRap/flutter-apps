import 'package:flutter/material.dart' show MaterialApp, runApp;
import 'package:flutter/widgets.dart';
import 'package:gifs/models/pages.dart';
import 'package:gifs/services/notification.dart';
import 'presentations/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const Splash(),
        "/home": (context) => const MyApp(),
        "/home10": (context) => const MyApp15(),
        "/home15": (context) => const MyApp20(),
      },
    ),
  );
}
