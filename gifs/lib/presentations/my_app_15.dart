import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:speed_dial_fab/speed_dial_fab.dart';
import '../models/gif_app.dart';
import 'dart:convert';
import '../services/notification.dart';

class MyApp15 extends StatefulWidget {
  const MyApp15({Key? key}) : super(key: key);

  @override
  State<MyApp15> createState() => _MyApp15State();
}

class _MyApp15State extends State<MyApp15> {
  late Future<List<Gif>> _listadoGifs; //Espere hasta que resuelva una petición

  //Función de devuelva un objeto del tipo

  Future<List<Gif>> _getGifs() async {
    const stringUri =
        "https://api.giphy.com/v1/gifs/trending?api_key=XdC1JZo4KxQuUksGxiqiYY8cq6O4uL5H&limit=15&rating=g";
    final response = await http.get(Uri.parse(stringUri));
    List<Gif> gifs = [];

    if (response.statusCode == 200) {
      //Verificamos que el RESPONSE este codificado UTF8
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body); //Convierte a un objeto Json

      //Recorremos el objeto Json para cargar la lista gifs con cada elemento
      for (var item in jsonData["data"]) {
        gifs.add(
          Gif(
            item["title"],
            item["images"]["downsized"]["url"],
            item["id"],
            item["username"],
            item["import_datetime"],
          ),
        );
      }

      //print(jsonData);
      //print(jsonData["data"]);
      //print(jsonData["data"][0]);
      //print(jsonData["data"][0]["type"]);
      //print("${gifs[0].name} ${gifs[0].url} ${gifs[0].id} ${gifs[0].user} ${gifs[0].date}");
    } else {
      throw Exception("Fallo la Conexión");
    }

    return gifs;
  }

  @override
  void initState() {
    super.initState();
    _listadoGifs = _getGifs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gifs",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 5, 2, 150),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Center(child: Text("Gifs")),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: _listadoGifs,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.extent(
                      maxCrossAxisExtent: 210,
                      padding: const EdgeInsets.all(4),
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      //los datos (snapshot) son nullable
                      //los convertimos en non-nullable
                      children: _listGifs(snapshot.data!),
                    );
                  } else if (snapshot.hasError) {
                    // print(snapshot.error);
                    return const Text('error');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
            ],
          ),
        ),
        floatingActionButton: SpeedDialFabWidget(
          secondaryIconsList: const [
            Icons.looks_one_rounded,
            Icons.looks_two_rounded,
            Icons.looks_3_rounded,
          ],
          secondaryIconsText: const [
            "10 Gif",
            "15 Gif",
            "20 Gif",
          ],
          secondaryIconsOnPress: [
            () => {Navigator.pushReplacementNamed(context, "/home")},
            () => {Navigator.pushReplacementNamed(context, "/home10")},
            () => {Navigator.pushReplacementNamed(context, "/home15")},
          ],
          secondaryBackgroundColor: const Color.fromARGB(255, 5, 2, 150),
          secondaryForegroundColor: Colors.white,
          primaryBackgroundColor: const Color.fromARGB(255, 5, 2, 150),
          primaryForegroundColor: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      gifs.add(
        GestureDetector(
          onTap: () => {
            mostrarNotificacion(gif),
            showDialog(
              context: context,
              builder: (buildContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.blue[400],
                  backgroundColor: const Color.fromARGB(255, 19, 19, 19),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Detalles",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  content: SizedBox(
                    height: 480,
                    child: Column(
                      children: [
                        Image.network(
                          gif.url,
                          fit: BoxFit.fill,
                          height: 200,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 5,
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    "Name Gif",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  gif.name,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    "ID",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  gif.id,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    "User creator",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  gif.user,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    "Famous date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  gif.date,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          },
          child: Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(255, 45, 42, 201),
                width: 3,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            color: Colors.black,
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    gif.url,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    gif.name,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return gifs;
  }
}
