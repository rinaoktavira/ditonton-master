import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_televisi_detail.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_televisi_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_watchlist_status_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/remove_watchlist_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/save_watchlist_televisi.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'televisi_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTelevisiDetail,
  GetTelevisiRecommendations,
  GetWatchListStatusTelevisi,
  SaveWatchlistTelevisi,
  RemoveWatchlistTelevisi,
])
void main() {
  late TelevisiDetailNotifier provider;
  late MockGetTelevisiDetail mockGetTelevisiDetail;
  late MockGetTelevisiRecommendations mockGetTelevisiRecommendations;
  late MockGetWatchListStatusTelevisi mockGetWatchlistStatusTelevisi;
  late MockSaveWatchlistTelevisi mockSaveWatchlistTelevisi;
  late MockRemoveWatchlistTelevisi mockRemoveWatchlistTelevisi;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTelevisiDetail = MockGetTelevisiDetail();
    mockGetTelevisiRecommendations = MockGetTelevisiRecommendations();
    mockGetWatchlistStatusTelevisi = MockGetWatchListStatusTelevisi();
    mockSaveWatchlistTelevisi = MockSaveWatchlistTelevisi();
    mockRemoveWatchlistTelevisi = MockRemoveWatchlistTelevisi();
    provider = TelevisiDetailNotifier(
      getTelevisiDetail: mockGetTelevisiDetail,
      getTelevisiRecommendations: mockGetTelevisiRecommendations,
      getWatchListStatusTelevisi: mockGetWatchlistStatusTelevisi,
      saveWatchlistTelevisi: mockSaveWatchlistTelevisi,
      removeWatchlistTelevisi: mockRemoveWatchlistTelevisi,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;

  final tTelevisi = Televisi(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate:  DateTime.parse('2000-09-09 09:09:09.591918'),
    originalName: 'original_name',
    originCountry: ['origin_country','origin_country'],
    name: 'name',
    originalLanguage: 'original_language',
  );
  final tTelevisiList = <Televisi>[tTelevisi];

  void _arrangeUsecase() {
    when(mockGetTelevisiDetail.execute(tId))
        .thenAnswer((_) async => Right(testTelevisiDetail));
    when(mockGetTelevisiRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTelevisiList));
  }

  group('Get Televisi Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTelevisiDetail(tId);
      // assert
      verify(mockGetTelevisiDetail.execute(tId));
      verify(mockGetTelevisiRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTelevisiDetail(tId);
      // assert
      expect(provider.televisiState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change televisi when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTelevisiDetail(tId);
      // assert
      expect(provider.televisiState, RequestState.Loaded);
      expect(provider.televisi, testTelevisiDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation televisi when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTelevisiDetail(tId);
          // assert
          expect(provider.televisiState, RequestState.Loaded);
          expect(provider.televisiRecommendations, tTelevisiList);
        });
  });

  group('Get Televisi Recommendations', () {
    test('should get data from the use case', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTelevisiDetail(tId);
      // assert
      verify(mockGetTelevisiRecommendations.execute(tId));
      expect(provider.televisiRecommendations, tTelevisi);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTelevisiDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.televisiRecommendations, tTelevisi);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTelevisiDetail.execute(tId))
          .thenAnswer((_) async => Right(testTelevisiDetail));
      when(mockGetTelevisiRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTelevisiDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusTelevisi.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatusTelevisi(1);
      // assert
      expect(provider.isAddedToWatchlistTelevisi, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTelevisi.execute(testTelevisiDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusTelevisi.execute(testTelevisiDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTelevisi(testTelevisiDetail);
      // assert
      verify(mockSaveWatchlistTelevisi.execute(testTelevisiDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTelevisi.execute(testTelevisiDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatusTelevisi.execute(testTelevisiDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTelevisi(testTelevisiDetail);
      // assert
      verify(mockRemoveWatchlistTelevisi.execute(testTelevisiDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTelevisi.execute(testTelevisiDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTelevisi.execute(testTelevisiDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTelevisi(testTelevisiDetail);
      // assert
      verify(mockGetWatchlistStatusTelevisi.execute(testTelevisiDetail.id));
      expect(provider.isAddedToWatchlistTelevisi, true);
      expect(provider.watchlistMessageTelevisi, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTelevisi.execute(testTelevisiDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatusTelevisi.execute(testTelevisiDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTelevisi(testTelevisiDetail);
      // assert
      expect(provider.watchlistMessageTelevisi, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTelevisiDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTelevisiRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTelevisiList));
      // act
      await provider.fetchTelevisiDetail(tId);
      // assert
      expect(provider.televisiState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
