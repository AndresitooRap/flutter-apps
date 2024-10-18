import 'package:appsena_frontend/class/class.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;
  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(Product productModel) {
    if (productExist(productModel)) {
      int index =
          _carts.indexWhere((element) => element.productModel == productModel);
      _carts[index].quantity = _carts[index].quantity + 1;
    } else {
      _carts.add(CartModel(
        productModel: productModel,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  addQuantity(Product product) {
    int index = _carts.indexWhere((element) => element.productModel == product);
    _carts[index].quantity = _carts[index].quantity + 1;
    notifyListeners();
  }

  reduceQuantity(Product product) {
    int index = _carts.indexWhere((element) => element.productModel == product);
    _carts[index].quantity = _carts[index].quantity - 1;
    notifyListeners();
  }

  subtotal(Product product) {
    int total = 0;
    int index = _carts.indexWhere((element) => element.productModel == product);
    total = int.parse(product.price) * _carts[index].quantity;

    return total;
  }

  productExist(Product productModel) {
    if (_carts.indexWhere((element) => element.productModel == productModel) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  productRemove(Product productModel) {
    int index =
        _carts.indexWhere((element) => element.productModel == productModel);
    _carts.removeAt(index);
    notifyListeners();
  }

  totalCart() {
    double total = 0;
    for (var i = 0; i < _carts.length; i++) {
      total =
          total + _carts[i].quantity * int.parse(_carts[i].productModel.price);
    }
    return total;
  }

  enviarPedido() {
    mgListaPedido();
  }

  void mgListaPedido() async {
    String pedido = "";
    String fecha = DateTime.now().toString();
    pedido = "${pedido}Fecha: $fecha ";
    pedido = "$pedido\n";
    pedido = "${pedido}Centro de Biotecnología Agropecuaria\n ";
    pedido = "$pedido\n";
    pedido = "${pedido}Distribuidora de Mosquera.\n ";
    pedido = "$pedido\n";
    pedido = "${pedido}Puedes pasar por este pedido en tres días.\n ";
    pedido = "$pedido\n\n\n\n\n";

    for (var i = 0; i < _carts.length; i++) {
      pedido =
          "$pedido\nProducto: ${carts[i].productModel.name}, \n Cantidad: ${carts[i].quantity}, \n Precio: ${carts[i].productModel.price}\n  = ";
    }
    pedido = "${pedido}Total:${(totalCart())}";

    // ignore: deprecated_member_use
    await launch("https://wa.me/${573043830208}?text=$pedido");
  }
}
