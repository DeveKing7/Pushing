//
//  WLTSongManager.h
//  WLTMusic0.1
//
//  Created by MS on 15-9-26.
//  Copyright (c) 2015年 WLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTSong.h"

@interface WLTSongManager : NSObject
+ (id)defaultManager;


- (WLTSong *)getSongWithIndex:(NSUInteger)index;

//返回播放列表的音乐的数量
- (NSUInteger)countOfMusic;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com