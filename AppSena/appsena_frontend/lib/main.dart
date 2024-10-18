import 'package:appsena_frontend/class/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCGitj-wu5PV1RbJi_VPeWND6USpox_zaQ",
      authDomain: "app-sena-backend.firebaseapp.com",
      projectId: "app-sena-backend",
      storageBucket: "app-sena-backend.appspot.com",
      messagingSenderId: "402865005573",
      appId: "1:402865005573:web:f8cf11d5c05ed14252686c",
      measurementId: "G-HB4N0SVCSS",
    ),
  );

  runApp(const Appsena());
}
