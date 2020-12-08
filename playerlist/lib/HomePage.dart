import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playerlist/VideoModel.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoModel videoModel;

  @override
  void initState() {
    videoModel = VideoModel("https://jpg.1234567bt.com/hls/2018/08/05/mYylc92e/screenshot1.jpg", "https://m3u8.cdnpan.com/mYylc92e.m3u8");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "首页",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, "detailPage",arguments: {'video':videoModel});
          },
          color: Colors.blue,
          child: Text(
            "进入视频详情页",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}