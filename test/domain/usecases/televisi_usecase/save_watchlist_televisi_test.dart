import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/save_watchlist_televisi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper_television.mocks.dart';

void main() {
  late SaveWatchlistTelevisi usecase;
  late MockTelevisiRepository mockTelevisiRepository;

  setUp(() {
    mockTelevisiRepository = MockTelevisiRepository();
    usecase = SaveWatchlistTelevisi(mockTelevisiRepository);
  });

  test('should save televisi to the repository', () async {
    // arrange
    when(mockTelevisiRepository.saveWatchlistTelevisi(testTelevisiDetail))
        .thenAnswer((_) async => Right('Added to Watchlist Televisi'));
    // act
    final result = await usecase.execute(testTelevisiDetail);
    // assert
    verify(mockTelevisiRepository.saveWatchlistTelevisi(testTelevisiDetail));
    expect(result, Right('Added to Watchlist Televisi'));
  });
}
