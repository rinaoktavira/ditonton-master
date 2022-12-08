import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_watchlist_televisi.dart';
import 'package:ditonton/presentation/provider/televisi_provider/watchlist_televisi_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_televisi_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTelevisi])
void main() {
  late WatchlistTelevisiNotifier provider;
  late MockGetWatchlistTelevisi mockGetWatchlistTelevisi;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTelevisi = MockGetWatchlistTelevisi();
    provider = WatchlistTelevisiNotifier(
      getWatchlistTelevisi: mockGetWatchlistTelevisi,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  test('should change televisi data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTelevisi.execute())
        .thenAnswer((_) async => Right([testWatchlistTelevisi]));
    // act
    await provider.fetchWatchlistTelevisi();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTelevisi, [testWatchlistTelevisi]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTelevisi.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTelevisi();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
