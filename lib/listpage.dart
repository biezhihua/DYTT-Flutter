import 'dart:async';

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

class _ListPageState extends State<ListPage> {
  TabType tabType;

  _ListPageState(this.tabType);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView(children: _getItems()), onRefresh: _handleRefresh);
  }

  var _count = 0;

  List<Widget> _getItems() {
    var items = <Widget>[];
    for (int i = _count; i < _count + 10; i++) {
      var item = Column(
        children: <Widget>[
          ListTile(title: Text("Item Type $tabType Item $i")),
          Divider(height: 2.0)
        ],
      );
      items.add(item);
    }
    return items;
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _count += 5;
    });
    return null;
  }
}
