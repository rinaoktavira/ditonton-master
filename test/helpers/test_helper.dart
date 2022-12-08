
import 'package:ditonton/data/datasources/data_lokal/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/data_remote/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/db/database_movie_helper.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
