import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'cart_page.dart';
import 'account_page.dart';
import 'cart_provider.dart';
import 'detail_page.dart';

// UPDATE: Mendefinisikan tema warna agar konsisten
const Color primaryColor = Color(0xFF01B11E);
const Color secondaryColor = Colors.black;
const Color accentColor = Color(0xFF01B11E);

// --- WIDGET UTAMA (NAVIGATION & PAGEVIEW) ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomePageContent(),
    const CartPage(),
    const AccountPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        // UPDATE: Warna disesuaikan dengan tema baru
        color: primaryColor,
        buttonBackgroundColor: accentColor,
        height: 60,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: _currentIndex == 0 ? Colors.white : Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: _currentIndex == 1 ? Colors.white : Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: _currentIndex == 2 ? Colors.white : Colors.white,
          ),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

// --- KONTEN UTAMA DARI HOMEPAGE (STATEFUL) ---
class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final List<Map<String, dynamic>> _allProducts = [
    {
      'name': 'Helm Keren',
      'description':
          'Desain aerodinamis untuk performa maksimal dan kenyamanan harian.',
      'price': '\$75',
      'image': 'assets/images/items/1.jpeg',
      'sizes': ['M', 'L', 'XL'],
      'colors': [Colors.black, Colors.grey.shade700, Colors.redAccent],
    },
    {
      'name': 'Sepatu Lari',
      'description':
          'Bantalan responsif dan ringan, ideal untuk jogging dan gaya kasual.',
      'price': '\$55',
      'image': 'assets/images/items/2.jpeg',
      'sizes': ['39', '40', '41', '42', '43'],
      'colors': [Colors.white, Colors.black, Colors.blueAccent],
    },
    {
      'name': 'Sepatu Futsal',
      'description':
          'Gaya retro klasik dengan warna ikonik yang serbaguna dan nyaman.',
      'price': '\$63',
      'image': 'assets/images/items/3.jpeg',
      'sizes': ['39', '40', '41', '42', '43'],
      'colors': [Colors.deepOrange, Colors.brown, Colors.blueAccent],
    },
    {
      'name': 'Handphone',
      'description':
          'Kamera kualitas pro dan performa flagship untuk gaming dan kreasi.',
      'price': '\$97',
      'image': 'assets/images/items/4.jpeg',
      'sizes': ['39', '40', '41', '42', '43'],
      'colors': [Colors.grey, Colors.black, Colors.blueAccent],
    },
  ];

  List<Map<String, dynamic>> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts
            .where((product) => product['name'].toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFFEDECF2)),
          ListView(
            children: [
              const HomeAppBar(),
              Container(
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFFEDECF2),
                  // UPDATE: Mengembalikan sudut melengkung agar lebih menarik
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search here...",
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.camera_alt,
                            size: 27,
                            color: secondaryColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    const CategoriesWidget(),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Produk Terlaris",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                          Icon(Icons.filter_list, color: secondaryColor),
                        ],
                      ),
                    ),
                    ItemsWidget(products: _filteredProducts),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- WIDGET UNTUK APP BAR DI HOME ---
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 30, color: secondaryColor),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Indopedia',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          const Spacer(),
          badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
            badgeContent: const Text(
              '3',
              style: TextStyle(color: Colors.white),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'ListChat');
              },
              child: const Icon(
                Icons.message_sharp,
                size: 32,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET UNTUK KATEGORI ---
class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Pakaian',
      'Makanan',
      'Skincare',
      'Elektronik',
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/categories/${i + 1}.jpg',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    categories[i],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// --- WIDGET UNTUK DAFTAR PRODUK ---
class ItemsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const ItemsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return products.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                "Produk tidak ditemukan.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '-50%',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.favorite_border, color: Colors.red),
                      ],
                    ),
                    // UPDATE: Navigasi ke halaman detail produk diaktifkan
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'DetailPage',
                          arguments: product,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Image.asset(
                          product['image'],
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product['description'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['price'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cartProvider.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${product['name']} ditambahkan ke keranjang!",
                                  ),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.shopping_cart,
                              size: 20,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
