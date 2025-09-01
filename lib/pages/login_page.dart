import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Definisikan warna-warna untuk tema gelap agar mudah diubah
  static const Color primaryTextColor = Colors.white;
  static const Color secondaryTextColor = Colors.white;
  static const Color iconColor = Colors.white;
  static const Color borderColor = Colors.white;
  static const Color focusedBorderColor = Colors.white;
  static const Color buttonColor = Color(0xFF01B11E);

  @override
  Widget build(BuildContext context) {
    // 1. Latar belakang utama diubah menjadi hitam
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                Image.asset('assets/images/Logo.jpg', height: 80),
                const SizedBox(height: 20),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 30),
                _buildLoginButton(context),
                const SizedBox(height: 20),
                _buildSignUpLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            // 2. Warna teks diubah menjadi putih
            color: primaryTextColor,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Login to continue',
          // 2. Warna teks diubah menjadi putih pudar
          style: TextStyle(fontSize: 18, color: secondaryTextColor),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(color: primaryTextColor), // Warna teks input
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: secondaryTextColor),
        prefixIcon: Icon(Icons.email, color: iconColor),
        // 3. Border diubah agar terlihat di background hitam
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Format email tidak valid';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: TextStyle(color: primaryTextColor), // Warna teks input
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: secondaryTextColor),
        prefixIcon: Icon(Icons.lock, color: iconColor),
        // 3. Border diubah agar terlihat
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            // 2. Warna ikon diubah
            color: iconColor,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pushReplacementNamed(context, 'HomePage');
        }
      },
      style: ElevatedButton.styleFrom(
        // 2. Warna tombol diubah agar kontras
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: primaryTextColor, fontSize: 18),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, 'RegisterPage');
      },
      child: const Text(
        'Don\'t have an account? Sign Up',
        // 2. Warna teks diubah menjadi putih
        style: TextStyle(color: primaryTextColor),
      ),
    );
  }
}