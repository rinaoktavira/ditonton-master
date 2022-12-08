import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:equatable/equatable.dart';

class TelevisiModel extends Equatable {
  TelevisiModel({
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

  final DateTime firstAirDate;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<String> originCountry;
  final String name;
  final String originalLanguage;
  final double voteAverage;
  final int voteCount;

  factory TelevisiModel.fromJson(Map<String, dynamic> json) => TelevisiModel(
        firstAirDate: json['first_air_data'] == ''
            ? DateTime.parse(json["first_air_date"])
            : DateTime.parse('2000-09-09 09:09:09.593918'),
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        originCountry: List<String>.from(json['origin_country'].map((e) => e)),
        name: json["name"],
        originalLanguage: json["original_language"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        'first_air_date':
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        'origin_country': List<String>.from(originCountry.map((e) => e)),
        "name": name,
        "originalLanguage": originalLanguage,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Televisi toEntity() {
    return Televisi(
      firstAirDate: this.firstAirDate,
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      originCountry: this.originCountry,
      name: this.name,
      originalLanguage: this.originalLanguage,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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
