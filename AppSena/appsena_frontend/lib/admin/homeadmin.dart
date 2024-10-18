import 'dart:convert';
import 'package:appsena_frontend/admin/CRUDCategory/category_add.dart';
import 'package:appsena_frontend/admin/CRUDCategory/category_details.dart';
import 'package:appsena_frontend/admin/CRUDProduct/product_add.dart';
import 'package:appsena_frontend/admin/CRUDProduct/product_details.dart';
import 'package:appsena_frontend/class/class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrscan/qrscan.dart' as scanner;

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int currentCategory = 0;
  String qrValue = "Codigo Qr";
  List<Product> producto = [];
  List<Category> category = [];

  Future<List<Product>> getAllProducts() async {
    const String url = "http://localhost:5270/api/products/";

    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      producto.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable usuariosData = decodedData.values;

    for (var item in usuariosData.elementAt(0)) {
      producto.add(Product(
        item['id'],
        item['attributes']['Name'],
        item['attributes']['Information'],
        item['attributes']['Image'],
        item['attributes']['Rate'],
        item['attributes']['Weigth'],
        item['attributes']['Price'],
      ));
    }

    return producto;
    
  }

  Future<List<Category>> getAllCategory() async {
    const String url = "http://localhost:5270/api/categories/";

    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      category.clear();
    }

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    Iterable usuariosData = decodedData.values;

    for (var item in usuariosData.elementAt(0)) {
      category.add(Category(
        item['id'],
        item['attributes']['Image'],
        item['attributes']['Name'],
      ));
    }
    return category;
  }

  void scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrValue = cameraScanResult!;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    getAllProducts();
    getAllCategory();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hola Administrador',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.black,
                          size: 20,
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Sena de Mosquera',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 5),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.qr_code,
                            color: Colors.black,
                            fill: 1,
                          ),
                          onPressed: () => scanQr(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 35),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Acá Tienes Todo El Control, Admin',
            style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                height: 1.3,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Categorías Existentes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        FutureBuilder(
          future: getAllCategory(),
          builder: (context, AsyncSnapshot<List<Category>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, index) =>
                              CategoryItem(
                            category: snapshot.data![index],
                            selected: currentCategory == index,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.5),
                      child: Container(
                        height: 100,
                        width: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.green.withOpacity(0.50),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.green.withOpacity(0.50),
                                    size: 50,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const AddCategory(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Productos Existentes",
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20,
            ),
          ),
        ),
        IndexedStack(
          index: currentCategory,
          children: [
            FutureBuilder(
              future: getAllProducts(),
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, index) =>
                                GestureDetector(
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailsProduct(
                                      products: snapshot.data![index], category: categories,
                                    ),
                                  ),
                                );
                              },
                              child: InkWell(
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: Container(
                                        height: 225,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.green, width: 2),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 225 + 60,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          35,
                                      decoration: BoxDecoration(
                                          color: const Color(0x00000000),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    title: const Text(
                                                        "Información"),
                                                    content: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                          color: Colors.black,
                                                          width: 3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      color: Colors.white,
                                                      child: InkWell(
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .bottomCenter,
                                                          children: [
                                                            Container(
                                                              height: 225 + 60,
                                                              width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2 -
                                                                  35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0x00000000),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          160,
                                                                      color: const Color(
                                                                          0x00000000),
                                                                      child:
                                                                          Stack(
                                                                        alignment:
                                                                            AlignmentDirectional.center,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                90,
                                                                            width:
                                                                                160,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  offset: const Offset(0, 5),
                                                                                  color: Colors.green.withOpacity(0.50),
                                                                                  spreadRadius: 10,
                                                                                  blurRadius: 30,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Image
                                                                              .network(
                                                                            producto[index].image,
                                                                            height:
                                                                                100,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      producto[
                                                                              index]
                                                                          .name,
                                                                      maxLines:
                                                                          1,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      producto[
                                                                              index]
                                                                          .informacion,
                                                                      maxLines:
                                                                          4,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ],
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
                                              child: Container(
                                                height: 160,
                                                color: const Color(0x00000000),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: [
                                                    Container(
                                                      height: 90,
                                                      width: 160,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              offset:
                                                                  const Offset(
                                                                      0, 5),
                                                              color: Colors
                                                                  .green
                                                                  .withOpacity(
                                                                      0.50),
                                                              spreadRadius: 10,
                                                              blurRadius: 30),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.green,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.network(
                                                        snapshot
                                                            .data![index].image,
                                                        height: 150,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              snapshot.data![index].name,
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
                                                    const Icon(
                                                        Icons.star_rate_rounded,
                                                        color: Colors.yellow,
                                                        size: 20),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      snapshot
                                                          .data![index].rate,
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(.8)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.receipt_long,
                                                        color: Colors.green,
                                                        size: 20),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      snapshot
                                                          .data![index].weigth,
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
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
                                              "\$${(snapshot.data![index].price)}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 20),
                        child: Container(
                          height: 200 + 65,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: Colors.green.withOpacity(0.50),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.green.withOpacity(0.50),
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const AddProduct(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  
}

class CategoryItem extends StatelessWidget {
  final bool selected;
  final Category category;
  const CategoryItem({
    super.key,
    required this.category,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.5),
        child: GestureDetector(
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsCategory(
                  categories: category,
                ),
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 140,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: Colors.green,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 30,
                      width: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.40),
                            offset: const Offset(0, 10),
                            blurRadius: 10,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        category.image,
                      ),
                      maxRadius: 30,
                      minRadius: 20,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Text(
                  category.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
