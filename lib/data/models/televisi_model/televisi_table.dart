import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi_detail.dart';
import 'package:equatable/equatable.dart';

class TelevisiTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  @override
  List<Object?> get props => [id, name, posterPath, overview];

  TelevisiTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TelevisiTable.fromEntity(TelevisiDetail televisi) => TelevisiTable(
    id: televisi.id,
    name: televisi.name,
    posterPath: televisi.posterPath,
    overview: televisi.overview,
  );

  factory TelevisiTable.fromMap(Map<String, dynamic> map) => TelevisiTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  Televisi toEntity() => Televisi.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );


}