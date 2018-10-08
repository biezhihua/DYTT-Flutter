import 'dart:async';
import 'dart:developer';

import 'package:DYTT_FLUTTER/key_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

enum TabType { tab1, tab2, tab3, tab4, tab5, tab6, tab7, tab8, tab9, tab10 }

class ListPage extends StatefulWidget {
  TabType _tabType;

  ListPage(TabType tabType) {
    _tabType = tabType;
  }

  @override
  State<StatefulWidget> createState() => _ListPageState(_tabType);
}

class _ListPageState extends State<ListPage> with WidgetsBindingObserver {
  TabType _tabType;

  List<String> _data = List();

  _ListPageState(this._tabType);

  @override
  void initState() {
    super.initState();
    log("initState");
    WidgetsBinding.instance.addObserver(this);
    loadData();
  }

  @override
  void dispose() {
    log("dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log("didChangeAppLifecycleState $state");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (context, i) {
            log("build $context $i");

            if (i >= _data.length) {
              return null;
            }

            String content = _data[i];
            return _buildItem(content, i);
          },
        ),
        onRefresh: _handleRefresh);
  }

  Future<Null> _handleRefresh() async {


    await Future.delayed(Duration(milliseconds: 1));

    setState(() {
      var now = DateTime.now();
      _data.add("biezhihua $now");
    });
    return null;
  }

  void loadData() {
    setState(() {
      var now = DateTime.now();
      _data.add("biezhihua $now");
    });
  }

  Widget _buildItem(String content, int i) {
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
                            "2018年惊悚动作《摩天营救》BD国英英双语双字",
                            softWrap: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          Container(
                            child: Text(
                              "2018-10-03",
                              softWrap: false,
                              style: TextStyle(color: Colors.black38),
                            ),
                            margin: EdgeInsets.only(top: 10.0),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                                "简介： 在香港市中心，世界上最高、结构最复杂的摩天大楼遭到破坏，危机一触即发。威尔·索耶（道恩·强森 饰）的妻子萨拉（内芙·坎贝尔 饰）和孩子们在98层被劫为人质，直接暴露在火线上。威尔，这位战争英雄、前联邦调查局救援队员，作为大楼的安保顾问，却被诬陷纵火和谋杀。他必须奋力营救家人，为自己洗脱罪名，关乎生死存亡的高空任务就此展开。",
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
}
