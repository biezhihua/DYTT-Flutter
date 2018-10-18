import 'package:DYTT_FLUTTER/delayqueue.dart';
import 'package:DYTT_FLUTTER/drawerlayout.dart';
import 'package:DYTT_FLUTTER/listpage.dart';
import 'package:DYTT_FLUTTER/strings.dart';
import 'package:DYTT_FLUTTER/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

DelayQueue delayQueue = DelayQueue();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    delayQueue.start();
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primaryColor: MaterialTheme.colorPrimary,
        primaryColorDark: MaterialTheme.colorPrimaryDark,
        accentColor: MaterialTheme.colorAccent,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        drawer: DrawerLayout(),
        appBar: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Image.asset(
                "images/search.png",
                width: 32.0,
                height: 32.0,
              ),
            )
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(text: Strings.tab1),
              Tab(text: Strings.tab2),
              Tab(text: Strings.tab3),
              Tab(text: Strings.tab4),
              Tab(text: Strings.tab5),
              Tab(text: Strings.tab6),
              Tab(text: Strings.tab7),
              Tab(text: Strings.tab8),
              Tab(text: Strings.tab9),
              Tab(text: Strings.tab10),
            ],
          ),
          title: Text(Strings.appName),
        ),
        body: TabBarView(
          children: [
            Container(child: ListPage(TabType.tab1)),
            Container(child: ListPage(TabType.tab2)),
            Container(child: ListPage(TabType.tab3)),
            Container(child: ListPage(TabType.tab4)),
            Container(child: ListPage(TabType.tab5)),
            Container(child: ListPage(TabType.tab6)),
            Container(child: ListPage(TabType.tab7)),
            Container(child: ListPage(TabType.tab8)),
            Container(child: ListPage(TabType.tab9)),
            Container(child: ListPage(TabType.tab10))
          ],
        ),
      ),
    );
  }
}
