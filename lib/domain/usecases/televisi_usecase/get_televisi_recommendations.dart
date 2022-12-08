import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTelevisiRecommendations {
  final TelevisiRepository repository;

  GetTelevisiRecommendations(this.repository);

  Future<Either<Failure, List<Televisi>>> execute(id) {
    return repository.getTelevisiRecommendations(id);
  }
}