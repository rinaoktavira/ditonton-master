import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi_detail.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_televisi_detail.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_televisi_recommendations.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_watchlist_status_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/remove_watchlist_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/save_watchlist_televisi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TelevisiDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTelevisiDetail getTelevisiDetail;
  final GetTelevisiRecommendations getTelevisiRecommendations;
  final GetWatchListStatusTelevisi getWatchListStatusTelevisi;
  final SaveWatchlistTelevisi saveWatchlistTelevisi;
  final RemoveWatchlistTelevisi removeWatchlistTelevisi;

  TelevisiDetailNotifier({
    required this.getTelevisiDetail,
    required this.getTelevisiRecommendations,
    required this.getWatchListStatusTelevisi,
    required this.saveWatchlistTelevisi,
    required this.removeWatchlistTelevisi,
  });

  late TelevisiDetail _televisi;
  TelevisiDetail get televisi => _televisi;

  RequestState _televisiState = RequestState.Empty;
  RequestState get televisiState => _televisiState;

  List<Televisi> _televisiRecommendations = [];
  List<Televisi> get televisiRecommendations => _televisiRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTelevisi = false;
  bool get isAddedToWatchlistTelevisi => _isAddedtoWatchlistTelevisi;

  Future<void> fetchTelevisiDetail(int id) async {
    _televisiState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTelevisiDetail.execute(id);
    final recommendationResult = await getTelevisiRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _televisiState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (televisi) {
        _recommendationState = RequestState.Loading;
        _televisi = televisi;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (televisi) {
            _recommendationState = RequestState.Loaded;
            _televisiRecommendations = televisi;
          },
        );
        _televisiState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessageTelevisi = '';
  String get watchlistMessageTelevisi => _watchlistMessageTelevisi;

  Future<void> addWatchlistTelevisi(TelevisiDetail televisi) async {
    final result = await saveWatchlistTelevisi.execute(televisi);

    await result.fold(
      (failure) async {
        _watchlistMessageTelevisi = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTelevisi = successMessage;
      },
    );

    await loadWatchlistStatusTelevisi(televisi.id);
  }

  Future<void> removeFromWatchlistTelevisi(TelevisiDetail televisi) async {
    final result = await removeWatchlistTelevisi.execute(televisi);

    await result.fold(
      (failure) async {
        _watchlistMessageTelevisi = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTelevisi = successMessage;
      },
    );

    await loadWatchlistStatusTelevisi(televisi.id);
  }

  Future<void> loadWatchlistStatusTelevisi(int id) async {
    final result = await getWatchListStatusTelevisi.execute(id);
    _isAddedtoWatchlistTelevisi = result;
    notifyListeners();
  }
}
