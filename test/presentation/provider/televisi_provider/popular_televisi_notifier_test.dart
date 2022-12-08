import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_popular_televisi.dart';
import 'package:ditonton/presentation/provider/televisi_provider/popular_televisi_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_televisi_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTelevisi])
void main() {
  late MockGetPopularTelevisi mockGetPopularTelevisi;
  late PopularTelevisiNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTelevisi = MockGetPopularTelevisi();
    notifier = PopularTelevisiNotifier(mockGetPopularTelevisi)
      ..addListener(() {
        listenerCallCount++;
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
    originalName: 'origin_name',
    originCountry: ['origin country','origin country'],
    name: 'name',
    originalLanguage: 'origin_language',
  );

  final tTelevisiList = <Televisi>[tTelevisi];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTelevisi.execute())
        .thenAnswer((_) async => Right(tTelevisiList));
    // act
    notifier.fetchPopularTelevisi();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change televisi data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTelevisi.execute())
        .thenAnswer((_) async => Right(tTelevisiList));
    // act
    await notifier.fetchPopularTelevisi();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.televisi, tTelevisiList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTelevisi.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTelevisi();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
