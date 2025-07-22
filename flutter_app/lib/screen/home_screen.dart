import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  List<String> data = ['Apel', 'Jeruk', 'Mangga'];

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();

    return Scaffold(
      body: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Daftar Produk',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // ListView harus di dalam Expanded/Flexible agar tidak overflow
          for(var prodct in data)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.ads_click
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                            prodct,
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text("Deskripsi")
                          ],
                        ),
                        Spacer(),
                        Text("Harga")
                      ],
                    )
                    ),
                ),
                )
        ],
      ),
      ),
    );
  }
}
