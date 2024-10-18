import 'package:flutter/material.dart';
import '../models/pemasukan_model.dart';
import '../services/api_service.dart';

class AddPemasukan extends StatefulWidget {
  final Pemasukan? pemasukan;

  AddPemasukan({this.pemasukan});

  @override
  _AddPemasukanState createState() => _AddPemasukanState();
}

class _AddPemasukanState extends State<AddPemasukan> {
  final _formKey = GlobalKey<FormState>();
  String? source;
  int? amount;
  int? frequency;

  @override
  void initState() {
    super.initState();
    if (widget.pemasukan != null) {
      source = widget.pemasukan!.source;
      amount = widget.pemasukan!.amount;
      frequency = widget.pemasukan!.frequency;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pemasukan == null ? 'Tambah Pemasukan' : 'Edit Pemasukan',
          style: TextStyle(
            fontFamily: 'Times New Roman',
          ),
        ),
        backgroundColor: Color(0xFF00312C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: source,
                decoration: InputDecoration(
                  labelText: 'Sumber',
                  labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFF00211D),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap isi sumber pemasukan';
                  }
                  return null;
                },
                onSaved: (value) {
                  source = value;
                },
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: amount?.toString(),
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFF00211D),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap isi jumlah pemasukan';
                  }
                  return null;
                },
                onSaved: (value) {
                  amount = int.tryParse(value!);
                },
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: frequency?.toString(),
                decoration: InputDecoration(
                  labelText: 'Frekuensi',
                  labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFF00211D),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap isi frekuensi pemasukan';
                  }
                  return null;
                },
                onSaved: (value) {
                  frequency = int.tryParse(value!);
                },
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    try {
                      if (widget.pemasukan == null) {
                        await ApiService()
                            .createPemasukan(source!, amount!, frequency!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data berhasil ditambahkan')),
                        );
                      } else {
                        await ApiService().updatePemasukan(
                            widget.pemasukan!.id, source!, amount!, frequency!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data berhasil diperbarui')),
                        );
                      }

                      Navigator.of(context).pop(true);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gagal menyimpan data')),
                      );
                    }
                  }
                },
                child: Text(widget.pemasukan == null
                    ? 'Tambah Pemasukan'
                    : 'Update Pemasukan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004142),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF00100F),  
    );
  }
}
