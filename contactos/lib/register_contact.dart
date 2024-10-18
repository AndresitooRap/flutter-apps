import 'package:contactos/home.dart';
import 'package:contactos/text_box.dart';
import 'package:flutter/material.dart';

class RegisterContact extends StatefulWidget {
  const RegisterContact({super.key});

  @override
  State<RegisterContact> createState() => _RegisterContactState();
}

class _RegisterContactState extends State<RegisterContact> {
  late TextEditingController controllerNombre;
  late TextEditingController controllerApellido;
  late TextEditingController controllerCelular;

  @override
  void initState() {
    controllerNombre = TextEditingController();
    controllerApellido = TextEditingController();
    controllerCelular = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Nuevo Contacto"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        children: [
          TextBox(controllerNombre, "Nombre"),
          TextBox(controllerApellido, "Apellido"),
          TextBox(controllerCelular, "Celular"),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.blue[900],
                ),
              ),
              onPressed: () {
                String nombre = controllerNombre.text;
                String apellido = controllerApellido.text;
                String celular = controllerCelular.text;

                if (nombre.isNotEmpty &&
                    apellido.isNotEmpty &&
                    celular.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Contacto(
                        nombre: nombre, apellido: apellido, celular: celular),
                  );
                }
              },
              child: const Text(
                "Guardar Contacto",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
