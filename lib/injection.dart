import 'package:ditonton/data/datasources/data_lokal/televisi_data_lokal_source.dart';
import 'package:ditonton/data/datasources/data_remote/televisi_data_remote_source.dart';
import 'package:ditonton/data/datasources/db/database_movie_helper.dart';
import 'package:ditonton/data/datasources/data_lokal/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/data_remote/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/db/database_televisi_helper.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/televisi_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/televisi_repository.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecase/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecase/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecase/search_movies.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_now_playing_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_popular_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_televisi_detail.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_televisi_recommendations.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_top_rated_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_watchlist_status_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/get_watchlist_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/remove_watchlist_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/save_watchlist_televisi.dart';
import 'package:ditonton/domain/usecases/televisi_usecase/search_televisi.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/televisi_provider/popular_televisi_notifier.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_detail_notifier.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_list_notifier.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_search_notifier.dart';
import 'package:ditonton/presentation/provider/televisi_provider/top_rated_televisi_notifier.dart';
import 'package:ditonton/presentation/provider/televisi_provider/watchlist_televisi_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TelevisiListNotifier(
      getNowPlayingTelevisi: locator(),
      getPopularTelevisi: locator(),
      getTopRatedTelevisi: locator(),
    ),
  );
  locator.registerFactory(
    () => TelevisiDetailNotifier(
      getTelevisiDetail: locator(),
      getTelevisiRecommendations: locator(),
      getWatchListStatusTelevisi: locator(),
      saveWatchlistTelevisi: locator(),
      removeWatchlistTelevisi: locator(),
    ),
  );
  locator.registerFactory(
    () => TelevisiSearchNotifier(
      searchTelevisi: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTelevisiNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTelevisiNotifier(
      getTopRatedTelevisi: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTelevisiNotifier(
      getWatchlistTelevisi: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTelevisi(locator()));
  locator.registerLazySingleton(() => GetPopularTelevisi(locator()));
  locator.registerLazySingleton(() => GetTopRatedTelevisi(locator()));
  locator.registerLazySingleton(() => GetTelevisiDetail(locator()));
  locator.registerLazySingleton(() => GetTelevisiRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTelevisi(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTelevisi(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTelevisi(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTelevisi(locator()));
  locator.registerLazySingleton(() => GetWatchlistTelevisi(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TelevisiRepository>(
    () => TelevisiRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TelevisiRemoteDataSource>(
          () => TelevisiRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TelevisiDataLokalSource>(
          () => TelevisiDataLokalSourceImpl(databaseHelperTelevisi: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTelevisi>(() => DatabaseHelperTelevisi());

  // external
  locator.registerLazySingleton(() => http.Client());
}
