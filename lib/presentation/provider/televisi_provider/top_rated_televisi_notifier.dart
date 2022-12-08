import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_top_rated_televisi.dart';
import 'package:flutter/foundation.dart';

class TopRatedTelevisiNotifier extends ChangeNotifier {
  final GetTopRatedTelevisi getTopRatedTelevisi;

  TopRatedTelevisiNotifier({required this.getTopRatedTelevisi});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Televisi> _televisi = [];
  List<Televisi> get televisi => _televisi;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTelevisi() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTelevisi.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (televisiData) {
        _televisi = televisiData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}