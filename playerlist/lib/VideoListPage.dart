import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("测试"),
      ),
    );
  }
  // PageController _pageController = PageController();

  // VideoListController _videoListController = VideoListController();
  //
  // int curPage = 1;
  // int total = 0;
  // final int limit = 10;
  // bool isShowView = false;
  // bool canView = true;
  //
  // List<VideoModel> videoDataList = [];
  //
  // var _futureBuilderFuture;
  //
  // Future<String> getToken() async{
  //   var tokenStr = "";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tokenStr = prefs.getString("kToken");
  //   return tokenStr;
  // }
  //
  // ///获取短视频列表
  // Future getVideoList({String curTag = '10'}) async{
  //   print("============================显示状态$isShowView");
  //   var param = {'tag':'10','page':curPage,'limit':limit};
  //   NetUtil.tagVideoList(param,success: (response) async{
  //     print('''response: $response''');
  //
  //     List<VideoModel> curList1 = List<VideoModel>.from(response['data'].map((x) => VideoModel.fromJson(x)));
  //     total = response['total'];
  //
  //     await getToken().then((result) {
  //       print("$result");
  //       if (null != result && result.length > 0) {
  //         setState(() {
  //           videoDataList.addAll(curList1);
  //           _videoListController.init(
  //             _pageController,
  //             videoDataList,
  //           );
  //
  //         });
  //       }else{
  //         eventBus.emit("testTab");
  //         Navigator.of(context).pushNamedAndRemoveUntil("signInPage", ModalRoute.withName("homeTab"));
  //       }
  //     });
  //
  //
  //     // print('$data');
  //
  //   },failure: (error) {
  //
  //   });
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state != AppLifecycleState.resumed) {
  //     _videoListController.currentPlayer.pause();
  //   }
  // }
  //
  //
  //
  // @override
  // void dispose() {
  //   eventBus.off(keyListComments);
  //   eventBus.off(keyMoreShortVideo);
  //   // eventBus.off(keySwitchShortVideo);
  //   WidgetsBinding.instance.removeObserver(this);
  //   _pageController.removeListener(() { });
  //   if (null != _videoListController.playerList && _videoListController.playerList.length > 0){
  //     _videoListController.currentPlayer.pause();
  //   }
  //   // _videoListController.currentPlayer.dispose();
  //   _videoListController.dispose();
  //
  //
  //   super.dispose();
  // }
  //
  // @override
  // void deactivate() {
  //   // dispose();
  //   if (null != _videoListController.playerList && _videoListController.playerList.length > 0){
  //     _videoListController.currentPlayer.pause();
  //   }
  //
  //   // _videoListController.currentPlayer.release();
  //   _videoListController.dispose();
  //   super.deactivate();
  // }
  //
  // @override
  // void initState() {
  //   ///获取视频列表
  //   ///
  //   // _futureBuilderFuture = getVideoList();
  //   eventBus.on(keyMoreShortVideo, (arg) {
  //     loadMore();
  //   });
  //
  //   WidgetsBinding.instance.addObserver(this);
  //
  //   super.initState();
  //
  //   ///切换到短视频页面
  //   eventBus.on(keySwitchShortVideo, (arg) {
  //     isShowView = arg == 1 ? true : false;
  //     if (isShowView) {
  //       if (null != _videoListController.playerList && _videoListController.playerList.length > 0) {
  //         _videoListController.currentPlayer.start();
  //       }else {
  //         if (mounted) {
  //           setState(() {
  //             _futureBuilderFuture = getVideoList();
  //           });
  //         }
  //
  //       }
  //     }else{
  //       if (null != _videoListController.playerList && _videoListController.playerList.length > 0) {
  //         _videoListController.currentPlayer.pause();
  //       }
  //     }
  //
  //   });
  //
  //
  //   ///评论数同步
  //   eventBus.on(keyListComments, (arg) async{
  //     var args = arg as List<dynamic>;
  //     int commentCount = args.first;
  //     String videoId = args.last;
  //     // print("==========================传递参数 ${commentCount}   ${videoId}");
  //     setState(() {
  //       videoDataList.forEach((element) {
  //         if (element.videoId.toString() == videoId) {
  //           element.comments = commentCount;
  //         }
  //       });
  //     });
  //   });
  //
  //   eventBus.on(keyNoViewCount, (arg) {
  //     setState(() {
  //       canView = false;
  //     });
  //   });
  //
  //   eventBus.on(keySignOut, (arg) {
  //     if (mounted) {
  //       setState(() {
  //         videoDataList.clear();
  //         _videoListController.dispose();
  //       });
  //     }
  //
  //   });
  //
  //
  //
  // }
  //
  // void loadMore() {
  //   if (videoDataList.length < total) {
  //     curPage += 1;
  //     var param = {'tag':'10','page': curPage ,'limit':limit};
  //     NetUtil.tagVideoList(param,success: (response) async{
  //       print('''response: $response''');
  //       List<VideoModel> curList1 = List<VideoModel>.from(response['data'].map((x) => VideoModel.fromJson(x)));
  //       total = response['total'];
  //       setState(() {
  //         videoDataList.addAll(curList1);
  //         _videoListController.addVideoInfo(curList1);
  //       });
  //
  //     },failure: (error) {
  //
  //     });
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
    // double a = MediaQuery.of(context).size.aspectRatio;
    // bool hasBottomPadding = a < 0.55;
    //
    // bool hasBackground = hasBottomPadding;
    // hasBackground = tabBarType != TikTokPageTag.home;
    // if (hasBottomPadding) {
    //   hasBackground = true;
    // }
    // return FutureBuilder(
    //   future: _futureBuilderFuture,
    //   builder: (context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done && videoDataList.length > 0) {
    //       return Scaffold(
    //         ///避免键盘弹起界面布局上移
    //         resizeToAvoidBottomPadding: false,
    //         body: Stack(
    //           // index: currentPage == null ? 0 : 1,
    //           children: <Widget>[
    //             RefreshIndicator(
    //               onRefresh: () async {
    //                 print("刷新");
    //                 var param = {'tag':'10','page':'1','limit':limit};
    //                 NetUtil.tagVideoList(param,success: (response) async{
    //                   print('''response: $response''');
    //                   List<VideoModel> curList1 = List<VideoModel>.from(response['data'].map((x) => VideoModel.fromJson(x)));
    //                   total = response['total'];
    //                   setState(() {
    //                     videoDataList.clear();
    //                     _videoListController.dispose();
    //                     videoDataList.addAll(curList1);
    //                     _videoListController.addVideoInfo(curList1);
    //                   });
    //
    //                   // print('$data');
    //
    //                 },failure: (error) {
    //
    //                 });
    //               },
    //               child: PageView.builder(
    //                 onPageChanged: (page){
    //                   print("～～～～～～～～～～～～～～～～$page页数");
    //                   setState(() {
    //                   });
    //                 },
    //                 key: Key('home'),
    //                 controller: _pageController,
    //                 allowImplicitScrolling: true,
    //                 pageSnapping: true,
    //                 physics: ClampingScrollPhysics(),
    //                 scrollDirection: Axis.vertical,
    //                 itemCount: _videoListController.videoCount,
    //                 itemBuilder: (context, i) {
    //                   // 拼一个视频组件出来
    //                   var data = videoDataList[i];
    //                   var player = _videoListController.playerOfIndex(i);
    //                   if (!canView) {
    //                     player.stop();
    //                   }
    //                   // 右侧按钮列
    //                   Widget buttons = TikTokButtonColumn(
    //                     videoModel: data,
    //                     // onAvatar: () {
    //                     // tkController.animateToPage(TikTokPagePositon.right);
    //                     // },
    //                     onFavorite: (isSeleted) {
    //                       if (isSeleted) {
    //                         likeVideoRequest(data,i);
    //                       }else {
    //                         unLikeVideoRequest(data,i);
    //                       }
    //
    //                       // showAboutDialog(context: context);
    //                     },
    //                     onComment: () {
    //                       CustomBottomSheet.showModalBottomSheet(
    //                         backgroundColor: Colors.white.withOpacity(0),
    //                         context: context,
    //                         builder: (BuildContext context) =>
    //                             TikTokCommentBottomSheet(vid: data.videoId.toString(),allCommentsCount: data.comments,pushType: 1,),
    //                       ).then((value){
    //                         print("测试关闭评论回调");
    //                         setState(() {
    //
    //                         });
    //                       });
    //                     },
                        // onShare: () {
                        //   var param = {'tag':'1'};
                        //   NetUtil.tagVideoList(param,success: (response) async{
                        //     print('''response: $response''');
                        //     List<VideoModel> curList1 = List<VideoModel>.from(response.map((x) => VideoModel.fromJson(x)));
                        //     setState(() {
                        //       videoDataList.addAll(curList1);
                        //       _videoListController.addVideoInfo(curList1);
                        //     });
                        //
                        //     // print('$data');
                        //
                        //   },failure: (error) {
                        //
                        //   });
                        // },
                      // );
                      // video
                      // Widget currentVideo = Center(
                        // child: AspectRatio(
                        //   aspectRatio: player.value.aspectRatio,
                        //   child: VideoPlayer(player),
                        // ),
                        // child :FijkView(

                          // fit: FijkFit.contain,
                          // cover: null == data
                          //     ? Image.asset(
                          //   "imgs/defaultbanner1.png",
                          // ).image : CachedNetworkImageProvider(data.screenShot),
                      //     player: player,
                      //     color: Colors.black,
                      //     panelBuilder: (FijkPlayer player, FijkData data, BuildContext context, Size viewSize, Rect texturePos) {
                      //       return CustomFijkPanel(
                      //           player: player,
                      //           buildContext: context,
                      //           viewSize: viewSize,
                      //           texturePos: texturePos);
                      //     },
                      //   ),
                      // );
                //       currentVideo = TikTokVideoPage(
                //         showTipView: !canView,
                //         aspectRatio: 16 / 9.0,
                //         key: Key(data.m3u8 + '$i'),
                //         tag: data.m3u8,
                //         bottomPadding: 16.0,
                //         userInfoWidget: VideoUserInfo(
                //           videoModel: data,
                //           bottomPadding: 30.0,
                //           // onGoodGift: () => showDialog(
                //           //   context: context,
                //           //   builder: (_) => FreeGiftDialog(),
                //           // ),
                //         ),
                //         onSingleTap: canView ? ()async {
                //           if (player.state == FijkState.started) {
                //             await player.pause();
                //           } else {
                //             await player.start();
                //           }
                //           setState(() {});
                //         } : (){},
                //         onAddFavorite: () {
                //
                //         },
                //         rightButtonColumn: buttons,
                //         video: currentVideo,
                //       );
                //       return currentVideo;
                //     },
                //   ),
                // ),



                // Center(
                //   child: Text(_currentIndex.toString()),
                // )
  //             ],
  //           ),
  //         );
  //       }else {
  //         return Center(
  //             child:  CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //             )
  //         );
  //       }
  //     },
  //   );
  // }

  //点赞视频
  // void likeVideoRequest(VideoModel curModel, int index) {
  //   var params = {'video_id':curModel.videoId.toString()};
  //   NetUtil.likeVideo(params,success: (response) async{
  //     print('''response: $response''');
  //     setState(() {
  //       curModel.isFav = true;
  //       curModel.favs += 1;
  //       videoDataList.fillRange(index, index + 1,curModel);
  //     });
  //     // final Profile profile = Provider.of(context,listen: false);
  //     // profile.isLogin = true;
  //   },failure: (error) {
  //
  //   });
  // }
  //取消点赞视频
  // void unLikeVideoRequest(VideoModel curModel,int index) {
  //   var params = {'video_id':curModel.videoId.toString()};
  //   NetUtil.unLikeVideo(params,success: (response) async{
  //     print('''response: $response''');
  //     setState(() {
  //       curModel.isFav = false;
  //       curModel.favs =  0 > curModel.favs - 1 ? 0 : curModel.favs - 1;
  //       videoDataList.fillRange(index, index + 1,curModel);
  //     });
  //
  //   },failure: (error) {
  //
  //   });
  // }

// @override
// TODO: implement wantKeepAlive
// bool get wantKeepAlive => true;
}