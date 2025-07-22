import 'package:flutter/material.dart';
import 'package:flutter_app/db/db_helper.dart';
import 'package:flutter_app/model/product_model.dart';

class InputScreen extends StatefulWidget {
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _gambarController = TextEditingController();
  final _hargaController = TextEditingController();

  void _simpanProduk() async {
    if (_namaController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _kategoriController.text.isEmpty ||
        _gambarController.text.isEmpty ||
        _hargaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }
    final newProduct = Product(
      nama: _namaController.text,
      deskripsi: _deskripsiController.text,
      kategori: _kategoriController.text,
      gambar: _gambarController.text,
      harga: _hargaController.text,
    );

    await DBHelper().insertProduct(newProduct);

    Navigator.pop(context); // kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
            ),
            TextField(
              controller: _deskripsiController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            TextField(
              controller: _kategoriController,
              decoration: const InputDecoration(
                labelText: 'Kategori',
              ),
            ),
            TextField(
              controller: _gambarController,
              decoration: const InputDecoration(
                labelText: 'Gambar',
              ),
            ),
            TextField(
              controller: _hargaController,
              decoration: const InputDecoration(
                labelText: 'Harga',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _simpanProduk,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 4, 173, 144),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
