//view/strapi_app.dart

import 'package:appsena_frontend/pages/onboardpage.dart';
import 'package:appsena_frontend/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appsena extends StatelessWidget {
  const Appsena({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
          
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tienda SENA",
        theme: ThemeData(
          useMaterial3: true
        ),
        home: const OnBoardPage(),
      ),
    );
  }
}
