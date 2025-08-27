import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// --- 1. WIDGET UTAMA HALAMAN CART ---
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Column(
                children: [const CartItemSamples(), _buildCouponSection()],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CartBottomNavBar(),
      ),
    );
  }

  Widget _buildCouponSection() {
    // ... (Tidak ada perubahan di sini, kode Anda sudah bagus)
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
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
              backgroundColor: const Color(0xFF4C53A5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

// --- 2. WIDGET UNTUK APP BAR ---
// Tidak ada perubahan di sini
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Row(
        children: [
          const SizedBox(width: 15),
          const Row(
            children: [
              Icon(Icons.shopping_cart_outlined, color: Color(0xFF4C53A5)),
              SizedBox(width: 10),
              Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C53A5),
                ),
              ),
            ],
          ),
          const Spacer(),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
              color: Color(0xFF4C53A5),
            ),
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

// --- 3. WIDGET UNTUK MENAMPILKAN ITEM DI KERANJANG (STATEFUL) ---
// Tidak ada perubahan di sini
class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});
  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  // ... (kode _CartItemSamplesState Anda)
  final List<int> _quantities = [2, 1, 3];
  final List<bool> _itemVisible = [true, true, true];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _quantities.length; i++)
          AnimatedOpacity(
            opacity: _itemVisible[i] ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Visibility(
              visible: _itemVisible[i],
              child: Container(
                height: 110,
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(right: 15),
                      child: Image.asset("assets/images/items/${i + 1}.jpeg"),
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Name',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5),
                            ),
                          ),
                          Text(
                            '\$55',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() => _itemVisible[i] = false);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            if (_quantities[i] > 1) {
                              setState(() => _quantities[i]--);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.remove, size: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            _quantities[i].toString().padLeft(2, '0'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() => _quantities[i]++);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, size: 18),
                          ),
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
  }
}

// --- 4. WIDGET UNTUK BOTTOM NAVIGATION BAR (STATEFUL) ---
class CartBottomNavBar extends StatefulWidget {
  const CartBottomNavBar({super.key});

  @override
  State<CartBottomNavBar> createState() => _CartBottomNavBarState();
}

class _CartBottomNavBarState extends State<CartBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    // PERBAIKAN: Mengganti BottomAppBar dengan Container
    // dan menghapus tinggi tetap agar ukurannya fleksibel.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: -5,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Membuat Column setinggi kontennya
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  color: Color(0xFF4C53A5),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$165',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C53A5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child:
                ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C53A5),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      child: const Text(
                        'Check Out',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    .animate(
                      onPlay: (controller) {
                        controller.forward(from: 0.0);
                      },
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(0.95, 0.95),
                      duration: 100.ms,
                    )
                    .then()
                    .scale(end: const Offset(1, 1), duration: 100.ms),
          ),
        ],
      ),
    );
  }
}
