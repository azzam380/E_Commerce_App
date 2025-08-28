// Di dalam file lib/cart_provider.dart
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    // Cek apakah produk sudah ada di keranjang
    int index = _cartItems.indexWhere((item) => item['name'] == product['name']);

    if (index != -1) {
      // Jika sudah ada, tambahkan kuantitasnya
      _cartItems[index]['quantity']++;
    } else {
      // Jika belum ada, tambahkan produk ke keranjang dengan kuantitas 1
      _cartItems.add({...product, 'quantity': 1});
    }
    
    // Beri tahu widget yang "mendengarkan" bahwa ada perubahan
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

  // Fungsi untuk menghitung total harga
  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      // Hapus simbol '$' dan konversi ke double
      double price = double.parse(item['price'].replaceAll('\$', ''));
      total += price * item['quantity'];
    }
    return total;
  }
}