import 'package:flutter/material.dart';
import 'package:notificaciones/services/notifiacion_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      title: 'Notificación',
      home: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.90),
        appBar: AppBar(
          title: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Notificación',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.notifications),
              ],
            ),
          ),
        ),
        body: PaginaPrincipal(),
      ),
    );
  }
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications,
            color: Colors.white,
            size: 90,
          ),
          Text("Presiona para ver una notificación"),
          ElevatedButton(
              onPressed: () {
                //aquí debemos mostrar la notificación
                mostrarNotificacion();
              },
              child: const Text(
                'No me presiones',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )),
        ],
      ),
    );
  }
}
