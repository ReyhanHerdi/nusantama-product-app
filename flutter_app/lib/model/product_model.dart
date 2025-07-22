class Product {
  final int? id;
  final String nama;
  final String deskripsi;
  final String kategori;
  final String gambar;
  final String harga;

  Product({
    this.id,
    required this.nama,
    required this.deskripsi,
    required this.kategori,
    required this.gambar,
    required this.harga,
  });

  // Konversi ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'kategori': kategori,
      'gambar': gambar,
      'harga': harga,
    };
  }

  // Konversi dari Map ke objek
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      nama: map['nama'],
      deskripsi: map['deskripsi'],
      kategori: map['kategori'],
      gambar: map['gambar'],
      harga: map['harga'],
    );
  }
}
