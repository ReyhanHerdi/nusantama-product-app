import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_helper.dart';
import '../model/product_model.dart';

class EditScreen extends StatefulWidget {
  final Product product;

  const EditScreen({super.key, required this.product});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController namaController;
  late TextEditingController deskripsiController;
  late TextEditingController kategoriController;
  late TextEditingController gambarController;
  late TextEditingController hargaController;

  final List<String> _kategoriList = ['Makanan', 'Elektronik', 'Buku dan ATK', 'Fashion', 'Lainnya'];
    String _selectedKategori = 'Lainnya';

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.product.nama);
    deskripsiController = TextEditingController(text: widget.product.deskripsi);
    hargaController = TextEditingController(text: widget.product.harga);
    _selectedKategori = widget.product.kategori;
    _pickedImage = widget.product.gambar.isNotEmpty
      ? File(widget.product.gambar)
      : null;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: deskripsiController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
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
              controller: hargaController,
              decoration: const InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.text,
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
                onPressed: _simpanEdit,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 4, 173, 144))
                ),
                child: const Text('Edit', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _simpanEdit() async {


    final updatedProduct = Product(
      id: widget.product.id,
      nama: namaController.text,
      deskripsi: deskripsiController.text,
      kategori: _selectedKategori,
      gambar: _pickedImage!.path,
      harga: hargaController.text,
    );

    await DBHelper().updateProduct(updatedProduct);

    if (context.mounted) Navigator.pop(context, true);
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
