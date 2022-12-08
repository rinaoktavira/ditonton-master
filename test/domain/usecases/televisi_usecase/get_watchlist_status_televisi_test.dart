import 'package:ditonton/domain/usecases/televisi_usecase/get_watchlist_status_televisi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_television.mocks.dart';



void main() {
  late GetWatchListStatusTelevisi usecase;
  late MockTelevisiRepository mockTelevisiRepository;

  setUp(() {
    mockTelevisiRepository = MockTelevisiRepository();
    usecase = GetWatchListStatusTelevisi(mockTelevisiRepository);
  });

  test('should get watchlist televisi status from repository', () async {
    // arrange
    when(mockTelevisiRepository.isAddedToWatchlistTelevisi(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}