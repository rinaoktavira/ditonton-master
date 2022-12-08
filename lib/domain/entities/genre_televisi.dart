import 'package:equatable/equatable.dart';

class GenreTelevisi extends Equatable {
  GenreTelevisi({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
