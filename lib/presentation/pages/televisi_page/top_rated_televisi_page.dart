import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/televisi_provider/top_rated_televisi_notifier.dart';
import 'package:ditonton/presentation/widgets/televisi_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTelevisiPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-televisi';

  @override
  _TopRatedTelevisiPageState createState() => _TopRatedTelevisiPageState();
}

class _TopRatedTelevisiPageState extends State<TopRatedTelevisiPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTelevisiNotifier>(context, listen: false)
            .fetchTopRatedTelevisi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Televisi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTelevisiNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final televisi = data.televisi[index];
                  return TelevisiCard(televisi);
                },
                itemCount: data.televisi.length,
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
}