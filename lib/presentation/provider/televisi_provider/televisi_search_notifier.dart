import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/search_televisi.dart';
import 'package:flutter/foundation.dart';

class TelevisiSearchNotifier extends ChangeNotifier {
  final SearchTelevisi searchTelevisi;

  TelevisiSearchNotifier({required this.searchTelevisi});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Televisi> _searchResult = [];
  List<Televisi> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTelevisiSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTelevisi.execute(query);
    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}