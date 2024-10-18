import 'package:flutter/material.dart';
import 'package:rutas/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routes = {
    "/": (context) => const LoginPage(),
    "/home": (context) => const HomePage(),
    "/otra": (context) => const OtraPage(),
    "/servicios": (context) => const ServiciosPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "/",
      routes: _routes,
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) => const Page404(),
        );
      }),
    );
  }
}
