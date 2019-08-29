//
//  Header.h
//  WLTMusic0.1
//
//  Created by MS on 15-9-26.
//  Copyright (c) 2015年 WLT. All rights reserved.
//
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) 
#define Screen_height [[UIScreen mainScreen] bounds].size.height
#define Screen_width [[UIScreen mainScreen] bounds].size.width
//IPHONE5适配
#define MUSIC_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/musics"]

#define TIME_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/time"]
#define TIMEPLIST_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/time/time.plist"]

#define BUTTON_TAG 500  //方向键按钮
#define BUTTON_LEVEL 600 //关卡选择按键

#define SPEED 5
#define LEVEL  9
#define PLAYGAME 100
#define CHOOSEGAME 101
#define TIMELIST 105

#define PLAYERdefalut 0
#define PLAYERmingRen 1
#define PLAYERnvXing 2


//道具

#define BaoxiangDT_01 1  //宝箱



#define BaoxiangJT_01 1
#define YaoShuiJT_01 2  //药水

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com