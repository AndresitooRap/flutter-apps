// view/add_user.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motos_frontend/customisation/text_field.dart';
import 'package:motos_frontend/view/show_bikes.dart';
import 'package:motos_frontend/view/bikes.dart';

class CreateBike extends StatefulWidget {
  final int? id;
  const CreateBike({Key? key, this.id});

  @override
  State<CreateBike> createState() => _CreateBikeState();
}

Bikes bikes = Bikes(
  0,
  '',
  '',
  '',
  '',
);

class _CreateBikeState extends State<CreateBike> {
  final TextEditingController _brandController =
      TextEditingController(text: bikes.brand);
  final TextEditingController _nameController =
      TextEditingController(text: bikes.name);
  final TextEditingController _colorController =
      TextEditingController(text: bikes.color);
  final TextEditingController _imageController =
      TextEditingController(text: bikes.image);

  @override
  void dispose() {
    super.dispose();
    _brandController.dispose();
    _nameController.dispose();
    _colorController.dispose();
    _imageController.dispose();
  }

  Future save() async {
    const String url = "http://localhost:5270/api/motos/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; chartset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "brand": bikes.brand,
      "name": bikes.name,
      "color": bikes.color,
      "image": bikes.image,
    };

    await http.post(
      Uri.parse(url),
      headers: dataHeader,
      body: json.encode({'data': dataBody}),
    );

    Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ShowBikes(),
        ) as Route<void>,
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Add Bike",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.blue],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            bottom: 100,
            left: 18,
            right: 18,
          ),
          child: Container(
            height: 550,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.grey[800],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    boxShadow: [],
                  ),
                  child: Textfield(
                    controller: _brandController,
                    onChanged: (val) {
                      bikes.brand = val;
                    },
                    textDirection: TextDirection.ltr,
                    hintText: "Brand",
                    hintSyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    boxShadow: [],
                  ),
                  child: Textfield(
                    controller: _nameController,
                    onChanged: (val) {
                      bikes.name = val;
                    },
                    textDirection: TextDirection.ltr,
                    hintText: "name",
                    hintSyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    boxShadow: [],
                  ),
                  child: Textfield(
                    controller: _colorController,
                    onChanged: (val) {
                      bikes.color = val;
                    },
                    textDirection: TextDirection.ltr,
                    hintText: "color",
                    hintSyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    boxShadow: [],
                  ),
                  child: Textfield(
                    controller: _imageController,
                    onChanged: (val) {
                      bikes.image = val;
                    },
                    textDirection: TextDirection.ltr,
                    hintText: "image",
                    hintSyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          title: const Text("Previsualización"),
                          content: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.white,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    bikes.brand,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Image.network(
                                    bikes.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    bikes.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                padding: const EdgeInsets.all(14),
                                child: const Text(
                                  "Back",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: save,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.cyan,
                                ),
                                padding: const EdgeInsets.all(14),
                                child: const Text(
                                  "Okay",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text("Previsualizar"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: save,
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
