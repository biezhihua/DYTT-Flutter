import 'dart:async';

import 'package:DYTT_FLUTTER/delayqueue.dart';
import 'package:DYTT_FLUTTER/detailpage.dart';
import 'package:DYTT_FLUTTER/networkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TabType { tab1, tab2, tab3, tab4, tab5, tab6, tab7, tab8, tab9, tab10 }

DelayQueue delayQueue = DelayQueue();

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

  bool _dispose = false;

  ListPageState(this._tabType);

  @override
  void initState() {
    super.initState();
    delayQueue.clear();
    WidgetsBinding.instance.addObserver(this);
    loadData();
  }

  DelayObject delayObject;

  void loadData() {
    if (delayObject != null) {
      delayQueue.remove(delayObject);
    }
    delayObject = DelayObject(_tabType.toString(), () {
      _networkApi
          .fetchMovieList(getCategoryIdByTab(), _currentPage)
          .then((list) {
        if (_dispose) {
          print("loaddata callback dispose");
          return;
        }
        print("loaddata callback ${_tabType.toString()}");
        setState(() {
          _data.addAll(list);
        });
      });
    });
    delayQueue.add(delayObject);
  }

  void updateItem(MovieDetail content) {
    if (content == null || content.isPrefect) {
      print("updateItem continue ${content.name}");
      return;
    }

    print("updateItem ${content.toJson()}");

    if (delayObject != null) {
      delayQueue.remove(delayObject);
    }
    delayObject = DelayObject(content.id.toString(), () {
      _networkApi
          .fetchMovieDetail(content.categoryId, content.id)
          .then((movie) {
        if (_dispose) {
          print("updateItem callback dispose");
          return;
        }
        setState(() {
          movie.isPrefect = true;
          var index = _data.indexOf(movie);
          if (index != -1) {
            _data[index] = movie;
          }
        });
      });
    });
    delayQueue.add(delayObject);
  }

  @override
  void dispose() {
    _dispose = true;
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

        updateItem(content);

        return _buildItem(content, i);
      },
    );
    return RefreshIndicator(child: listView, onRefresh: _handleRefresh);
  }

  Future<Null> _handleRefresh() async {
    _currentPage = 1;
    var list =
        await _networkApi.fetchMovieList(getCategoryIdByTab(), _currentPage);
    setState(() {
      _data.clear();
      _data.addAll(list);
    });
    return null;
  }

  Widget _buildItem(MovieDetail movie, int i) {
    return GestureDetector(
      onTap: () {
        print("click ${movie.name}");
        routerToDetailPager(movie);
      },
      child: Column(children: <Widget>[
        Container(
            margin: EdgeInsets.all(10.0),
            child: Row(children: <Widget>[
              movie.homePicUrl == null
                  ? Image.asset(
                      "images/default_video.png",
                      width: 150.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    )
                  : FadeInImage.assetNetwork(
                      image: movie.homePicUrl,
                      width: 150.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                      placeholder: "images/default_video.png"),
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
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12.0),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )))
            ])),
        Divider(height: 2.0)
      ]),
    );
  }

  Future routerToDetailPager(MovieDetail movie) {
    return Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return DetailPage(movie);
        },
      ),
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
