
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playerlist/VideoModel.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.param}) : super(key: key);

  Map<String,dynamic> param;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FijkPlayer player = FijkPlayer();
  VideoModel curModel;
  bool showCover = true;
  bool hasError = false;

  ///Stream监听
  StreamSubscription _currentPosSubs;
  Duration _currentPos;

  @override
  void initState() {
    curModel = widget.param['video'];
    player.addListener(_fijkValueListener);

    super.initState();
    player.setDataSource(
      curModel.url,
      autoPlay: true,
    );

    _currentPos = player.currentPos;
    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        _currentPos = v;
      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _currentPosSubs.cancel();
    player.removeListener(_fijkValueListener);
    player.release();
  }

  void _fijkValueListener() {
    if (player.value.state == FijkState.started) {
      setState(() {
        showCover = false;
      });
    }
    if (player.value.state == FijkState.error) {
      setState(() {
        hasError = true;
      });
    }

    if (player.value.state == FijkState.completed) {
      ///仅适用m3u8播放完成重置重新载入
      player.reset().then((value) {
        player.setDataSource(curModel.url,autoPlay: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "视频详情",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        leading:Builder(builder: (context){
          return IconButton(
            icon: SizedBox(
              height: 40,
              width: 40,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            onPressed: (){
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            // splashColor: Colors.grey,
            highlightColor: Colors.grey,
          );
        }),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: FijkView(
              color: Colors.black,
              fit: FijkFit.contain,
              player: player,
            ),
          ),
          Visibility(
            visible: showCover,
            child: Container(
              // decoration: BoxDecoration(
              //   color: Colors.yellow,
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    height: MediaQuery.of(context).size.width * 9.0/16.0,
                    imageUrl: curModel.cover,
                    fit: BoxFit.contain,
                    placeholder: (context,url) {
                      return Container(
                        height: MediaQuery.of(context).size.width * 9.0/16.0,
                        color: Colors.grey[700],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: hasError,
            child: Icon(Icons.error,size: 50,),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: LinearProgressIndicator(),
            // child: Text(
            //   null == _currentPos ? "0" : "${_currentPos.toString()}",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 15.0,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ),
        ],
      ),
      // extendBody: false,
      // extendBodyBehindAppBar: true,
      // extendBody: true,
    );
  }
}