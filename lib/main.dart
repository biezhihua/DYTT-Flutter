import 'package:DYTT_FLUTTER/drawerlayout.dart';
import 'package:DYTT_FLUTTER/theme.dart';
import 'package:DYTT_FLUTTER/strings.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        drawer: DrawerLayout(),
        appBar: AppBar(
          bottom: TabBar(
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
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container()
          ],
        ),
      ),
    );
  }
}
