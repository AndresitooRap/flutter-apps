import 'package:appsena_frontend/auth/LoginAndRegister.dart';
import 'package:appsena_frontend/pages/cartpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaginadeCompra extends StatelessWidget {
  const PaginadeCompra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CartPage();
          } else {
            return const LoginAndRegister();
          }
        },
      ),
    );
  }
}
