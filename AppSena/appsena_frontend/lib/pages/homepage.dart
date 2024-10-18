import 'dart:convert';
import 'package:appsena_frontend/class/class.dart';
import 'package:appsena_frontend/pages/homepageproduct.dart';
import 'package:appsena_frontend/provider/cart_provider.dart';
import 'package:appsena_frontend/widgets/buy_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentCategory = 0;
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

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
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
                          'Bienvenido',
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
                  const SizedBox(width: 10),
                  const SizedBox(width: 5),
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaginadeCompra(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      cartProvider.carts.isNotEmpty
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                child: Text(
                                  cartProvider.carts.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
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
            'Encuentra tu mejor opción con nosotros',
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
                'Categorias Existentes',
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
                              GestureDetector(
                            onTap: () {
                              setState(() {
                                currentCategory = index;
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (_, __, ___) => AlertProductos(
                                      category: snapshot.data![index],
                                    ),
                                  ),
                                );
                              });
                            },
                            child: CategoryItem(
                              category: snapshot.data![index],
                              selected: currentCategory == index,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Todos Los Productos",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
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
                        itemBuilder: (BuildContext context, index) => InkWell(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: Container(
                                  height: 225,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.green, width: 2),
                                  ),
                                ),
                              ),
                              Container(
                                height: 225 + 60,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 35,
                                decoration: BoxDecoration(
                                    color: const Color(0x00000000),
                                    borderRadius: BorderRadius.circular(10)),
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
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              title: const Text("Información"),
                                              content: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.black,
                                                    width: 3,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 160,
                                                                color: const Color(
                                                                    0x00000000),
                                                                child: Stack(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          90,
                                                                      width:
                                                                          160,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            offset:
                                                                                const Offset(0, 5),
                                                                            color:
                                                                                Colors.green.withOpacity(0.50),
                                                                            spreadRadius:
                                                                                10,
                                                                            blurRadius:
                                                                                30,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Image
                                                                        .network(
                                                                      producto[
                                                                              index]
                                                                          .image,
                                                                      height:
                                                                          100,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                producto[index]
                                                                    .name,
                                                                maxLines: 1,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                producto[index]
                                                                    .informacion,
                                                                maxLines: 4,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 15,
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
                                                AlignmentDirectional.center,
                                            children: [
                                              Container(
                                                height: 90,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 5),
                                                      color: Colors.green
                                                          .withOpacity(0.50),
                                                      spreadRadius: 10,
                                                      blurRadius: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.green,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Image.network(
                                                  snapshot.data![index].image,
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
                                                snapshot.data![index].rate,
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
                                                  color: Colors.green,
                                                  size: 20),
                                              const SizedBox(width: 5),
                                              Text(
                                                snapshot.data![index].weigth,
                                                style: TextStyle(
                                                  color:
                                                      Colors.black.withOpacity(
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
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    cartProvider.addCart(producto[index]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 140,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: selected
                ? Border.all(
                    width: 2,
                    color: Colors.green,
                  )
                : Border.all(
                    color: Colors.green.withOpacity(0.10),
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
    );
  }
}
