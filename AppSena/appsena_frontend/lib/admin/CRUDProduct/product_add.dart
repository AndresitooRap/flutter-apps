import 'dart:convert';
import 'package:appsena_frontend/admin/mainadmin.dart';
import 'package:appsena_frontend/class/class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddProduct extends StatefulWidget {
  final int? id;
  const AddProduct({super.key, this.id});

  @override
  State<AddProduct> createState() => AddProductState();
}

Product products = Product(
  0,
  '',
  '',
  '',
  '',
  '',
  '',
);

class AddProductState extends State<AddProduct> {
  final TextEditingController _nameController =
      TextEditingController(text: products.name);
  final TextEditingController _informacionController =
      TextEditingController(text: products.informacion);
  final TextEditingController _imageController =
      TextEditingController(text: products.image);
  final TextEditingController _rateController =
      TextEditingController(text: products.rate);
  final TextEditingController _weigthController =
      TextEditingController(text: products.weigth);
  final TextEditingController _priceController =
      TextEditingController(text: products.price);
  List<Category> _categorias = [];
  List<Category>? _selectedCategoria = [];
  late List<int> ids =
      _selectedCategoria!.map((categoria) => categoria.id).toList();
  var selectedCategoriaValue = "".obs;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _informacionController.dispose();
    _imageController.dispose();
    _rateController.dispose();
    _weigthController.dispose();
    _priceController.dispose();
  }

  Future save() async {
    const String url = "http://localhost:5270/api/products/";

    final Map<String, String> dataHeader = {
      'Content-Type': 'application/json; chartset=UTF-8',
    };

    final Map<String, dynamic> dataBody = {
      "Name": products.name,
      "Information": products.informacion,
      "Image": products.image,
      "Rate": products.rate,
      "Weigth": products.weigth,
      "Price": products.price,
      "categories": ids,
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

  Future<List<Category>> getAllCategorias() async {
    String url = "http://localhost:5270/api/categories/";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      _categorias.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable usuariosData = decodedData.values;

    for (var item in usuariosData.elementAt(0)) {
      _categorias.add(Category(
        item['id'],
        item['attributes']['Image'],
        item['attributes']['Name'],
      ));
    }

    return _categorias;
  }

  @override
  void initState() {
    super.initState();
    getAllCategorias().then((categorias) {
      setState(() {
        _categorias = categorias;
      });
    });
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
                  top: 10,
                  bottom: 5,
                  left: 15,
                ),
                child: Text(
                  "Añadir Producto",
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
              "Aquí se agreegan los productos, escoge el nombre, el precio y otros, desata tu creatividad.",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
            padding:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
            alignment: Alignment.center,
            height: 500,
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
                    controller: _nameController,
                    onChanged: (val) {
                      products.name = val;
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
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _informacionController,
                    onChanged: (val) {
                      products.informacion = val;
                    },
                    textDirection: TextDirection.ltr,
                    maxLength: 85,
                    decoration: InputDecoration(
                      hintText: "informacion",
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
                    controller: _imageController,
                    onChanged: (val) {
                      products.image = val;
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
                    controller: _rateController,
                    onChanged: (val) {
                      products.rate = val;
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: "Puntuación",
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
                    controller: _weigthController,
                    onChanged: (val) {
                      products.weigth = val;
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: "Unidad de Medida",
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
                    controller: _priceController,
                    onChanged: (val) {
                      products.price = val;
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: "Precio",
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
                MultiSelectDialogField<Category>(
                  searchHint: "Buscar",
                  searchTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                  dialogHeight: MediaQuery.of(context).size.width / 2,
                  barrierColor: Colors.grey[600]?.withOpacity(0.50),
                  listType: MultiSelectListType.LIST,
                  checkColor: Colors.white,
                  backgroundColor: Colors.green.shade50,
                  chipDisplay: MultiSelectChipDisplay.none(),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  buttonIcon: const Icon(
                    Icons.share,
                    color: Colors.green,
                  ),
                  buttonText: Text(
                    "Escoge La Categoria",
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  items: _categorias
                      .map(
                        (categoria) => MultiSelectItem<Category>(
                          categoria,
                          categoria.name,
                        ),
                      )
                      .toList(),
                  selectedColor: Colors.green,
                  searchable: true,
                  title: const Text("Categorias"),
                  onConfirm: (categoria) {
                    _selectedCategoria = categoria;
                    selectedCategoriaValue.value = "";
                    _selectedCategoria?.forEach((element) {
                      selectedCategoriaValue.value =
                          "${selectedCategoriaValue.value} ${element.name}, ";
                    });
                  },
                ),
              ],
            ),
          ),
          Obx(
            () => Text(selectedCategoriaValue.value),
          ),
          const SizedBox(height: 0),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 225 + 60,
                              width: MediaQuery.of(context).size.width / 2 - 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 160,
                                      color: const Color(0x00000000),
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            height: 90,
                                            width: 160,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0, 5),
                                                    color: Colors.green
                                                        .withOpacity(0.50),
                                                    spreadRadius: 10,
                                                    blurRadius: 30),
                                              ],
                                            ),
                                          ),
                                          Image.network(
                                            products.image,
                                            height: 150,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      products.name,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.star_rate_rounded,
                                                color: Colors.yellow, size: 20),
                                            const SizedBox(width: 5),
                                            Text(
                                              products.rate,
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.8)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Row(
                                          children: [
                                            const Icon(Icons.receipt_long,
                                                color: Colors.green, size: 20),
                                            const SizedBox(width: 5),
                                            Text(
                                              products.weigth,
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(
                                                  .8,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "\$${(products.price)}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
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
