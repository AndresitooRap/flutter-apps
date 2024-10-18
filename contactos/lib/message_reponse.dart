import 'package:flutter/material.dart';

messageResponse(BuildContext context, String nombre) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        "Contacto agregado",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "El contacto " + nombre,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
