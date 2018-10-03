import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

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
          ListTile(title: Text("Item $i")),
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
