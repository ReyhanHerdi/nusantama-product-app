import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.product.nama);
    deskripsiController = TextEditingController(text: widget.product.deskripsi);
    gambarController = TextEditingController(text: widget.product.gambar);
    hargaController = TextEditingController(text: widget.product.harga);
    _selectedKategori = widget.product.kategori;
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
              controller: gambarController,
              decoration: const InputDecoration(labelText: 'Gambar'),
            ),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.text,
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
      gambar: gambarController.text,
      harga: hargaController.text,
    );

    await DBHelper().updateProduct(updatedProduct);

    if (context.mounted) Navigator.pop(context, true);
  }
}
