//
//  WLTAnalysis.h
//  WLT优化game
//
//  Created by MS on 15-10-7.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTLyric.h"
@interface WLTAnalysis : NSObject
//解析指定路径的歌词
- (void)analysisLyricWithPath:(NSString *)path;

//根据时间显示歌词
- (NSString *)showLyricWithTime:(NSTimeInterval)time;

+ (id)sharemanage;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com