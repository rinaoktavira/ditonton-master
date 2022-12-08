import 'package:ditonton/data/models/movie_model/movie_table.dart';
import 'package:ditonton/data/models/televisi_model/televisi_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/genre_televisi.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTelevisi = Televisi(
  firstAirDate: DateTime.parse('2022-10-20'),
  backdropPath: '/hIZFG7MK4leU4axRFKJWqrjhmxZ.jpg',
  genreIds: [10765, 18],
  id: 95403,
  originalName: 'The Peripheral',
  originCountry: ['originCountry', 'originCountry'],
  overview:
      'Stuck in a small Appalachian town, a young woman’s only escape from the daily grind is playing advanced video games. She is such a good player that a company sends her a new video game system to test…but it has a surprise in store. It unlocks all of her dreams of finding a purpose, romance, and glamour in what seems like a game…but it also puts her and her family in real danger.',
  popularity: 1097.77,
  posterPath: '/ccBe5BVeibdBEQU7l6P6BubajWV.jpg',
  name: 'The Peripheral',
  originalLanguage: 'en',
  voteAverage: 8.148,
  voteCount: 338,
);

final testTelevisiList = [testTelevisi];

final testTelevisiDetail = TelevisiDetail(
  adult: false,
  backdropPath: '/hIZFG7MK4leU4axRFKJWqrjhmxZ.jpg',
  genres: [GenreTelevisi(id: 1, name: 'Action')],
  id: 95403,
  overview:
  'Stuck in a small Appalachian town, a young woman’s only escape from the daily grind is playing advanced video games. She is such a good player that a company sends her a new video game system to test…but it has a surprise in store. It unlocks all of her dreams of finding a purpose, romance, and glamour in what seems like a game…but it also puts her and her family in real danger.',
  posterPath: '/ccBe5BVeibdBEQU7l6P6BubajWV.jpg',
  voteAverage: 8.148,
  voteCount: 338,
  originalName: '1097.77',
  firstAirDate: '2022-10-20',
  numberOfEpisodes: 8,
  numberOfSeasons: 1,
  name: 'The Peripheral',
  popularity: 1097.77,
);

final testWatchlistTelevisi = Televisi.watchlist(
  id: 95403,
  name: 'The Peripheral',
  posterPath: '/ccBe5BVeibdBEQU7l6P6BubajWV.jpg',
  overview:
  'Stuck in a small Appalachian town, a young woman’s only escape from the daily grind is playing advanced video games. She is such a good player that a company sends her a new video game system to test…but it has a surprise in store. It unlocks all of her dreams of finding a purpose, romance, and glamour in what seems like a game…but it also puts her and her family in real danger.',

);

final testTelevisiTable = TelevisiTable(
  id: 95403,
  name: 'The Peripheral',
  posterPath: '/ccBe5BVeibdBEQU7l6P6BubajWV.jpg',
  overview:
  'Stuck in a small Appalachian town, a young woman’s only escape from the daily grind is playing advanced video games. She is such a good player that a company sends her a new video game system to test…but it has a surprise in store. It unlocks all of her dreams of finding a purpose, romance, and glamour in what seems like a game…but it also puts her and her family in real danger.',
);

final testTelevisiMap = {
  'id': 95403,
  'overview': 'Stuck in a small Appalachian town, a young woman’s only escape from the daily grind is playing advanced video games. She is such a good player that a company sends her a new video game system to test…but it has a surprise in store. It unlocks all of her dreams of finding a purpose, romance, and glamour in what seems like a game…but it also puts her and her family in real danger.',
  'posterPath': '/ccBe5BVeibdBEQU7l6P6BubajWV.jpg',
  'name': 'The Peripheral',
};
