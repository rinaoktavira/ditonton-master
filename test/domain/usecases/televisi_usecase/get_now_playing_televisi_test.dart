import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_now_playing_televisi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_television.mocks.dart';


void main() {
  late GetNowPlayingTelevisi usecase;
  late MockTelevisiRepository mockTelevisiRepository;

  setUp(() {
    mockTelevisiRepository = MockTelevisiRepository();
    usecase = GetNowPlayingTelevisi(mockTelevisiRepository);
  });

  final tTelevisi = <Televisi>[];

  test('should get list of televisi from the repository', () async {
    // arrange
    when(mockTelevisiRepository.getNowPlayingTelevisi())
        .thenAnswer((_) async => Right(tTelevisi));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTelevisi));
  });
}