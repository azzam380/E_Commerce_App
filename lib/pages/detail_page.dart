import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

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
  String? _selectedSize;
  int? _selectedColorIndex;

  @override
  void initState() {
    super.initState();
    if (widget.product['sizes'] != null &&
        (widget.product['sizes'] as List).isNotEmpty) {
      _selectedSize = widget.product['sizes'][0];
    }
    if (widget.product['colors'] != null &&
        (widget.product['colors'] as List).isNotEmpty) {
      _selectedColorIndex = 0;
    }
  }

  void _incrementQuantity() => setState(() => _quantity++);
  void _decrementQuantity() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [_buildImageHeader(), _buildProductDetails()],
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
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          RatingBar.builder(
            initialRating: 4.5,
            itemCount: 5,
            itemSize: 25,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {},
          ),
          const SizedBox(height: 20),
          _buildSizeSelector(),
          const SizedBox(height: 20),
          _buildColorSelector(),
          const SizedBox(height: 20),
          Text(
            widget.product['description'],
            style: const TextStyle(
              fontSize: 16,
              color: secondaryTextColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // BARU: Widget untuk menampilkan pilihan ukuran
  Widget _buildSizeSelector() {
    // Mengambil data 'sizes' dari produk, jika tidak ada, gunakan list kosong
    final List<String> sizes = List<String>.from(widget.product['sizes'] ?? []);
    // Jika tidak ada data ukuran, jangan tampilkan apa-apa
    if (sizes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ukuran",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: sizes.map((size) {
            bool isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () => setState(() => _selectedSize = size),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // BARU: Widget untuk menampilkan pilihan warna
  Widget _buildColorSelector() {
    // Mengambil data 'colors' dari produk
    final List<Color> colors = List<Color>.from(widget.product['colors'] ?? []);
    // Jika tidak ada data warna, jangan tampilkan apa-apa
    if (colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Warna",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(colors.length, (index) {
            bool isSelected = _selectedColorIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = index),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  // Beri border tebal pada warna yang dipilih
                  border: isSelected
                      ? Border.all(color: primaryColor, width: 3)
                      : null,
                ),
                width: 40,
                height: 40,
                // Tampilkan ikon centang pada warna yang dipilih
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBottomBar(CartProvider cartProvider) {
    final priceString = widget.product['price'].replaceAll('\$', '');
    final price = double.tryParse(priceString) ?? 0.0;
    final totalPrice = price * _quantity;

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
          ),
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
                '\$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: _decrementQuantity,
                    ),
                    Text(
                      _quantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: _incrementQuantity,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  final selectedColorValue = _selectedColorIndex != null
                      ? (widget.product['colors'][_selectedColorIndex!]
                                as Color)
                            .value
                      : null;
                  final itemToAdd = {
                    ...widget.product,
                    'quantity': _quantity,
                    'size': _selectedSize,
                    'color': selectedColorValue,
                  };
                  cartProvider.addToCart(itemToAdd);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${widget.product['name']} (x$_quantity) ditambahkan!",
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Icon(Icons.add_shopping_cart),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
