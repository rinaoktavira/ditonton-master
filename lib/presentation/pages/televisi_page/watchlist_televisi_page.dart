import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/televisi_provider/watchlist_televisi_notifier.dart';
import 'package:ditonton/presentation/widgets/televisi_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTelevisiPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-televisi';

  @override
  _WatchlistTelevisiPageState createState() => _WatchlistTelevisiPageState();
}

class _WatchlistTelevisiPageState extends State<WatchlistTelevisiPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTelevisiNotifier>(context, listen: false)
            .fetchWatchlistTelevisi());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistTelevisiNotifier>(context, listen: false)
        .fetchWatchlistTelevisi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Televisi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTelevisiNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final televisi = data.watchlistTelevisi[index];
                  return TelevisiCard(televisi);
                },
                itemCount: data.watchlistTelevisi.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}