import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_now_playing_televisi.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_popular_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_top_rated_televisi.dart';
import 'package:flutter/material.dart';

class TelevisiListNotifier extends ChangeNotifier {
  var _nowPlayingTelevisi = <Televisi>[];
  List<Televisi> get nowPlayingTelevisi => _nowPlayingTelevisi;

  RequestState _nowPlayingStateTelevisi = RequestState.Empty;
  RequestState get nowPlayingStateTelevisi => _nowPlayingStateTelevisi;

  var _popularTelevisi = <Televisi>[];
  List<Televisi> get popularTelevisi => _popularTelevisi;

  RequestState _popularTelevisiState = RequestState.Empty;
  RequestState get popularTelevisiState => _popularTelevisiState;

  var _topRatedTelevisi = <Televisi>[];
  List<Televisi> get topRatedTelevisi => _topRatedTelevisi;

  RequestState _topRatedTelevisiState = RequestState.Empty;
  RequestState get topRatedTelevisiState => _topRatedTelevisiState;

  String _message = '';
  String get message => _message;

  TelevisiListNotifier({
    required this.getNowPlayingTelevisi,
    required this.getPopularTelevisi,
    required this.getTopRatedTelevisi,
  });

  final GetNowPlayingTelevisi getNowPlayingTelevisi;
  final GetPopularTelevisi getPopularTelevisi;
  final GetTopRatedTelevisi getTopRatedTelevisi;

  Future<void> fetchNowPlayingTelevisi() async {
    _nowPlayingStateTelevisi = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTelevisi.execute();
    result.fold(
          (failure) {
        _nowPlayingStateTelevisi = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (televisiData) {
        _nowPlayingStateTelevisi = RequestState.Loaded;
        _nowPlayingTelevisi = televisiData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTelevisi() async {
    _popularTelevisiState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTelevisi.execute();
    result.fold(
          (failure) {
        _popularTelevisiState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (televisiData) {
        _popularTelevisiState = RequestState.Loaded;
        _popularTelevisi = televisiData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTelevisi() async {
    _topRatedTelevisiState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTelevisi.execute();
    result.fold(
          (failure) {
        _topRatedTelevisiState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (televisiData) {
        _topRatedTelevisiState = RequestState.Loaded;
        _topRatedTelevisi = televisiData;
        notifyListeners();
      },
    );
  }
}