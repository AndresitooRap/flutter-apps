//view/strapi_app.dart

import 'package:flutter/material.dart';
import 'package:motos_frontend/view/show_bikes.dart';

class Motos extends StatelessWidget {
  const Motos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tienda de motos",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const ShowBikes(),
    );
  }
}