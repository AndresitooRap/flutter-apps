import 'dart:convert';
import 'package:appsena_frontend/admin/mainadmin.dart';
import 'package:appsena_frontend/class/class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsCategory extends StatefulWidget {
  final Category categories;
  const DetailsCategory({super.key, required this.categories});

  @override
  State<DetailsCategory> createState() => _DetailsCategoryState();
}

class _DetailsCategoryState extends State<DetailsCategory> {
  void editCategory({
    required Category categories,
    required String image,
    required String name,
  }) async {
    @override
    const String url = "http://localhost:5270/api/categories/";

    final Map<String, String> dataHeader = {
      "Acces-Control-Allow-Methods": "[GET, POST, PUT, DETELE, HEAD, OPTIONS]",
      "Content-Type": "application/json; charset=UTF-8",
    };
    final Map<String, dynamic> dataBody = {
      "Image": image,
      "Name": name,
    };
    final response = await http.put(
      Uri.parse(
        url + categories.id.toString(),
      ),
      headers: dataHeader,
      body: json.encode(
        {"data": dataBody},
      ),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const MainAdmin(),
          ),
          (Route<dynamic> route) => false);
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController imageController =
        TextEditingController(text: widget.categories.image);
    TextEditingController nameController =
        TextEditingController(text: widget.categories.name);

    void deleteCategory() async {
      const String url = "http://localhost:5270/api/categories/";

      await http.delete(
        Uri.parse(
          url + widget.categories.id.toString(),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const MainAdmin(),
          ),
          (Route<dynamic> route) => false);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.categories.image,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  widget.categories.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              color: Colors.black,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.center,
            height: 180,
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
                    controller: imageController,
                    onChanged: (val) {
                      imageController.value =
                          imageController.value.copyWith(text: val);
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
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: nameController,
                    onChanged: (val) {
                      nameController.value =
                          nameController.value.copyWith(text: val);
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
          const SizedBox(height: 5),
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
                      deleteCategory();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red,
                      ),
                    ),
                    child: const Text(
                      "Eliminar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      editCategory(
                        categories: widget.categories,
                        image: imageController.text,
                        name: nameController.text,
                      );
                    },
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
          )
        ],
      ),
    );
  }
}
