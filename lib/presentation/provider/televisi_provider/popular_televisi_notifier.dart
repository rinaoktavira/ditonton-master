import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_popular_televisi.dart';
import 'package:flutter/foundation.dart';

class PopularTelevisiNotifier extends ChangeNotifier {
  final GetPopularTelevisi getPopularTelevisi;

  PopularTelevisiNotifier(this.getPopularTelevisi);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Televisi> _televisi = [];
  List<Televisi> get televisi => _televisi;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTelevisi() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTelevisi.execute();

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
