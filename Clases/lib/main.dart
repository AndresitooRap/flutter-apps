import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Empresa _facebook = new Empresa(
    "Facebook",
    "Mark Zuckerberg",
    500000000,
  );

  @override
  void initState() {
    super.initState();
    print(_facebook.nombre);
    print(_facebook.propietario);
    print(_facebook.ingresoanual);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Clases",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Clases"),
        ),
        body: Center(
          child: Text(
            _facebook.ingresoanual.toString(),
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class Empresa {
  String nombre;
  String propietario;
  int ingresoanual;

  Empresa(this.nombre, this.propietario, this.ingresoanual);
}
