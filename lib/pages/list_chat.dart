import 'package:flutter/material.dart';

class ListChat extends StatelessWidget {
  const ListChat({super.key});

  @override
  Widget build(BuildContext context) {
    // UPDATE: Data chat sekarang memiliki 'unread' count
    final List<Map<String, String>> chats = [
      {'name': 'Nike Official', 'message': 'Segera Memesan Sebelum Kehabisan.', 'time': '12:30', 'avatar': 'assets/images/items/3.jpeg', 'unread': '2'},
      {'name': 'Adidas Official', 'message': 'Hallo, Selamat Datang Di Toko Kami.', 'time': '12:05', 'avatar': 'assets/images/items/2.jpeg', 'unread': '0'},
      {'name': 'Gadget Store', 'message': 'Terima kasih telah berbelanja!', 'time': 'Kemarin', 'avatar': 'assets/images/items/4.jpeg', 'unread': '0'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color(0xFF4C53A5))),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                TextButton(onPressed: () {}, child: const Text('Semua', style: TextStyle(color: Color(0xFF4C53A5), fontWeight: FontWeight.bold, fontSize: 16))),
                const SizedBox(width: 10),
                TextButton(onPressed: () {}, child: const Text('Belum Dibaca', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 16))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage(chat['avatar']!), radius: 28),
                  title: Text(chat['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(chat['message']!, maxLines: 1, overflow: TextOverflow.ellipsis),
                  // UPDATE 5.3.4: Tampilkan indikator pesan belum dibaca
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(chat['time']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 5),
                      if (chat['unread'] != '0')
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: Text(chat['unread']!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  onTap: () {
                    // UPDATE 5.3.5: Kirim data nama dan avatar
                    Navigator.pushNamed(context, 'ChatDetail', arguments: {
                      'name': chat['name']!,
                      'avatar': chat['avatar']!,
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}