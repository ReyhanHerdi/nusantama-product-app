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

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.product.nama);
    deskripsiController = TextEditingController(text: widget.product.deskripsi);
    kategoriController = TextEditingController(text: widget.product.kategori);
    gambarController = TextEditingController(text: widget.product.gambar);
    hargaController = TextEditingController(text: widget.product.harga);
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
            TextField(
              controller: kategoriController,
              decoration: const InputDecoration(labelText: 'Kategori'),
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
      kategori: kategoriController.text,
      gambar: gambarController.text,
      harga: hargaController.text,
    );

    await DBHelper().updateProduct(updatedProduct);

    if (context.mounted) Navigator.pop(context, true);
  }
}
