import 'package:appsena_frontend/models/cart_model.dart';
import 'package:appsena_frontend/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarItem extends StatelessWidget {
  final CartModel cart;
  const CarItem({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 5))
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 130,
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
          Positioned(
            top: -5,
            left: 0,
            child: SizedBox(
              width: 130,
              height: 130,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 130,
                    width: 70,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 30,
                          spreadRadius: 10,
                          offset: const Offset(0, 10))
                    ]),
                  ),
                  Image.network(
                    cart.productModel.image,
                    width: 130,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 130,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    cart.productModel.name,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star_rate_rounded,
                            color: Colors.yellow, size: 20),
                        const SizedBox(width: 5),
                        Text(
                          cart.productModel.rate,
                          style: TextStyle(color: Colors.black.withOpacity(.8)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Row(
                      children: [
                        const Icon(Icons.receipt_long,
                            color: Colors.green, size: 20),
                        const SizedBox(width: 5),
                        Text(
                          cart.productModel.weigth,
                          style: TextStyle(color: Colors.black.withOpacity(.8)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "\$${(cartProvider.subtotal(cart.productModel))}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartProvider.productRemove(cart.productModel);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "\$${(cart.productModel.price)}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (cart.quantity > 1) {
                                  cartProvider
                                      .reduceQuantity(cart.productModel);
                                }
                              },
                              child: Container(
                                width: 25,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(7),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cart.quantity.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                cartProvider.addCart(cart.productModel);
                              },
                              child: Container(
                                width: 25,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(7),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
