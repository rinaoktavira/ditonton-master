import 'package:ditonton/domain/entities/genre_televisi.dart';
import 'package:equatable/equatable.dart';

class GenreModelTelevisi extends Equatable {
  GenreModelTelevisi({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModelTelevisi.fromJson(Map<String, dynamic> json) => GenreModelTelevisi(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  GenreTelevisi toEntity() {
    return GenreTelevisi(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
