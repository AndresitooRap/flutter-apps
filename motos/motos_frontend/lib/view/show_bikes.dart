//view/show_users.dart

import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motos_frontend/view/add_bikes.dart';
import 'package:motos_frontend/view/bikes.dart';
import 'package:motos_frontend/view/bike.detail.dart';

class ShowBikes extends StatefulWidget {
  const ShowBikes({Key? key}) : super(key: key);

  @override
  State<ShowBikes> createState() => _ShowBikesState();
}

class _ShowBikesState extends State<ShowBikes> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Bikes> bike = [];

  Future<List<Bikes>> getAll() async {
    const String url = "http://localhost:5270/api/motos/";

    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      bike.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable usuariosData = decodedData.values;

    for (var item in usuariosData.elementAt(0)) {
      bike.add(
        Bikes(
          item['id'],
          item['attributes']['brand'],
          item['attributes']['name'],
          item['attributes']['color'],
          item['attributes']['image'],
        ),
      );
    }

    return bike;
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Bikes",
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
      body: FutureBuilder(
        future: getAll(),
        builder: (context, AsyncSnapshot<List<Bikes>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 20,
              mainAxisExtent: 200,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BikeDetails(
                      bikes: snapshot.data![index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Card(
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
                        height: 8,
                      ),
                      Text(
                        snapshot.data![index].brand,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Image.network(snapshot.data![index].image,
                            fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        color: const Color.fromARGB(255, 37, 100, 164),
        items: <Widget>[
          const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              final CurvedNavigationBarState? navBarState =
                  _bottomNavigationKey.currentState;
              navBarState?.setPage(1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateBike(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.square_outlined,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
