import 'package:appsena_frontend/admin/useradmin.dart';
import 'package:appsena_frontend/auth/LoginAndRegister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthAdmin extends StatelessWidget {
  const AuthAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const UserAdmin();
          } else {
            return const LoginAndRegister();
          }
        },
      ),
    );
  }
}