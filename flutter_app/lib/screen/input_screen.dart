import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/db_helper.dart';
import 'package:flutter_app/model/product_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class InputScreen extends StatefulWidget {
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  
  final List<String> _kategoriList = ['Makanan', 'Elektronik', 'Buku dan ATK', 'Fashion', 'Lainnya'];
  String _selectedKategori = 'Lainnya';

  void _simpanProduk() async {
    if (_namaController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _pickedImage?.path == null ||
        _hargaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }
    final newProduct = Product(
      nama: _namaController.text,
      deskripsi: _deskripsiController.text,
      kategori: _selectedKategori,
      gambar: _pickedImage!.path,
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
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: _kategoriList.map((kategori) {
                return DropdownMenuItem<String>(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedKategori = value!;
                });
              },
              validator: (value) => value == 'empty' ? 'Pilih kategori' : null,
            ),
            TextField(
              controller: _hargaController,
              decoration: const InputDecoration(
                labelText: 'Harga',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _pickedImage != null
                ? Image.file(
                    _pickedImage!,
                    height: 200,
                  )
                : const Text('Belum ada gambar'),
                ElevatedButton(
                  onPressed: _pickImage, 
                  child: Text('Upload Gambar')
                  ),
                ],
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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _pickedImage = File(pickedFile.path);
    });
  }
}
}
