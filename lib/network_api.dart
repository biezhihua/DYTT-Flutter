import 'dart:async';
import 'dart:convert';

import 'package:DYTT_FLUTTER/key_util.dart';
import 'package:http/http.dart' as http;

class MovieListResponse {
  final int total;
  final List<MovieDetail> rows;

  MovieListResponse({this.total, this.rows});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
        total: json['total'] as int, rows: json['rows'] as List<MovieDetail>);
  }
}

class MovieDetail {
  int id;
  int categoryId;
  String name;
  String publishTime;
  String homePicUrl;
  String pics;
  String downloadUrl;
  String content;
}

class NetworkApi {
  static KeyUtils keyUtils = KeyUtils();

  Future<MovieListResponse> fetchMovieList(int categoryId, int page) async {
    var currentTime = DateTime.now().millisecondsSinceEpoch;

    var timeStamp = (currentTime / 1000).ceil();

    var imei = "";

    var key = await KeyUtils().getHeaderKey(timeStamp);

    Map<String, String> header = Map<String, String>();
    header["x-header-request-timestamp"] = timeStamp.toString();
    header["x-header-request-key"] = key;
    header["x-header-request-imei"] = "";

    Map<String, String> body = Map<String, String>();
    body["categoryId"] = categoryId.toString();
    body["page"] = page.toString();
    body["searchContent"] = "";

    final response = await http.post(
        'http://m.dydytt.net:8080/adminapi/api/movieList.json',
        headers: header,
        body: body);

    if (response.statusCode == 200) {
      return MovieListResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
