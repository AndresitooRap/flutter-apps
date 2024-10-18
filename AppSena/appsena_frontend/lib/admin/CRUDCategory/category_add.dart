import 'dart:convert';
import 'package:appsena_frontend/admin/mainadmin.dart';
import 'package:appsena_frontend/class/class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCategory extends StatefulWidget {
  final int? id;
  const AddCategory({super.key, this.id});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

Category categories = Category(
  0,
  '',
  '',
);

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _imageController =
      TextEditingController(text: categories.image);
  final TextEditingController _nameController =
      TextEditingController(text: categories.name);

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
    _nameController.dispose();
  }

  Future save() async {
    const String url = "http://localhost:5270/api/categories/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; chartset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "Image": categories.image,
      "Name": categories.name,
    };

    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const MainAdmin(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                  left: 15,
                ),
                child: Text(
                  "Añadir Categoria",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 15,
              right: 15,
            ),
            child: Text(
              "Aqui agregas las categorias, hay dos campos de texto, el primer campo es de una imágen URL, en el segundo campo sera para el nombre, desata tú creatividad.",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(225, 245, 245, 220),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _imageController,
                    onChanged: (val) {
                      categories.image = val;
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: "Imagen URL",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 134, 134, 134)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _nameController,
                    onChanged: (val) {
                      categories.name = val;
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: "Nombre",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 134, 134, 134)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(225, 245, 245, 220),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          title: const Center(
                            child: Text(
                              "Previsualización",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          content: Container(
                            height: 150,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.green.shade900,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(categories.image),
                                      maxRadius: 30,
                                      minRadius: 20,
                                    ),
                                    Text(
                                      categories.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.red,
                                    ),
                                  ),
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: save,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.green.shade800,
                                    ),
                                  ),
                                  child: const Text(
                                    "Guardar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.grey.shade900,
                      ),
                    ),
                    child: const Text(
                      "Previsualizar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: save,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green.shade800,
                      ),
                    ),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
