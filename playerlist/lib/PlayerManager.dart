import 'package:fijkplayer/fijkplayer.dart';

import 'VideoModel.dart';

enum VideoListScrollDirection {
  up,
  down,
}

class VideoListController {
  /// 构造方法
  VideoListController();

  int curPage = 1;

  List<VideoModel> dataList = [];

  bool canView = true;

  int curTargetIndex = 0;

  /// 视频列表(Map类型 controller好获取数据)
  Map<int,FijkPlayer> playerMap = {};



  /// 捕捉滑动，实现翻页
  // void setPageContrller(PageController pageController) {
  //   pageController.addListener(() {
  //     var p = pageController.page;
  //     if (p % 1 == 0) {
  //
  //       int target = p ~/ 1;
  //       if (index.value == target) return;
  //       // 播放当前的，暂停其他的
  //       var oldIndex = index.value;
  //       if (oldIndex == 0) {
  //         ///记录第一个短视频播放 优化逻辑
  //         // getVideoUrl(dataList[0]);
  //         getRecordTime(dataList[0]);
  //       }
  //       var newIndex = target;
  //       playerOfIndex(oldIndex).seekTo(0);
  //       // playerOfIndex(oldIndex).seekTo(Duration(seconds: 0));
  //       playerOfIndex(oldIndex).pause();
  //       getViews(isFirst: false);
  //       playerOfIndex(newIndex).start();
  //       ///记录当前短视频播放
  //       //getVideoUrl(dataList[newIndex]);
  //       getRecordTime(dataList[newIndex]);
  //       playerOfIndex(newIndex).addListener(_fijkValueListener);
  //       if (target >= playerList.length - 1) {
  //         ///需要加载下一页
  //         eventBus.emit(keyMoreShortVideo);
  //       }
  //
  //
  //       // playerOfIndex(newIndex).play();
  //       // 完成
  //       index.value = target;
  //     }
  //   });
  // }


  /// 获取指定index的player
  // FijkPlayer playerOfIndex(int index) => playerList[index];
  // VideoPlayerController playerOfIndex(int index) => playerList[index];

  /// 视频总数目
  // int get videoCount => playerList.length;

  /// 在当前的list后面继续增加视频，并预加载封面
  addVideoInfo(List<VideoModel> list) {
    dataList.addAll(list);
    for (var info in list) {

      // playerList.add(
      //     FijkPlayer()
      //     // ..setOption(1, "probesize", 1024*10)
      //       ..setDataSource(
      //         info.m3u8,
      //         autoPlay: playerList.length == 0,
      //         showCover: true,
      //       )
      //   // ..setLoop(0),
      // );
    }
  }

