import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';

class GetPopularTelevisi {
  final TelevisiRepository repository;

  GetPopularTelevisi(this.repository);

  Future<Either<Failure, List<Televisi>>> execute() {
    return repository.getPopularTelevisi();
  }
}