import 'package:DYTT_FLUTTER/networkapi.dart';
import 'package:DYTT_FLUTTER/theme.dart';
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
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.movie.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                color: MaterialTheme.colorPrimary,
                child: Center(
                  child: widget.movie.homePicUrl == null
                      ? Image.asset(
                          "images/default_video.png",
                          width: 150.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        )
                      : FadeInImage.assetNetwork(
                          image: widget.movie.homePicUrl,
                          width: 150.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                          placeholder: "images/default_video.png"),
                ),
                height: 300.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: widget.movie.content == null
                    ? Text("还没有内容!\r\n请检查网络!")
                    : Stack(
                        children: <Widget>[
                          Positioned(
                              child: FloatingActionButton(
                                  child: Image.asset(
                                    "images/download.png",
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                  onPressed: () {
                                    print('FAB tapped!');
                                  },
                                  backgroundColor: Colors.grey),
                              right: 10.0,
                              top: 10.0),
                          Text(widget.movie.content),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
