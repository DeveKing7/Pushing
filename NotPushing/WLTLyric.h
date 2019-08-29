//
//  WLTLyric.h
//  WLT优化game
//
//  Created by MS on 15-10-7.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTLyric : NSObject{
    NSString * _lyric;      //词
    
    //NSTimeInterval时间戳
    //2015-9-1 10：10：10 //有一些时间不想让外界知道，但是又需要存起来，就用时间戳  2382738637846s
    //2000-9-1 10：10：10
    //时间戳就是某一个时间到另外一个时间的时间差（单位是s）
    NSTimeInterval _time;   //时间
}
- (void)setLyric:(NSString *)lyric;
- (void)setTime:(NSTimeInterval)time;

- (NSString *)lyric;
- (NSTimeInterval)time;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com