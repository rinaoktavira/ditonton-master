import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/presentation/pages/televisi_page/televisi_detail_page.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'televisi_detail_page_test.mocks.dart';

@GenerateMocks([TelevisiDetailNotifier])
void main() {
  late MockTelevisiDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTelevisiDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TelevisiDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when televisi not added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.televisiState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisi).thenReturn(testTelevisiDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisiRecommendations).thenReturn(<Televisi>[]);
        when(mockNotifier.isAddedToWatchlistTelevisi).thenReturn(false);

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(TelevisiDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(mockNotifier.televisiState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisi).thenReturn(testTelevisiDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisiRecommendations).thenReturn(<Televisi>[]);
        when(mockNotifier.isAddedToWatchlistTelevisi).thenReturn(true);

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(TelevisiDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.televisiState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisi).thenReturn(testTelevisiDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisiRecommendations).thenReturn(<Televisi>[]);
        when(mockNotifier.isAddedToWatchlistTelevisi).thenReturn(false);
        when(mockNotifier.watchlistMessageTelevisi).thenReturn('Added to Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TelevisiDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(mockNotifier.televisiState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisi).thenReturn(testTelevisiDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.televisiRecommendations).thenReturn(<Televisi>[]);
        when(mockNotifier.isAddedToWatchlistTelevisi).thenReturn(false);
        when(mockNotifier.watchlistMessageTelevisi).thenReturn('Failed');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TelevisiDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}