import 'package:equatable/equatable.dart';

class Televisi extends Equatable {
  Televisi({
    required this.firstAirDate,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.originCountry,
    required this.name,
    required this.originalLanguage,
    required this.voteAverage,
    required this.voteCount,
  });

  Televisi.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  DateTime? firstAirDate;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<String>? originCountry;
  String? name;
  String? originalLanguage;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
    firstAirDate,
    backdropPath,
    genreIds,
    id,
    originalName,
    overview,
    popularity,
    posterPath,
    originCountry,
    name,
    originalLanguage,
    voteAverage,
    voteCount,
  ];
}
