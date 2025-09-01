import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  // UPDATE: Menambahkan parameter quantity opsional
  void addToCart(Map<String, dynamic> product, {int quantity = 1}) {
    int index = _cartItems.indexWhere((item) => item['name'] == product['name']);

    if (index != -1) {
      // UPDATE: Menambahkan kuantitas sesuai input, bukan hanya ++
      _cartItems[index]['quantity'] += quantity;
    } else {
      // UPDATE: Menambahkan produk dengan kuantitas sesuai input
      _cartItems.add({...product, 'quantity': quantity});
    }
    
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item['name'] == product['name']);
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