import 'package:ditonton/data/models/televisi_model/televisi_model.dart';
import 'package:equatable/equatable.dart';

class TelevisiResponse extends Equatable {
  final List<TelevisiModel> televisiList;

  TelevisiResponse({required this.televisiList});

  factory TelevisiResponse.fromJson(Map<String, dynamic> json) => TelevisiResponse(
    televisiList: List<TelevisiModel>.from((json["results"] as List)
        .map((x) => TelevisiModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(televisiList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [televisiList];
}
