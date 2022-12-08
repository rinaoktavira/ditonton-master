import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi_detail.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTelevisiDetail {
  final TelevisiRepository repository;

  GetTelevisiDetail(this.repository);

  Future<Either<Failure, TelevisiDetail>> execute(int id) {
    return repository.getTelevisiDetail(id);
  }
}
