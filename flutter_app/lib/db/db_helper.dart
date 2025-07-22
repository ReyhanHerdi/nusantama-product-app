import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/product_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi dan buat database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'nusantama_produk.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE produk (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        deskripsi TEXT,
        kategori TEXT,
        gambar TEXT,
        harga TEXT
      )
    ''');
  }

  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert('produk', product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('produk');
    return result.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> updateProduct(Product product) async {
    final db = await database;
    return await db.update(
      'produk',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete(
      'produk',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}