import 'package:flutter/material.dart';
import '../models/pemasukan_model.dart';
import '../services/api_service.dart';
import 'add_pemasukan_page.dart';

class DetailPemasukan extends StatelessWidget {
  final Pemasukan pemasukan;

  DetailPemasukan({required this.pemasukan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Pemasukan',
          style: TextStyle(
            fontFamily: 'Times New Roman',
          ),
        ),
        backgroundColor: Color(0xFF002925), // Warna hijau gelap
      ),
      backgroundColor: Color(0xFF00100F), // Background hijau gelap
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sumber: ${pemasukan.source}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.tealAccent,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Jumlah: Rp ${pemasukan.amount}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Frekuensi: ${pemasukan.frequency}x',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddPemasukan(pemasukan: pemasukan),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      'Edit',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF00423A), // Warna tombol hijau gelap
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Konfirmasi',
                              style: TextStyle(
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                            content: Text(
                              'Apakah Anda yakin ingin menghapus pemasukan ini?',
                              style: TextStyle(
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog
                                },
                                child: Text(
                                  'Batal',
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await ApiService()
                                      .deletePemasukan(pemasukan.id);
                                  Navigator.of(context).pop(); // Tutup dialog
                                  Navigator.of(context)
                                      .pop(); // Kembali ke halaman sebelumnya
                                },
                                child: Text(
                                  'Hapus',
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text(
                      'Hapus',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
