import 'package:flutter/material.dart';
import 'package:flutter_app/screen/edit_screen.dart';
import '../db/db_helper.dart';
import '../model/product_model.dart';
import 'input_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> data = [];

  @override
  void initState() {
    super.initState();
    _loadProduk();
  }

  Future<void> _loadProduk() async {
    final hasil = await DBHelper().getAllProducts();
    setState(() {
      data = hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Produk',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 4, 173, 144)),
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputScreen()),
                    );
                    _loadProduk(); // Refresh data setelah kembali
                  },
                  child: const Text(
                    '+ Tambah',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final prodct = data[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.ads_click),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prodct.nama,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(prodct.deskripsi),
                            ],
                          ),
                          const Spacer(),
                          Text('Rp ${prodct.harga}'),
                          SizedBox(width: 8),
                          Column(
                            children: [
                              IconButton(
                              onPressed: () async {
                                await Navigator.push(
                                context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(product: prodct),
                                  ),
                                );
                                _loadProduk();
                              },
                              icon: Icon(Icons.edit)
                            ),
                            IconButton(
                              onPressed: () async {
                                await DBHelper().deleteProduct(prodct.id!);
                                setState(() {});
                                _loadProduk();
                              },
                              icon: Icon(Icons.delete)
                          )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      ),
    );
  }
}
