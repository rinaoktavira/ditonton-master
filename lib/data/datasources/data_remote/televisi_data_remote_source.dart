import 'dart:convert';

import 'package:ditonton/data/models/televisi_model/televisi_detail_model.dart';
import 'package:ditonton/data/models/televisi_model/televisi_model.dart';
import 'package:ditonton/data/models/televisi_model/televisi_respon.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class TelevisiRemoteDataSource {
  Future<List<TelevisiModel>> getNowPlayingTelevisi();
  Future<List<TelevisiModel>> getPopularTelevisi();
  Future<List<TelevisiModel>> getTopRatedTelevisi();
  Future<TelevisiDetailResponse> getTelevisiDetail(int id);
  Future<List<TelevisiModel>> getTelevisiRecommendations(int id);
  Future<List<TelevisiModel>> searchTelevisi(String query);
}

class TelevisiRemoteDataSourceImpl implements TelevisiRemoteDataSource {
  static const API_KEY = 'api_key=6b71ad3b084c7e3fe1b6af98384ad19b';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TelevisiRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TelevisiModel>> getNowPlayingTelevisi() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TelevisiResponse.fromJson(json.decode(response.body)).televisiList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TelevisiDetailResponse> getTelevisiDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TelevisiDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TelevisiModel>> getTelevisiRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TelevisiResponse.fromJson(json.decode(response.body)).televisiList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TelevisiModel>> getPopularTelevisi() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TelevisiResponse.fromJson(json.decode(response.body)).televisiList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TelevisiModel>> getTopRatedTelevisi() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TelevisiResponse.fromJson(json.decode(response.body)).televisiList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TelevisiModel>> searchTelevisi(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TelevisiResponse.fromJson(json.decode(response.body)).televisiList;
    } else {
      throw ServerException();
    }
  }
}
