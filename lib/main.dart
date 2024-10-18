import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Keuangan',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF002925), // Warna hijau gelap
        fontFamily: 'Times New Roman', // Font Times New Roman
        scaffoldBackgroundColor:
            Color(0xFF00100F), // Latar belakang hijau gelap
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF002925), // Warna AppBar hijau gelap
          elevation: 0, // Tanpa bayangan
          centerTitle: true, // Posisi judul di tengah
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00423A), // Warna tombol utama
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 16,
            ),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
