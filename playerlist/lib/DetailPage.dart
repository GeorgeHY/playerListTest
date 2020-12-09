
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

class _DetailPageState extends State<DetailPage> with WidgetsBindingObserver{
  final FijkPlayer player = FijkPlayer();
  VideoModel curModel;
  bool showCover = true;
  bool hasError = false;

  ///Stream监听
  StreamSubscription _currentPosSubs;
  StreamSubscription _currentBufferSubs;
  Duration _currentPos;
  double sliderValue = 0.0;
  double maxDuration = 0.0;
  // int bufferingPer = 0;
  // bool isBuffering = false;

  @override
  void initState() {
    curModel = widget.param['video'];
    player.setOption(FijkOption.playerCategory, "enable-accurate-seek", 1);
    player.addListener(_fijkValueListener);

    super.initState();
    player.setDataSource(
      curModel.m3u8,
      autoPlay: true,
    );

    // _currentPos = player.currentPos;
    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        sliderValue = v.inMilliseconds.toDouble();
      });
    });

    // _currentBufferSubs = player.onBufferPercentUpdate.listen((v) {
    //   ///缓冲不够100显示加载进度条,如果开始播放则隐藏
    //   setState(() {
    //     bufferingPer = v;
    //     if (v < 100) {
    //       isBuffering = true;
    //     }else{
    //       isBuffering = false;
    //     }
    //
    //   });
    // });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _currentPosSubs.cancel();
    // _currentBufferSubs.cancel();
    player.removeListener(_fijkValueListener);
    player.release();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      player.pause();
    }
  }

  void _fijkValueListener() {
    FijkValue value = player.value;

    maxDuration = value.duration.inMilliseconds.toDouble();

    if (value.state == FijkState.started) {
      setState(() {
        ///双判断，开始播放隐藏加载进度条
        // isBuffering = false;
        showCover = false;
      });
    }
    if (value.state == FijkState.error) {
      setState(() {
        hasError = true;
      });
    }

    if (value.state == FijkState.completed) {
      setState(() {
        maxDuration = 0.0;
        sliderValue = 0.0;
      });

      ///仅适用m3u8播放完成重置重新载入
      player.reset().then((value) {
        player.setDataSource(curModel.m3u8,autoPlay: true);
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
              color: Colors.black,
            ),
            child: FijkView(
              color: Colors.black,
              fit: FijkFit.contain,
              player: player,
              panelBuilder: fijkPanel2Builder(

              ),
            ),
          ),
          Positioned(

            bottom: 30,
            left: 20,
            right: 20,
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white24,
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 5,
                )
              ),
              child: Slider(
                min: 0.0,
                max: null == maxDuration ? 1.0 : maxDuration,
                value: sliderValue,
                onChangeStart: (value) {
                  player.pause();


                },
                ///onchanged必须实现，否则会影响界面渲染
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                },

                onChangeEnd: (value) {
                  player.seekTo(value.toInt()).then((value){
                    player.start();
                  });
                  // sliderValue = value;
                },
              ),
            ),
            // child: Text(
            //   null == _currentPos ? "0" : "${_currentPos.toString()}",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 15.0,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
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
                    imageUrl: curModel.screenShot,
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

          // Visibility(
          //   visible: isBuffering,
          //   child: CircularProgressIndicator(
          //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //   ),
          // ),

        ],
      ),
      // extendBody: false,
      // extendBodyBehindAppBar: true,
      // extendBody: true,
    );
  }
}