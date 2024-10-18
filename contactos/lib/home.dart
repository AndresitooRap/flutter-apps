import 'package:contactos/message_reponse.dart';
import 'package:contactos/register_contact.dart';
import 'package:flutter/material.dart';

import 'modify_contact.dart';

class HomeContacts extends StatefulWidget {
  const HomeContacts({super.key});

  @override
  State<HomeContacts> createState() => _HomeContactsState();
}

class _HomeContactsState extends State<HomeContacts> {
  List<Contacto> contacto = [
    Contacto(nombre: "Andrés", apellido: "Cuevas", celular: "+573017881084"),
    Contacto(nombre: "Ximena", apellido: "Ortiz", celular: "+573043830208"),
    Contacto(nombre: "Diego", apellido: "Diaz", celular: "+573002838191"),
    Contacto(
        nombre: "Mauricio", apellido: "Rodriguez", celular: "+573242332549"),
    Contacto(nombre: "Martin", apellido: "Aguirre", celular: "+5733146101615"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: (const Text(
          "Contactos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: ListView.builder(
        itemCount: contacto.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ModifyContact(
                    contacto[index],
                  ),
                ),
              ).then((nuevoContacto) {
                if (nuevoContacto != null) {
                  setState(() {
                    contacto.removeAt(index);

                    contacto.insert(index, nuevoContacto);
                    messageResponse(
                        context, nuevoContacto.nombre + " a sido actualizado");
                  });
                }
              });
            },
            onLongPress: () {
              _borrarContacto(context, contacto[index]);
            },
            title: Text(
              contacto[index].nombre + " " + contacto[index].apellido,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              contacto[index].celular,
              style: const TextStyle(color: Colors.grey),
            ),
            leading: CircleAvatar(
              child: Text(contacto[index].nombre.substring(0, 1)),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RegisterContact(),
            ),
          ).then((nuevoContacto) {
            if (nuevoContacto != null) {
              setState(() {
                contacto.add(nuevoContacto);
                messageResponse(
                    context, nuevoContacto.nombre + " a sido agregado");
              });
            }
          });
        },
        tooltip: "Nuevo Contacto",
        child: const Icon(Icons.add),
      ),
    );
  }

  _borrarContacto(BuildContext context, Contacto contacto) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Eliminar Contacto",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          "Estas seguro de eliminar a " + contacto.nombre + "?",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: (() {
              setState(() {
                this.contacto.remove(contacto);
              });
              Navigator.pop(context);
            }),
            child: const Text(
              "Eliminar",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class Contacto {
  // ignore: prefer_typing_uninitialized_variables
  var nombre;
  // ignore: prefer_typing_uninitialized_variables
  var apellido;
  // ignore: prefer_typing_uninitialized_variables
  var celular;

  Contacto({this.nombre, this.apellido, this.celular});
}
