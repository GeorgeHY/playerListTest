import 'package:fijkplayer/fijkplayer.dart';

class VideoModel {
  VideoModel({
    this.videoId = 0,
    this.name = "",
    this.duration = 0,
    this.views = 0,
    this.favs = 0,
    this.comments = 0,
    this.m3u8,
    this.isFav,
    this.screenShot,
    this.tags,
    this.recordTime = 0,
    this.isPreLoad = false,
    this.player,
  });


  //用户名
  int videoId;
  //用户ID
  String name;
  //邀请码
  int duration;
  //刷新时间
  int views;
  //
  int favs;
  //性别
  int comments;
  //播放地址
  String m3u8;
  //是否点赞
  bool isFav;
  //封面
  String screenShot;
  //标签
  String tags;
  //记录时间
  int recordTime;
  //是否已预加载
  bool isPreLoad;

  FijkPlayer player;


  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    videoId: json["video_id"],
    name: json["name"],
    duration: json["duration"],
    views: json["views"],
    favs: json["favs"],
    comments: json["comments"],
    m3u8: json["m3u8"],
    isFav: json["is_fav"],
    screenShot: json["screen_shot"],
    tags: json["tags"],
    recordTime: json["record_time"],
    isPreLoad: false,

  );

  Map<String, dynamic> toJson() => {
    "video_id": videoId,
    "name":name,
    "duration":duration,
    "views":views,
    "favs":favs,
    "comments":comments,
    "m3u8":m3u8,
    "screen_shot":screenShot,
    "tags":tags,
    "record_time":recordTime,

  };

}