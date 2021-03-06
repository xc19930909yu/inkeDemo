//
//  APIConfig.h
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

//http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"

//http://service.ingkee.com/api/live/gettop

#ifndef APIConfig_h
#define APIConfig_h


// 服务器地址
#define SERVER_HOST @"http://service.ingkee.com/"

// 图片地址
#define  IMAGE_HOST @"http://img.meelive.cn/"


//首页数据
#define API_LiveGetTop @"api/live/gettop"

//广告地址
#define API_Advertise @"advertise/get"

//热门话题
#define API_TopicIndex @"api/live/topicindex"

//附近的人
#define API_NearLocation @"api/live/near_recommend" //?uid=85149891&latitude=40.090562&longitude=116.413353

//欢哥直播地址
#define Live_Super  @"rtmp://live.hkstv.hk.lxdns.com:1935/live/superman"

 // @"http://wssource.pull.inke.cn/live/1531979027289751.flv?ikDnsOp=1&ikHost=ws&ikOp=1&codecInfo=8192&ikLog=0&dpSrcG=6&ikMinBuf=3800&ikMaxBuf=4800&ikSlowRate=1.0&ikFastRate=1.0"
  //@"rtmp://live.hkstv.hk.lxdns.com:1935/live/superman"

//



#endif /* APIConfig_h */
