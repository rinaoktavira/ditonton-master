import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model_televisi.dart';
import 'package:ditonton/data/models/televisi_model/televisi_detail_model.dart';
import 'package:ditonton/data/models/televisi_model/televisi_model.dart';
import 'package:ditonton/data/repositories/televisi_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_television.mocks.dart';


void main() {
  late TelevisiRepositoryImpl repository;
  late MockTelevisiRemoteDataSource mockRemoteDataSource;
  late MockTelevisiDataLokalSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTelevisiRemoteDataSource();
    mockLocalDataSource = MockTelevisiDataLokalSource();
    repository = TelevisiRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTelevisiModel = TelevisiModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    overview:
    'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 123,
    voteCount: 789,
    firstAirDate: DateTime.parse('2000-09-11'),
    originCountry: ['originCountry','originCountry'],
    originalName: 'originalName',
    name: 'name',
    originalLanguage: 'originalLanguage',
  );

  final tTelevisi = Televisi(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 123,
    voteCount: 789,
    firstAirDate: DateTime.parse('2000-09-11'),
    originalName: 'originalName',
    originCountry: ['originCountry','originCountry'],
    name: 'name',
    originalLanguage: 'originalLanguage',
  );

  final tTelevisiModelList = <TelevisiModel>[tTelevisiModel];
  final tTelevisiList = <Televisi>[tTelevisi];

  group('Now Playing Televisi', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTelevisi())
              .thenAnswer((_) async => tTelevisiModelList);
          // act
          final result = await repository.getNowPlayingTelevisi();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTelevisi());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTelevisiList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTelevisi())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingTelevisi();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTelevisi());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTelevisi())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowPlayingTelevisi();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTelevisi());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Televisi', () {
    test('should return movie list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTelevisi())
              .thenAnswer((_) async => tTelevisiModelList);
          // act
          final result = await repository.getPopularTelevisi();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTelevisiList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTelevisi())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTelevisi();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTelevisi())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTelevisi();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Televisi', () {
    test('should return Televisi list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTelevisi())
              .thenAnswer((_) async => tTelevisiModelList);
          // act
          final result = await repository.getTopRatedTelevisi();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTelevisiList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTelevisi())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTelevisi();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTelevisi())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTelevisi();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get Televisi Detail', () {
    final tId = 1;
    final tTelevisiResponse = TelevisiDetailResponse(
      adult: false,
      backdropPath: '/hIZFG7MK4leU4axRFKJWqrjhmxZ.jpg',
      genres: [GenreModelTelevisi(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 95403,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      overview:
      'Stuck in a small Appalachian town, a young woman’s only escape from the daily grind is playing advanced video games. She is such a good player that a company sends her a new video game system to test…but it has a surprise in store. It unlocks all of her dreams of finding a purpose, romance, and glamour in what seems like a game…but it also puts her and her family in real danger.',
      popularity: 1,
      posterPath: '/ccBe5BVeibdBEQU7l6P6BubajWV.jpg',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 8.148,
      voteCount: 338,
      originalName: 'The Peripheral',
      numberOfEpisodes: 8,
      firstAirDate: '2022-10-20',
      numberOfSeasons: 1,
      name: 'The Peripheral',
    );

    test(
        'should return Televisi data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTelevisiDetail(tId))
              .thenAnswer((_) async => tTelevisiResponse);
          // act
          final result = await repository.getTelevisiDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTelevisiDetail(tId));
          expect(result, equals(Right(testTelevisiDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTelevisiDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTelevisiDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTelevisiDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTelevisiDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTelevisiDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTelevisiDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Televisi Recommendations', () {
    final tTelevisiList = <TelevisiModel>[];
    final tId = 1;

    test('should return data (televisi list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTelevisiRecommendations(tId))
              .thenAnswer((_) async => tTelevisiList);
          // act
          final result = await repository.getTelevisiRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTelevisiRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTelevisiList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTelevisiRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTelevisiRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTelevisiRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTelevisiRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTelevisiRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTelevisiRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Televisi', () {
    final tQuery = 'spiderman';

    test('should return televisi list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTelevisi(tQuery))
              .thenAnswer((_) async => tTelevisiModelList);
          // act
          final result = await repository.searchTelevisi(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTelevisiList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTelevisi(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTelevisi(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTelevisi(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTelevisi(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTelevisi(testTelevisiTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTelevisi(testTelevisiDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTelevisi(testTelevisiTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTelevisi(testTelevisiDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTelevisi(testTelevisiTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTelevisi(testTelevisiDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTelevisi(testTelevisiTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTelevisi(testTelevisiDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTelevisiById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTelevisi(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist televisi', () {
    test('should return list of Televisi', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTelevisi())
          .thenAnswer((_) async => [testTelevisiTable]);
      // act
      final result = await repository.getWatchlistTelevisi();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTelevisi]);
    });
  });
}
