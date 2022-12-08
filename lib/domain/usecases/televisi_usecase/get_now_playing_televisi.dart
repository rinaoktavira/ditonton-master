import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetNowPlayingTelevisi {
  final TelevisiRepository repository;

  GetNowPlayingTelevisi(this.repository);

  Future<Either<Failure, List<Televisi>>> execute() {
    return repository.getNowPlayingTelevisi();
  }
}
