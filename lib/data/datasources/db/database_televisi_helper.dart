import 'dart:async';

import 'package:ditonton/data/models/televisi_model/televisi_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperTelevisi {
  static DatabaseHelperTelevisi? _databaseHelperTelevisi;

  DatabaseHelperTelevisi._instance() {
    _databaseHelperTelevisi = this;
  }

  factory DatabaseHelperTelevisi() =>
      _databaseHelperTelevisi ?? DatabaseHelperTelevisi._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlistTelevisi = 'watchlistTelevisi';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontonTelevisi.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTelevisi (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTelevisi(TelevisiTable televisi) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTelevisi, televisi.toJson());
  }

  Future<int> removeWatchlistTelevisi(TelevisiTable televisi) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTelevisi,
      where: 'id = ?',
      whereArgs: [televisi.id],
    );
  }

  Future<Map<String, dynamic>?> getTelevisiById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTelevisi,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTelevisi() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistTelevisi);

    return results;
  }
}
