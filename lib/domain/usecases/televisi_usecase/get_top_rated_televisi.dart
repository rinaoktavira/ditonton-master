import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';

class GetTopRatedTelevisi {
  final TelevisiRepository repository;

  GetTopRatedTelevisi(this.repository);

  Future<Either<Failure, List<Televisi>>> execute() {
    return repository.getTopRatedTelevisi();
  }
}
