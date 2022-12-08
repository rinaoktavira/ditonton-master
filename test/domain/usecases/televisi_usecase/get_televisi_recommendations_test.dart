import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_televisi_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_television.mocks.dart';


void main() {
  late GetTelevisiRecommendations usecase;
  late MockTelevisiRepository mockTelevisiRepository;

  setUp(() {
    mockTelevisiRepository = MockTelevisiRepository();
    usecase = GetTelevisiRecommendations(mockTelevisiRepository);
  });

  final tId = 1;
  final tTelevisi = <Televisi>[];

  test('should get list of movie recommendations from the repository',
          () async {
        // arrange
        when(mockTelevisiRepository.getTelevisiRecommendations(tId))
            .thenAnswer((_) async => Right(tTelevisi));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTelevisi));
      });
}
