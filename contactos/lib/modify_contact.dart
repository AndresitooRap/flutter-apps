import 'package:flutter/material.dart';
import 'package:contactos/text_box.dart';
import 'home.dart';

class ModifyContact extends StatefulWidget {
  const ModifyContact(this._contacto, {super.key});
  final Contacto _contacto;
  @override
  State<ModifyContact> createState() => _ModifyContactState();
}

class _ModifyContactState extends State<ModifyContact> {
  late TextEditingController controllerNombre;
  late TextEditingController controllerApellido;
  late TextEditingController controllerCelular;

  @override
  void initState() {
    Contacto c = widget._contacto;
    controllerNombre = TextEditingController(text: c.nombre);
    controllerApellido = TextEditingController(text: c.apellido);
    controllerCelular = TextEditingController(text: c.celular);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Modificar Contacto"),
      ),
      body: ListView(
        children: [
          TextBox(controllerNombre, "Nombre"),
          TextBox(controllerApellido, "Apellido"),
          TextBox(controllerCelular, "Celular"),
          ElevatedButton(
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
            child: const Text("Guardar Contacto"),
          ),
        ],
      ),
    );
  }
}
