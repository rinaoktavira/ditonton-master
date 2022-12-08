import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_televisi_helper.dart';
import 'package:ditonton/data/models/televisi_model/televisi_table.dart';

abstract class TelevisiDataLokalSource {
  Future<String> insertWatchlistTelevisi(TelevisiTable tv);
  Future<String> removeWatchlistTelevisi(TelevisiTable tv);
  Future<TelevisiTable?> getTelevisiById(int id);
  Future<List<TelevisiTable>> getWatchlistTelevisi();
}

class TelevisiDataLokalSourceImpl implements TelevisiDataLokalSource {
  final DatabaseHelperTelevisi databaseHelperTelevisi;

  TelevisiDataLokalSourceImpl({required this.databaseHelperTelevisi});

  @override
  Future<String> insertWatchlistTelevisi(TelevisiTable televisi) async {
    try {
      await databaseHelperTelevisi.insertWatchlistTelevisi(televisi);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTelevisi(TelevisiTable televisi) async {
    try {
      await databaseHelperTelevisi.removeWatchlistTelevisi(televisi);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TelevisiTable?> getTelevisiById(int id) async {
    final result = await databaseHelperTelevisi.getTelevisiById(id);
    if (result != null) {
      return TelevisiTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TelevisiTable>> getWatchlistTelevisi() async {
    final result = await databaseHelperTelevisi.getWatchlistTelevisi();
    return result.map((data) => TelevisiTable.fromMap(data)).toList();
  }
}
