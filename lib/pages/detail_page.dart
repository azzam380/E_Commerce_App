import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

// UPDATE: Mendefinisikan tema warna agar konsisten
const Color primaryColor = Color(0xFF01B11E); // Hijau
const Color secondaryTextColor = Colors.black54;

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildImageHeader(),
          _buildProductDetails(),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(cartProvider),
    );
  }

  Widget _buildImageHeader() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.product['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  // UPDATE: Warna ikon disesuaikan
                  child: const Icon(Icons.arrow_back, color: primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product['name'],
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              // UPDATE: Warna teks disesuaikan
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          RatingBar.builder(
            initialRating: 4.5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 25,
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {},
          ),
          const SizedBox(height: 20),
          Text(
            widget.product['description'],
            // UPDATE: Warna teks deskripsi menggunakan variabel
            style: const TextStyle(fontSize: 16, color: secondaryTextColor, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(CartProvider cartProvider) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Price", style: TextStyle(color: Colors.grey)),
              Text(
                widget.product['price'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  // UPDATE: Warna harga disesuaikan
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              cartProvider.addToCart(widget.product, quantity: _quantity);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "${widget.product['name']} (x$_quantity) ditambahkan ke keranjang!"),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text("Add to Cart"),
            style: ElevatedButton.styleFrom(
              // UPDATE: Warna tombol disesuaikan
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}