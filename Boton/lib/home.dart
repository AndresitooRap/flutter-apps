import 'package:flutter/material.dart';
import 'package:flutter_application_1/second_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Center(
          child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(),
            ),
          );
        },
        child: Text(
          "Ir a terminos y condiciones",
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
