import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'cart_page.dart';
import 'account_page.dart';

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
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 76, 85, 165),
        buttonBackgroundColor: const Color.fromARGB(203, 0, 255, 234),
        height: 60,
        // UPDATE 4.3.1: Tambahkan highlight pada ikon navigasi yang aktif
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: _currentIndex == 0 ? Colors.blueAccent : Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: _currentIndex == 1 ? Colors.blueAccent : Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: _currentIndex == 2 ? Colors.blueAccent : Colors.white,
          ),
        ],
        index: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

// --- KONTEN UTAMA DARI HOMEPAGE ---
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HomeAppBar(),
          Container(
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                // UPDATE 4.3.2: Tambahkan ikon pencarian di sebelah kiri
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
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here...",
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.camera_alt,
                        size: 27,
                        color: Color(0xFF4C53A5),
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
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                const CategoriesWidget(),

                // UPDATE 4.3.5: Tambahkan ikon filter
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
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      Icon(Icons.filter_list, color: Color(0xFF4C53A5)),
                    ],
                  ),
                ),
                const ItemsWidget(),
              ],
            ),
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
          const Icon(Icons.sort, size: 30, color: Color(0xFF4C53A5)),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Ecoglobal',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
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
              onTap: () {},
              child: const Icon(
                Icons.notifications,
                size: 32,
                color: Color(0xFF4C53A5),
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
                      color: Color(0xFF4C53A5),
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
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> myProductName = [
      'Pakaian',
      'Makanan',
      'Skincare',
      'Elektronik',
    ];

    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: 0.68,
      children: [
        for (int i = 0; i < myProductName.length; i++)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            // UPDATE 4.3.3: Tambahkan shadow halus pada item
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
                        color: const Color(0xFF4C53A5),
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
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/images/items/${i + 1}.jpeg",
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    myProductName[i],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4C53A5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // UPDATE 4.3.4: Ubah tampilan teks deskripsi
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Write Description Product",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$55",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        size: 20,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
