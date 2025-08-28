import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

// --- WIDGET UTAMA HALAMAN CART ---
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      color: const Color(0xFFEDECF2),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            const CartAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
              ),
              child: Column(
                children: [
                  cartProvider.cartItems.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.0),
                          child: Center(
                              child: Text("Keranjang Anda kosong.",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))),
                        )
                      : const CartItemSamples(),
                  // UPDATE: Bagian kupon dipindahkan ke bawah (CartBottomNavBar)
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CartBottomNavBar(),
      ),
    );
  }
}

// --- WIDGET UNTUK APP BAR ---
class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Row(
        children: [
          // UPDATE: Tombol kembali diaktifkan
          const SizedBox(width: 15),
          const Row(
            children: [
              Icon(Icons.shopping_cart_outlined, color: Color.fromARGB(255, 1, 177, 30)),
              SizedBox(width: 10),
              Text('My Cart',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 177, 30))),
            ],
          ),
          const Spacer(),
          PopupMenuButton(
            icon:
                const Icon(Icons.more_vert, size: 30, color: Color.fromARGB(255, 0, 0, 0)),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("Clear Cart")),
              const PopupMenuItem(value: 2, child: Text("Save for Later")),
            ],
          ),
        ],
      ),
    );
  }
}

// --- WIDGET UNTUK MENAMPILKAN ITEM DI KERANJANG (DARI PROVIDER) ---
class CartItemSamples extends StatelessWidget {
  const CartItemSamples({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Column(
      children: [
        for (int i = 0; i < cartItems.length; i++)
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8)
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(right: 15),
                  // UPDATE: Menampilkan gambar dinamis dari provider
                  child: Image.asset(cartItems[i]['image']),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // UPDATE: Menampilkan nama dinamis dari provider
                      Text(cartItems[i]['name'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5))),
                      // UPDATE: Menampilkan harga dinamis dari provider
                      Text(cartItems[i]['price'],
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5))),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => cartProvider.removeFromCart(cartItems[i]),
                      child: const Icon(Icons.delete, color: Colors.redAccent),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () => cartProvider.decrementQuantity(i),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle),
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                          cartItems[i]['quantity'].toString().padLeft(2, '0'),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5))),
                    ),
                    InkWell(
                      onTap: () => cartProvider.incrementQuantity(i),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle),
                        child: const Icon(Icons.add, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// --- WIDGET UNTUK BOTTOM NAVIGATION BAR ---
class CartBottomNavBar extends StatelessWidget {
  const CartBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: -5,
            blurRadius: 10,
            offset: const Offset(0, -5))
      ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // UPDATE: Posisi area kupon dipindahkan ke bawah
          _buildCouponSection(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              // UPDATE: Total harga dihitung otomatis dari provider
              Text(
                '\$${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              )
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 177, 30),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              child: const Text('Check Out',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
                // UPDATE: Sintaks animasi disesuaikan ke versi terbaru
                .animate(
              onPlay: (controller) {
                controller.forward(from: 0.0);
              },
            )
                .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(0.95, 0.95),
                    duration: 100.ms)
                .then()
                .scale(end: const Offset(1, 1), duration: 100.ms),
          ),
        ],
      ),
    );
  }

  // Widget untuk area kupon
  Widget _buildCouponSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10), // Memberi jarak tambahan
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Coupon Code',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 177, 30),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}