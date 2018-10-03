import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            return Column(
              children: <Widget>[
                ListTile(title: Text("Item Type $_tabType Item $i $content ")),
                Divider(height: 2.0)
              ],
            );
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
}
