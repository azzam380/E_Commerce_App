import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/account_page.dart';
import 'pages/register_page.dart';
import 'pages/change_password_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';

void main () {
  runApp(const MyApp());
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
        },
    );
  }
}

