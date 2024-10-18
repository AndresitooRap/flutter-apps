//view/edit_user.dart

import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motos_frontend/customisation/text_field.dart';
import 'package:motos_frontend/view/show_bikes.dart';
import 'package:motos_frontend/view/bikes.dart';

import 'add_bikes.dart';

class EditBike extends StatefulWidget {
  final Bikes bikes;
  const EditBike({super.key, required this.bikes});

  @override
  State<EditBike> createState() => _EditBikeState();
}

class _EditBikeState extends State<EditBike> {
  void editBike({
    required Bikes bikes,
    required String brand,
    required String name,
    required String color,
    required String image,
  }) async {
    @override
    const String url = "http://localhost:5270/api/motos/";

    final Map<String, String> dataHeader = {
      "Acces-Control-Allow-Methods": "[GET, POST, PUT, DETELE, HEAD, OPTIONS]",
      "Content-Type": "application/json; charset=UTF-8",
    };
    final Map<String, dynamic> dataBody = {
      "brand": brand,
      "name": name,
      "color": color,
      "image": image,
    };

    final response = await http.put(
        Uri.parse(
          url + bikes.id.toString(),
        ),
        headers: dataHeader,
        body: json.encode({"data": dataBody}));

    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const ShowBikes(),
          ),
          (Route<dynamic> route) => false);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController brandController =
        TextEditingController(text: widget.bikes.brand);
    TextEditingController nameController =
        TextEditingController(text: widget.bikes.name);
    TextEditingController colorController =
        TextEditingController(text: widget.bikes.color);
    TextEditingController imageController =
        TextEditingController(text: widget.bikes.image);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Edit Bike",
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
            left: 10,
            right: 10,
          ),
          child: Container(
            height: 550,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[800],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  decoration: const BoxDecoration(boxShadow: []),
                  child: Textfield(
                    controller: brandController,
                    onChanged: (val) {
                      brandController.value =
                          brandController.value.copyWith(text: val);
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
                  decoration: const BoxDecoration(boxShadow: []),
                  child: Textfield(
                    controller: nameController,
                    onChanged: (val) {
                      nameController.value =
                          nameController.value.copyWith(text: val);
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
                  decoration: const BoxDecoration(boxShadow: []),
                  child: Textfield(
                    controller: colorController,
                    onChanged: (val) {
                      colorController.value =
                          colorController.value.copyWith(text: val);
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
                  child: Column(
                    children: [
                      Textfield(
                        controller: imageController,
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
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          '${widget.bikes.image}',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
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
                      editBike(
                        bikes: widget.bikes,
                        brand: brandController.text,
                        name: nameController.text,
                        color: colorController.text,
                        image: imageController.text,
                      );
                    },
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        color: const Color.fromARGB(255, 37, 100, 164),
        items: const <Widget>[
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.square_outlined, color: Colors.white),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}
