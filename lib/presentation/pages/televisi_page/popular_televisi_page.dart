import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/televisi_provider/popular_televisi_notifier.dart';
import 'package:ditonton/presentation/widgets/televisi_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTelevisiPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-televisi';

  @override
  _PopularTelevisiPageState createState() => _PopularTelevisiPageState();
}

class _PopularTelevisiPageState extends State<PopularTelevisiPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTelevisiNotifier>(context, listen: false)
            .fetchPopularTelevisi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Televisi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTelevisiNotifier>(
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
