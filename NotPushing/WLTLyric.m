//
//  WLTLyric.m
//  WLT优化game
//
//  Created by MS on 15-10-7.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTLyric.h"

@implementation WLTLyric
- (void)setLyric:(NSString *)lyric{
    
    _lyric = lyric;
}

- (void)setTime:(NSTimeInterval)time{
    
    _time = time;
}

- (NSString *)lyric{
    
    return _lyric;
}
- (NSTimeInterval)time{
    
    return _time;
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"%lf %@",_time, _lyric];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com