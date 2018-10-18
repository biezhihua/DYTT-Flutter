import 'package:DYTT_FLUTTER/networkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  final MovieDetail movie;

  DetailPage(this.movie);

  @override
  State<StatefulWidget> createState() {
    return DetailPageState();
  }
}

class DetailPageState extends State<DetailPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.movie.name),
      ),
    );
  }
}
