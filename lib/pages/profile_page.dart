import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? namaPengguna;
  String? emailPengguna;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fungsi untuk memuat data pengguna yang disimpan di SharedPreferences
  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaPengguna = prefs.getString('namaPengguna') ?? 'Nama Tidak Ditemukan';
      emailPengguna =
          prefs.getString('emailPengguna') ?? 'Email Tidak Ditemukan';
    });
  }

  // Fungsi untuk logout
  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken'); // Hapus token autentikasi
    await prefs.remove('namaPengguna'); // Hapus nama pengguna
    await prefs.remove('emailPengguna'); // Hapus email pengguna

    // Arahkan ke halaman login setelah logout
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Pengguna',
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
        backgroundColor: Color(0xFF00211D),
      ),
      backgroundColor: Color(0xFF001916),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF003933),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nama:',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.tealAccent,
                  fontFamily: 'Times New Roman'),
            ),
            SizedBox(height: 10),
            Text(
              namaPengguna ??
                  'Loading...', // Menampilkan nama pengguna yang diambil dari SharedPreferences
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: 'Times New Roman'),
            ),
            SizedBox(height: 20),
            Text(
              'Email:',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.tealAccent,
                  fontFamily: 'Times New Roman'),
            ),
            SizedBox(height: 10),
            Text(
              emailPengguna ??
                  'Loading...', // Menampilkan email pengguna yang diambil dari SharedPreferences
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: 'Times New Roman'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _logout, // Memanggil fungsi logout
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                textStyle:
                    TextStyle(fontSize: 16, fontFamily: 'Times New Roman'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
