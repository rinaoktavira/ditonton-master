import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi_detail.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';

class RemoveWatchlistTelevisi {
  final TelevisiRepository repository;

  RemoveWatchlistTelevisi(this.repository);

  Future<Either<Failure, String>> execute(TelevisiDetail televisi) {
    return repository.removeWatchlistTelevisi(televisi);
  }
}