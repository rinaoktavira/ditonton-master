import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistTelevisi {
  final TelevisiRepository _repository;

  GetWatchlistTelevisi(this._repository);

  Future<Either<Failure, List<Televisi>>> execute() {
    return _repository.getWatchlistTelevisi();
  }
}