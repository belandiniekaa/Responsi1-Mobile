import 'package:flutter/material.dart';
import '../models/pemasukan_model.dart';
import '../services/api_service.dart';
import 'add_pemasukan_page.dart';
import 'detail_pemasukan.dart';
import 'login_page.dart'; 
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Pemasukan>> futurePemasukan;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    refreshPemasukan();
  }

  void refreshPemasukan() {
    setState(() {
      futurePemasukan = apiService.getAllPemasukan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xFF00211D),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF00312C), 
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aplikasi Keuangan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPemasukan()),
                        );
                        if (result == true) {
                          refreshPemasukan();
                        }
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text('Tambah Pemasukan',
                          style: TextStyle(fontFamily: 'Times New Roman')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF003933),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              const SizedBox(height: 20), 
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF001916), 
      appBar: AppBar(
        title: const Text(
          'Aplikasi Manajemen Keuangan',
          style: TextStyle(
            fontFamily: 'Times New Roman',
          ),
        ),
        backgroundColor: Color(0xFF00211D), 
      ),
      body: FutureBuilder<List<Pemasukan>>(
        future: futurePemasukan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pemasukanList = snapshot.data!;
            return ListView.builder(
              itemCount: pemasukanList.length,
              itemBuilder: (context, index) {
                final pemasukan = pemasukanList[index];
                return Card(
                  color: Color(0xFF002925),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading:
                        Icon(Icons.monetization_on, color: Colors.tealAccent),
                    title: Text(
                      pemasukan.source,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Jumlah: Rp ${pemasukan.amount}',
                      style: TextStyle(
                        color: Colors.tealAccent,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.white),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPemasukan(pemasukan: pemasukan),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
