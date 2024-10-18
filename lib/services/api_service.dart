import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pemasukan_model.dart';

class ApiService {
  final String baseUrl = 'http://103.196.155.42/api/keuangan';

  Future<List<Pemasukan>> getAllPemasukan() async {
    final response = await http.get(Uri.parse('$baseUrl/pemasukan'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] is List) {
        return (jsonResponse['data'] as List)
            .map((item) => Pemasukan.fromJson(item))
            .toList();
      } else {
        throw Exception('Data tidak dalam format list');
      }
    } else {
      throw Exception('Gagal memuat pemasukan');
    }
  }

  Future<void> createPemasukan(String source, int amount, int frequency) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pemasukan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'source': source,
        'amount': amount,
        'frequency': frequency,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan pemasukan');
    }
  }

  Future<void> updatePemasukan(
      int id, String source, int amount, int frequency) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pemasukan/$id/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'source': source,
        'amount': amount,
        'frequency': frequency,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui pemasukan');
    }
  }

  Future<void> deletePemasukan(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/pemasukan/$id/delete'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus pemasukan');
    }
  }
}
