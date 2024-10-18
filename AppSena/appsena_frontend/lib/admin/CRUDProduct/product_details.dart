import 'dart:convert';
import 'package:appsena_frontend/admin/mainadmin.dart';
import 'package:appsena_frontend/class/class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';

class DetailsProduct extends StatefulWidget {
  final Product products;
  final Category category;
  const DetailsProduct(
      {super.key, required this.products, required this.category});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  final List<Category> _categorysky = [];
  bool _loading = true;
  void _loadCategory() async {
    final url =
        'http://localhost:5270/api/categories?populate=products,categories&filters[products][id]=${widget.products.id}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      _categorysky.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);

    List<dynamic> categoriesData = decodedData.values.first;

    for (var categoryData in categoriesData) {
      Category category = Category(
        categoryData['id'],
        categoryData['attributes']['Image'],
        categoryData['attributes']['Name'],
      );
      _categorysky.add(category);
    }

    setState(() {
      _loading = false;
    });
  }

  List<Category> _categorias = [];
  List<Category>? _selectedCategoria = [];
  late List<int> ids =
      _selectedCategoria!.map((categoria) => categoria.id).toList();
  var selectedCategoriaValue = "".obs;
  List<String> selectedValues = [];

  Future<List<Category>> getAllCategorias() async {
    const String url = "http://localhost:5270/api/categories/";

    var response = await http.get(
      Uri.parse(url),
    );

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
    _loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.products.name);
    TextEditingController informacionController =
        TextEditingController(text: widget.products.informacion);
    TextEditingController imageController =
        TextEditingController(text: widget.products.image);
    TextEditingController rateController =
        TextEditingController(text: widget.products.rate);
    TextEditingController weigthController =
        TextEditingController(text: widget.products.weigth);
    TextEditingController priceController =
        TextEditingController(text: widget.products.price);

    Future<void> deleteProduct() async {
      const String url = "http://localhost:5270/api/products/";

      await http.delete(
        Uri.parse(
          url + widget.products.id.toString(),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const MainAdmin(),
          ),
          (Route<dynamic> route) => false);
    }

    Future<void> editProducts({
      required Product products,
      required String name,
      required String informacion,
      required String image,
      required String rate,
      required String weigth,
      required String price,
    }) async {
      @override
      const String url = "http://localhost:5270/api/products/";

      final Map<String, String> dataHeader = {
        "Acces-Control-Allow-Methods":
            "[GET, POST, PUT, DETELE, HEAD, OPTIONS]",
        "Content-Type": "application/json; charset=UTF-8",
      };
      final Map<String, dynamic> dataBody = {
        "Name": name,
        "Information": informacion,
        "Image": image,
        "Rate": rate,
        "Weigth": weigth,
        "Price": price,
        "categories": ids
      };
      final response = await http.put(
        Uri.parse(
          url + products.id.toString(),
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
      } else {}
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.products.image,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  widget.products.name,
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
          const SizedBox(height: 5),
          Container(
            margin:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
            alignment: Alignment.center,
            height: 520,
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
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: informacionController,
                    onChanged: (val) {
                      informacionController.value =
                          informacionController.value.copyWith(text: val);
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
                const SizedBox(height: 5),
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
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: rateController,
                    onChanged: (val) {
                      rateController.value =
                          rateController.value.copyWith(text: val);
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: "rate",
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
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: weigthController,
                    onChanged: (val) {
                      weigthController.value =
                          weigthController.value.copyWith(text: val);
                    },
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: "Peso",
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
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: priceController,
                    onChanged: (val) {
                      priceController.value =
                          priceController.value.copyWith(text: val);
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
                    "Cambia La Categoria",
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
                Obx(
                  () => Text(selectedCategoriaValue.value),
                ),
                _loading
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: ListView(
                          children: _categorysky.map((category) {
                            return ListTile(
                              title: Text(category.name),
                            );
                          }).toList(),
                        ),
                      ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.center,
            height: 90,
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
                      deleteProduct();
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
                      editProducts(
                        products: widget.products,
                        name: nameController.text,
                        informacion: informacionController.text,
                        image: imageController.text,
                        rate: rateController.text,
                        weigth: weigthController.text,
                        price: priceController.text,
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
