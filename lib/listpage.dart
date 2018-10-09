import 'dart:async';

import 'package:DYTT_FLUTTER/network_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TabType { tab1, tab2, tab3, tab4, tab5, tab6, tab7, tab8, tab9, tab10 }

class ListPage extends StatefulWidget {
  TabType _tabType;

  ListPage(TabType tabType) {
    _tabType = tabType;
  }

  @override
  State<StatefulWidget> createState() => ListPageState(_tabType);
}

class ListPageState extends State<ListPage> with WidgetsBindingObserver {
  TabType _tabType;

  NetworkApi _networkApi = NetworkApi();

  int _currentPage = 1;

  List<MovieDetail> _data = List();

  ListPageState(this._tabType);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return Center(child: Text("加载数据中......"));
    }
    var listView = ListView.builder(
          itemBuilder: (context, i) {
            if (i >= _data.length) {
              return null;
            }
            MovieDetail content = _data[i];
            return _buildItem(content, i);
          },
        );
    return RefreshIndicator(
        child: listView,
        onRefresh: _handleRefresh);
  }

  Future<Null> _handleRefresh() async {
    _currentPage = 1;

    var list =
        await _networkApi.fetchMovieList(getCategoryIdByTab(), _currentPage);

    setState(() {
      _data.addAll(list);
    });

    return null;
  }

  void loadData() {
    _networkApi.fetchMovieList(getCategoryIdByTab(), _currentPage).then((list) {
      setState(() {
        _data.addAll(list);
      });
    });
  }

  Widget _buildItem(MovieDetail movie, int i) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(10.0),
            child: Row(children: <Widget>[
              new Image.asset(
                "images/default_video.png",
                width: 150.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      height: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            movie.name ?? "",
                            softWrap: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          Container(
                            child: Text(
                              movie.publishTime ?? "",
                              softWrap: false,
                              style: TextStyle(color: Colors.black38),
                            ),
                            margin: EdgeInsets.only(top: 10.0),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(movie.content ?? "",
                                softWrap: true,
                                style: TextStyle(color: Colors.black87),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )))
            ])),
        Divider(height: 2.0)
      ],
    );
  }

  int getCategoryIdByTab() {
    switch (_tabType) {
      case TabType.tab1:
        return 9;
      case TabType.tab2:
        return 10;
      case TabType.tab3:
        return 1;
      case TabType.tab4:
        return 2;
      case TabType.tab5:
        return 3;
      case TabType.tab6:
        return 4;
      case TabType.tab7:
        return 5;
      case TabType.tab8:
        return 6;
      case TabType.tab9:
        return 7;
      case TabType.tab10:
        return 8;
    }
    return 9;
  }
}
