import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';

class SearchTelevisi {
  final TelevisiRepository repository;

  SearchTelevisi(this.repository);

  Future<Either<Failure, List<Televisi>>> execute(String query) {
    return repository.searchTelevisi(query);
  }
}
