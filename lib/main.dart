import 'package:DYTT_FLUTTER/material_theme.dart';
import 'package:DYTT_FLUTTER/strings.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: DyttStrings.appName,
      theme: ThemeData(
        primaryColor: DyttMaterialTheme.colorPrimary,
        primaryColorDark: DyttMaterialTheme.colorPrimaryDark,
        accentColor: DyttMaterialTheme.colorAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DyttStrings.appName),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Image.asset(
                            "images/icon.png",
                            width: 64.0,
                            height: 64.0,
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            DyttStrings.drawerLayoutAd,
                            style: TextStyle(color: Colors.white),
                          )),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          DyttStrings.drawerLayoutGithub,
                          softWrap: false,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ]),
                decoration:
                    BoxDecoration(color: DyttMaterialTheme.colorPrimary)),
            ListTile(
                leading: Image.asset('images/film.png'),
                title: Text(DyttStrings.appName),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
