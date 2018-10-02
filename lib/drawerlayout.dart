import 'package:DYTT_FLUTTER/theme.dart';
import 'package:DYTT_FLUTTER/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                          Strings.drawerLayoutAd,
                          style: TextStyle(color: Colors.white),
                        )),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        Strings.drawerLayoutGithub,
                        softWrap: false,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]),
              decoration: BoxDecoration(color: MaterialTheme.colorPrimary)),
          ListTile(
              leading: Image.asset('images/film.png'),
              title: Text(Strings.appName),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
