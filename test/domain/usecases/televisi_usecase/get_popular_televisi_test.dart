import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_popular_televisi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_television.mocks.dart';



void main() {
  late GetPopularTelevisi usecase;
  late MockTelevisiRepository mockTelevisiRpository;

  setUp(() {
    mockTelevisiRpository = MockTelevisiRepository();
    usecase = GetPopularTelevisi(mockTelevisiRpository);
  });

  final tTelevisi = <Televisi>[];

  group('GetPopularTelevisi Tests', () {
    group('execute', () {
      test(
          'should get list of televisi from the repository when execute function is called',
              () async {
            // arrange
            when(mockTelevisiRpository.getPopularTelevisi())
                .thenAnswer((_) async => Right(tTelevisi));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTelevisi));
          });
    });
  });
}
