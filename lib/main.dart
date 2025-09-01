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
import 'pages/detail_page.dart';

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
      // UPDATE: Perbaiki dan pisahkan logika rute di sini
      routes: {
        'LoginPage': (context) => const LoginPage(),
        'AccountPage': (context) => const AccountPage(),
        'RegisterPage': (context) => const RegisterPage(),
        'ChangePasswordPage': (context) => const ChangePasswordPage(),
        'CartPage': (context) => const CartPage(),
        'HomePage': (context) => const HomePage(),
        'ListChat': (context) => const ListChat(),

        'ChatDetail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          // Lakukan konversi tipe secara eksplisit di sini juga untuk keamanan
          if (args is Map<String, String>) {
            return ChatScreen(
              contactName: args['name']!,
              contactAvatar: args['avatar']!,
            );
          }
          return const Scaffold(
            body: Center(child: Text("Error: Chat data not found")),
          );
        },

        'DetailPage': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          if (args is Map<String, dynamic>) {
            // UPDATE: Tambahkan 'as Map<String, dynamic>' untuk memastikan tipe data
            return DetailPage(product: args as Map<String, dynamic>);
          }
          return const Scaffold(
            body: Center(child: Text("Error: Product data not found")),
          );
        },
      },
    );
  }
}
