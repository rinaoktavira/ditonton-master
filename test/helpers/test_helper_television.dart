import 'package:ditonton/data/datasources/data_lokal/televisi_data_lokal_source.dart';
import 'package:ditonton/data/datasources/data_remote/televisi_data_remote_source.dart';
import 'package:ditonton/data/datasources/db/database_televisi_helper.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TelevisiRepository,
  TelevisiRemoteDataSource,
  TelevisiDataLokalSource,
  DatabaseHelperTelevisi,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}