import 'dart:async';
import 'dart:convert';

import 'package:DYTT_FLUTTER/key_util.dart';
import 'package:http/http.dart' as http;

class MovieDetail {
  final int id;
  final int categoryId;
  final String name;
  final String publishTime;
  final String homePicUrl;
  final String pics;
  final String downloadUrl;
  final String content;

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        categoryId = json['categoryId'],
        name = json['name'],
        publishTime = json['publishTime'],
        homePicUrl = json['homePicUrl'],
        content = json['content'],
        pics = json['pics'],
        downloadUrl = json['downloadUrl'];
}

class NetworkApi {
  static KeyUtils keyUtils = KeyUtils();

  Future<MovieDetail> fetchMovieDetail(
      int categoryId, int movieDetailId) async {
    Map<String, String> header = await getHeader();

    Map<String, String> body = Map<String, String>();
    body["categoryId"] = categoryId.toString();
    body["movieDetailId"] = movieDetailId.toString();

    final response = await http.post(
        'http://m.dydytt.net:8080/adminapi/api/movieDetail.json',
        headers: header,
        body: body);

    if (response.statusCode == 200) {
      return MovieDetail.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<MovieDetail>> fetchMovieList(int categoryId, int page) async {
    Map<String, String> header = await getHeader();

    Map<String, String> body = Map<String, String>();
    body["categoryId"] = categoryId.toString();
    body["page"] = page.toString();
    body["searchContent"] = "";

    final response = await http.post(
        'http://m.dydytt.net:8080/adminapi/api/movieList.json',
        headers: header,
        body: body);

    if (response.statusCode == 200) {
      var json2 = json.decode(response.body);
      var rows = json2['rows'] as List;
      List<MovieDetail> result = new List();
      for (int i = 0; i < rows.length; i++) {
        var row = rows[i];
        result.add(MovieDetail.fromJson(row));
      }

      return result;
    } else {
      return null;
    }
  }

  Future<Map<String, String>> getHeader() async {
    var timeStamp = (DateTime.now().millisecondsSinceEpoch / 1000).ceil();
    var key = await KeyUtils().getHeaderKey(timeStamp);
    Map<String, String> header = Map<String, String>();
    header["x-header-request-timestamp"] = timeStamp.toString();
    header["x-header-request-key"] = key;
    header["x-header-request-imei"] = "";
    return header;
  }
}
