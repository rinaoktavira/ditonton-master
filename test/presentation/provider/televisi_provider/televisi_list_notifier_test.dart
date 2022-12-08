import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_now_playing_televisi.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_popular_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_top_rated_televisi.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'televisi_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTelevisi, GetPopularTelevisi, GetTopRatedTelevisi])
void main() {
  late TelevisiListNotifier provider;
  late MockGetNowPlayingTelevisi mockGetNowPlayingTelevisi;
  late MockGetPopularTelevisi mockGetPopularTelevisi;
  late MockGetTopRatedTelevisi mockGetTopRatedTelevisi;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTelevisi = MockGetNowPlayingTelevisi();
    mockGetPopularTelevisi = MockGetPopularTelevisi();
    mockGetTopRatedTelevisi = MockGetTopRatedTelevisi();
    provider = TelevisiListNotifier(
      getNowPlayingTelevisi: mockGetNowPlayingTelevisi,
      getPopularTelevisi: mockGetPopularTelevisi,
      getTopRatedTelevisi: mockGetTopRatedTelevisi,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTelevisi = Televisi(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: null,
    originalName: 'original_name',
    originCountry: ['origin_country','origin_country'],
    name: 'name',
    originalLanguage: 'original_language',
  );
  final tTVList = <Televisi>[tTelevisi];

  group('now playing televisi', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingStateTelevisi, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTelevisi.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchNowPlayingTelevisi();
      // assert
      verify(mockGetNowPlayingTelevisi.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTelevisi.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchNowPlayingTelevisi();
      // assert
      expect(provider.nowPlayingStateTelevisi, RequestState.Loading);
    });

    test('should change televisi when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTelevisi.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchNowPlayingTelevisi();
      // assert
      expect(provider.nowPlayingStateTelevisi, RequestState.Loaded);
      expect(provider.nowPlayingTelevisi, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTelevisi.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTelevisi();
      // assert
      expect(provider.nowPlayingStateTelevisi, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular televisi', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTelevisi.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchPopularTelevisi();
      // assert
      expect(provider.popularTelevisiState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change televisi data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetPopularTelevisi.execute())
              .thenAnswer((_) async => Right(tTVList));
          // act
          await provider.fetchPopularTelevisi();
          // assert
          expect(provider.popularTelevisiState, RequestState.Loaded);
          expect(provider.popularTelevisi, tTVList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTelevisi.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTelevisi();
      // assert
      expect(provider.popularTelevisiState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated televisi', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTelevisi.execute())
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTopRatedTelevisi();
      // assert
      expect(provider.topRatedTelevisiState, RequestState.Loading);
    });

    test('should change televisi data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetTopRatedTelevisi.execute())
              .thenAnswer((_) async => Right(tTVList));
          // act
          await provider.fetchTopRatedTelevisi();
          // assert
          expect(provider.topRatedTelevisiState, RequestState.Loaded);
          expect(provider.topRatedTelevisi, tTVList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTelevisi.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTelevisi();
      // assert
      expect(provider.topRatedTelevisiState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
