import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/data_lokal/televisi_data_lokal_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper_television.mocks.dart';

void main() {
  late TelevisiDataLokalSourceImpl dataSource;
  late MockDatabaseHelperTelevisi mockDatabaseHelperTelevisi;

  setUp(() {
    mockDatabaseHelperTelevisi = MockDatabaseHelperTelevisi();
    dataSource = TelevisiDataLokalSourceImpl(databaseHelperTelevisi: mockDatabaseHelperTelevisi);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockDatabaseHelperTelevisi.insertWatchlistTelevisi(testTelevisiTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.insertWatchlistTelevisi(testTelevisiTable);
          // assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelperTelevisi.insertWatchlistTelevisi(testTelevisiTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.insertWatchlistTelevisi(testTelevisiTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelperTelevisi.removeWatchlistTelevisi(testTelevisiTable))
              .thenAnswer((_) async => 1);
          // act
          final result = await dataSource.removeWatchlistTelevisi(testTelevisiTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelperTelevisi.removeWatchlistTelevisi(testTelevisiTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeWatchlistTelevisi(testTelevisiTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get Televisi Detail By Id', () {
    final tId = 1;

    test('should return Televisi Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTelevisi.getTelevisiById(tId))
          .thenAnswer((_) async => testTelevisiMap);
      // act
      final result = await dataSource.getTelevisiById(tId);
      // assert
      expect(result, testTelevisiTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTelevisi.getTelevisiById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTelevisiById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Televisi', () {
    test('should return list of TelevisiTable from database', () async {
      // arrange
      when(mockDatabaseHelperTelevisi.getWatchlistTelevisi())
          .thenAnswer((_) async => [testTelevisiMap]);
      // act
      final result = await dataSource.getWatchlistTelevisi();
      // assert
      expect(result, [testTelevisiTable]);
    });
  });
}
