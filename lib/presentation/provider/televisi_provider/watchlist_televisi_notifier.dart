import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_watchlist_televisi.dart';
import 'package:flutter/foundation.dart';

class WatchlistTelevisiNotifier extends ChangeNotifier {
  var _watchlistTelevisi = <Televisi>[];
  List<Televisi> get watchlistTelevisi => _watchlistTelevisi;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTelevisiNotifier({required this.getWatchlistTelevisi});

  final GetWatchlistTelevisi getWatchlistTelevisi;

  Future<void> fetchWatchlistTelevisi() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTelevisi.execute();
    result.fold(
          (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (televisiData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTelevisi = televisiData;
        notifyListeners();
      },
    );
  }
}