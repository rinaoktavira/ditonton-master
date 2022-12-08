import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/televisi_entities/televisi.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_page/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie_page/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/televisi_detail_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/popular_televisi_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/search_televisi_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/top_rated_televisi_page.dart';
import 'package:ditonton/presentation/pages/televisi_page/watchlist_televisi_page.dart';
import 'package:ditonton/presentation/provider/televisi_provider/televisi_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTelevisiPage extends StatefulWidget {
  static const ROUTE_NAME = '/home_televisi';

  const HomeTelevisiPage({Key? key}) : super(key: key);

  @override
  _HomeTelevisiPageState createState() => _HomeTelevisiPageState();
}

class _HomeTelevisiPageState extends State<HomeTelevisiPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TelevisiListNotifier>(context, listen: false)
          ..fetchNowPlayingTelevisi()
          ..fetchPopularTelevisi()
          ..fetchTopRatedTelevisi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv_outlined),
              title: Text('Televisi'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt_outlined),
              title: Text('Watchlist Televisi'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTelevisiPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTelevisiPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sedang Tayang',
                style: kHeading6,
              ),
              Consumer<TelevisiListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingStateTelevisi;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TelevisiList(data.nowPlayingTelevisi);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Tayangan Populer',
                onTap: () => Navigator.pushNamed(
                    context, PopularTelevisiPage.ROUTE_NAME),
              ),
              Consumer<TelevisiListNotifier>(builder: (context, data, child) {
                final state = data.popularTelevisiState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TelevisiList(data.popularTelevisi);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTelevisiPage.ROUTE_NAME),
              ),
              Consumer<TelevisiListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTelevisiState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TelevisiList(data.topRatedTelevisi);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TelevisiList extends StatelessWidget {
  final List<Televisi> televisi;

  TelevisiList(this.televisi);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = televisi[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TelevisiDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: televisi.length,
      ),
    );
  }
}