  void _insertOnePlayer(VideoListScrollDirection listScrollDirection) {

    // print("===================操作前播放器数组长度${playerList.length}");
    if (listScrollDirection == VideoListScrollDirection.down) {
      //向下滚动
      if (curTargetIndex + 5 <= (dataList.length - 1)){
        int addCount = 0;
        for (int i = curTargetIndex ;i < (i + 5) ;i++) {
          var preVideo = dataList[i];
          if (!preVideo.isPreLoad) {
            //视频未加入播放器列表
            //向播放器Map增加新播放器
            addCount++;
            preVideo.player = FijkPlayer()
              ..setDataSource(
                preVideo.m3u8,
                autoPlay: false,
                // autoPlay: playerList.length == 0,
                //m3u8格式无法获取首帧，封面自定义
                // showCover: true,
              ).then((value) {
                preVideo.isPreLoad = true;
              });

          }else{
            //已加入播放器列表不进行操作
          }
        }
        ///释放要删除的player
        for (int i = 0 ; i < addCount; i ++) {
          var curVideo = dataList[i];
          curVideo.player.release();
          curVideo.isPreLoad = false;
        }
        ///删除数组中player
        // playerList.removeRange(0, addCount);
        // print("~~~~~~~~~~~~~操作后播放器数组长度${playerList.length}");

      }else {
        // int addCount = 0;
        // for (int i = curTargetIndex ;i < dataList.length ;i++) {
        //   var preVideo = dataList[i];
        //   if (!preVideo.isPreLoad) {
        //     //视频未加入播放器列表
        //     //向播放器数组增加新播放器
        //     addCount++;
        //     preVideo.player = FijkPlayer()
        //       ..setDataSource(
        //         preVideo.m3u8,
        //         autoPlay: playerList.length == 0,
        //         //m3u8格式无法获取首帧，封面自定义
        //         // showCover: true,
        //       ).then((value) {
        //         preVideo.isPreLoad = true;
        //       });
        //
        //   }else{
        //     //已加入播放器列表不进行操作
        //   }
        // }
        ///释放要删除的player
        // for (int i = 0 ; i < addCount; i ++) {
        //   var curPlayer = playerList[i];
        //   curPlayer.release();
        //   //释放之后将数据列表中的数据设置为未预加载状态
        //   dataList.forEach((element) {
        //     if (curPlayer.dataSource == element.m3u8) {
        //       element.isPreLoad = false;
        //     }
        //   });
        // }
        ///删除数组中player
        // playerList.removeRange(0, addCount);
        // print("~~~~~~~~~~~~~操作后播放器数组长度${playerList.length}");
      }

    }else if (listScrollDirection == VideoListScrollDirection.up) {
      //向上滚动
      if (curTargetIndex - 5 > 0){
        int addCount = 0;
        for (int i = curTargetIndex ;i > (i - 5) ;i--) {
          var preVideo = dataList[i];
          if (!preVideo.isPreLoad) {
            //视频未加入播放器列表
            //向播放器数组首增加新播放器
            addCount++;
            // playerList.insert(
            //   0,
            //     FijkPlayer()
            //       ..setDataSource(
            //         preVideo.m3u8,
            //         autoPlay: playerList.length == 0,
            //         //m3u8格式无法获取首帧，封面自定义
            //         // showCover: true,
            //       ).then((value) {
            //         preVideo.isPreLoad = true;
            //       })
            // );


          }else{
            //已加入播放器列表不进行操作
          }
        }
        ///释放要删除的player
        // for (int i = 0 ; i < addCount; i ++) {
        //   var curPlayer = playerList[playerList.length - 1 - i];
        //   curPlayer.release();
        //   //释放之后将数据列表中的数据设置为未预加载状态
        //   dataList.forEach((element) {
        //     if (curPlayer.dataSource == element.m3u8) {
        //       element.isPreLoad = false;
        //     }
        //   });
        // }
        ///删除数组中player
        // playerList.removeRange(playerList.length - 1, playerList.length - 1 - addCount);
        // print("~~~~~~~~~~~~~操作后播放器数组长度${playerList.length}");

      }else {
        int addCount = 0;
        for (int i = curTargetIndex ;i == 0 ;i--) {
          var preVideo = dataList[i];
          if (!preVideo.isPreLoad) {
            //视频未加入播放器列表
            //向播放器数组增加新播放器
            addCount++;
            // playerList.insert(
            //     0,
            //     FijkPlayer()
            //       ..setDataSource(
            //         preVideo.m3u8,
            //         autoPlay: playerList.length == 0,
            //         //m3u8格式无法获取首帧，封面自定义
            //         // showCover: true,
            //       ).then((value) {
            //         preVideo.isPreLoad = true;
            //       })
            // );

          }else{
            //已加入播放器列表不进行操作
          }
        }
        ///释放要删除的player
        // for (int i = 0 ; i < addCount; i ++) {
        //   var curPlayer = playerList[playerList.length - 1 - i];
        //   curPlayer.release();
        //   //释放之后将数据列表中的数据设置为未预加载状态
        //   dataList.forEach((element) {
        //     if (curPlayer.dataSource == element.m3u8) {
        //       element.isPreLoad = false;
        //     }
        //   });
        // }
        ///删除数组中player
        // playerList.removeRange(playerList.length - 1, playerList.length - 1 - addCount);
        // print("~~~~~~~~~~~~~操作后播放器数组长度${playerList.length}");
      }

    }

  }

  // void _fijkValueListener() {
    // FijkValue value = currentPlayer.value;
    // if (currentPlayer.state == FijkState.asyncPreparing) {
    //   eventBus.emit("asyncPreparing",currentPlayer.id);
    // }


    // if (currentPlayer.state == FijkState.completed) {
      // currentPlayer.prepareAsync();
      // currentPlayer.seekTo(0);
      // currentPlayer.start();

  //   }
  //
  //
  // }

  /// 初始化
  // init(PageController pageController, List<VideoModel> initialList) {
  //   ///获取观看次数
  //   getViews(isFirst: true,pageController: pageController,initialList: initialList);
    // addVideoInfo(initialList);
    // setPageContrller(pageController);
  // }

  /// 目前的视频序号
  // ValueNotifier<int> index = ValueNotifier<int>(0);

  /// 视频列表
  // List<FijkPlayer> playerList = [];
  // List<VideoPlayerController> playerList = [];

  ///
  // FijkPlayer get currentPlayer => playerList[index.value];
  // VideoPlayerController get currentPlayer => playerList[index.value];

  // bool get isPlaying => currentPlayer.state == FijkState.started;
  // bool get isPlaying => currentPlayer.value.isPlaying;

  /// 销毁全部
  // void dispose() {
  //   // 销毁全部
  //   for (var player in playerList) {
  //     player.release();
  //   }
  //   playerList = [];
  // }


  // Future<String> getUserInfoJson() async{
  //   var userInfo;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userInfo = prefs.getString("kUserInfo");
  //   return userInfo;
  // }

  // Future<String> getToken() async{
  //   var tokenStr;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tokenStr = prefs.getString("kToken");
  //   return tokenStr;
  // }




}