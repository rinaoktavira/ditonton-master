import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/search_televisi.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'televisi_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTelevisi])
void main() {
  late TelevisiSearchNotifier provider;
  late MockSearchTelevisi mockSearchTelevisi;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTelevisi = MockSearchTelevisi();
    provider = TelevisiSearchNotifier(searchTelevisi: mockSearchTelevisi)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTelevisiModel = Televisi(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: null,
    originalName: 'original_name',
    originCountry: ['origin_country','origin_country'],
    name: 'name',
    originalLanguage: 'original_language',
  );

  final tTelevisiList = <Televisi>[tTelevisiModel];
  final tQuery = 'spiderman';

  group('search televisi', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTelevisi.execute(tQuery))
          .thenAnswer((_) async => Right(tTelevisiList));
      // act
      provider.fetchTelevisiSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
            () async {
          // arrange
          when(mockSearchTelevisi.execute(tQuery))
              .thenAnswer((_) async => Right(tTelevisiList));
          // act
          await provider.fetchTelevisiSearch(tQuery);
          // assert
          expect(provider.state, RequestState.Loaded);
          expect(provider.searchResult, tTelevisiList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTelevisi.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTelevisiSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
