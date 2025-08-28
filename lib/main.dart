import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'pages/account_page.dart';
import 'pages/register_page.dart';
import 'pages/change_password_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/list_chat.dart';
import 'pages/detail_chat.dart';
import 'pages/cart_provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
      routes: {
        'LoginPage': (context) => const LoginPage(),
        'AccountPage': (context) => const AccountPage(),
        'RegisterPage': (context) => const RegisterPage(),
        'ChangePasswordPage': (context) => const ChangePasswordPage(),
        'CartPage': (context) => const CartPage(),
        'HomePage': (context) => const HomePage(),
        'ListChat': (context) => const ListChat(),
        'ChatDetail': (context) {
          // Mengambil data (Map) yang dikirim dari ListChat
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final contactName = args['name']!;
          final contactAvatar = args['avatar']!;
          // Mengirim data ke ChatScreen
          return ChatScreen(
            contactName: contactName,
            contactAvatar: contactAvatar,
          );
        },
      },
    );
  }
}
