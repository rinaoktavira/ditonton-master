import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_page/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie_page/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie_page/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie_page/search_page.dart';
import 'package:ditonton/presentation/pages/movie_page/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie_page/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/home_televisi_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/popular_televisi_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/search_televisi_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/televisi_detail_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/top_rated_televisi_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/watchlist_televisi_page.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        ChangeNotifierProvider(
          create: (_) => di.locator<TelevisiListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TelevisiDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TelevisiSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTelevisiNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTelevisiNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTelevisiNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {

            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case HomeTelevisiPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTelevisiPage());
            case PopularTelevisiPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTelevisiPage());
            case TopRatedTelevisiPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTelevisiPage());
            case TelevisiDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TelevisiDetailPage(id: id),
                settings: settings,
              );
            case SearchTelevisiPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTelevisiPage());
            case WatchlistTelevisiPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTelevisiPage());

            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
