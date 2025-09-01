import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    // Kunci unik sekarang adalah kombinasi nama, ukuran, dan warna
    int index = _cartItems.indexWhere((item) =>
        item['name'] == product['name'] &&
        item['size'] == product['size'] &&
        item['color'] == product['color']);

    if (index != -1) {
      // Jika item yang identik sudah ada, tambahkan kuantitasnya
      _cartItems[index]['quantity'] += product['quantity'];
    } else {
      // Jika belum ada, tambahkan sebagai item baru
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cartItems[index]['quantity']++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      double price = double.parse(item['price'].replaceAll('\$', ''));
      total += price * item['quantity'];
    }
    return total;
  }
}