import 'package:sqflite/sqlite_api.dart';
import 'package:toko_baju/models/transaksi.dart';
import 'package:toko_baju/models/baju.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasetoko {
  static final Databasetoko instance = Databasetoko._init();
  Databasetoko._init();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('toko.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const sql = '''
    create  Table $tableBaju(
      ${BajuFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${BajuFields.name} TEXT NOT NULL,
      ${BajuFields.diskripsi} TEXT NOT NULL,
      ${BajuFields.imageUrl} TEXT NOT NULL,
      ${BajuFields.harga} INTEGER NOT NULL
    )
    ''';
    await db.execute(sql);
    const sqltransaksi = '''
    create  Table $tabelTransaksi(
        ${TransaksiFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TransaksiFields.nama} TEXT NOT NULL,
        ${TransaksiFields.imageUrl} TEXT NOT NULL,
        ${TransaksiFields.harga} INTEGER NOT NULL,
        ${TransaksiFields.status} STRING NOT NULL
    )
    ''';
    await db.execute(sqltransaksi);

  }

  Future<int> insertBaju(Baju baju) async {
    final db = await instance.database;
    return await db.insert(tableBaju, baju.toJson());
  }

  Future<int> insertTransaksi(Transaksi transaksi) async {
    final db = await instance.database;
    return await db.insert(tabelTransaksi, transaksi.toJson());
  }


  Future<List<Baju>> getAllBaju() async {
    final db = await instance.database;
    final result = await db.query(tableBaju);
    return result.map((json) => Baju.fromJson(json)).toList();
  }

  Future<Baju> getNoteByIdBaju(int id) async {
    final db = await instance.database;
    final result = await db
        .query(tableBaju, where: '${BajuFields.id} = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Baju.fromJson(result.first);
    } else {
      throw Exception('id $id not found');
    }
  }

  Future<int> deleteNoteByIdBaju(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableBaju, where: '${BajuFields.id} = ?', whereArgs: [id]);
  }

  Future<List<Transaksi>> getAllTransaksi() async {
    final db = await instance.database;
    final result = await db.query(tabelTransaksi);
    return result.map((json) => Transaksi.fromJson(json)).toList();
  }

  Future<Transaksi> getNoteByIdTransaksi(int id) async {
    final db = await instance.database;
    final result = await db.query(tabelTransaksi,
        where: '${TransaksiFields.id} = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Transaksi.fromJson(result.first);
    } else {
      throw Exception('id $id not found');
    }
  }

  Future<int> deleteNoteByIdTransaksi(int id) async {
    final db = await instance.database;
    return await db.delete(tabelTransaksi,
        where: '${TransaksiFields.id} = ?', whereArgs: [id]);
  }

  Future<int> payTransaksi(Transaksi transaksi) async {
    final db = await database;
    // Update status transaksi menjadi "Selesai"
    return await db.update(
      tabelTransaksi,
      {TransaksiFields.status: 'Selesai'},
    );
  }


}
