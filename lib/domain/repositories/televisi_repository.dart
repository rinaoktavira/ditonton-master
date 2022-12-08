import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TelevisiRepository {
  Future<Either<Failure, List<Televisi>>> getNowPlayingTelevisi();
  Future<Either<Failure, List<Televisi>>> getPopularTelevisi();
  Future<Either<Failure, List<Televisi>>> getTopRatedTelevisi();
  Future<Either<Failure, TelevisiDetail>> getTelevisiDetail(int id);
  Future<Either<Failure, List<Televisi>>> getTelevisiRecommendations(int id);
  Future<Either<Failure, List<Televisi>>> searchTelevisi(String query);
  Future<Either<Failure, String>> saveWatchlistTelevisi(TelevisiDetail televisi);
  Future<Either<Failure, String>> removeWatchlistTelevisi(TelevisiDetail televisi);
  Future<bool> isAddedToWatchlistTelevisi(int id);
  Future<Either<Failure, List<Televisi>>> getWatchlistTelevisi();
}
