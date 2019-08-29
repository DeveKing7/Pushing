//
//  WLTAnalysis.m
//  WLT优化game
//
//  Created by MS on 15-10-7.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTAnalysis.h"
#import "WLTLyric.h"
@implementation WLTAnalysis{
    
    //这儿也可以声明成员变量
    //在这人声明的成员变量是私有的，不能被外部访问
    NSMutableArray * _lyricArray;
}

+ (id)sharemanage{
    static WLTAnalysis * ana;
    if (ana == nil) {
        ana = [[WLTAnalysis alloc] init];
        
    }
    return ana;
}
- (instancetype)init{
    
    if (self = [super init]) {
        
        _lyricArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)analysisLyricWithPath:(NSString *)path{
       //将文件内容转换成字符串
    NSString * pathStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //    NSLog(@"%@",pathStr);
    //以'\n'对字符串切割
    NSMutableArray * array1 = (NSMutableArray *)[pathStr componentsSeparatedByString:@"\n"];
    
    
    //删除不带时间的字符串
    for (int i = 0 ; i < [array1 count]; i++) {
        
        NSString * tstr = [array1 objectAtIndex:i];
        if (tstr.length == 0) {
            [array1 removeObjectAtIndex:i];
            i--;
            continue;
        }
        unichar ch = [tstr characterAtIndex:1];
        
        if (!isnumber(ch)) {
            
            [array1 removeObjectAtIndex:i];
            i -- ;
        }
        
    }
    
    //    NSLog(@"%@",array1);
    
    //切割出时间和歌词
    [self componLyricWithArray:array1];
    
}

- (void)componLyricWithArray:(NSArray *)array{
    
    [_lyricArray removeAllObjects];
   

    for (NSString * tlyricStr in array) {
        
        //以‘]’切割字符串
        NSArray * tarray = [tlyricStr componentsSeparatedByString:@"]"];
        
        for (int i = 0; i < [tarray count] - 1; i++) {
            
            
            //===============获取歌词==========
            //歌词
            //lastObject就是获取数组的最后一个元素
            NSString * lyricStr = [tarray lastObject];
            //存到歌词对象
            WLTLyric * lyric = [[WLTLyric alloc] init];
            //设置词
            [lyric setLyric:lyricStr];
            
            
            //=============获取歌词对应的时间========
            //歌词时间
            NSString * timestr = [tarray objectAtIndex:i];
            
            
            //将时间字符串转换成时间戳
           // NSLog(@"%@ %@",lyricStr,timestr);
            //时间格式
            //创建一个时间格式的变量
            NSDateFormatter * fm = [[NSDateFormatter alloc] init];
            //设置时间格式
            //m - 分,s - 秒,S - 毫秒
            [fm setDateFormat:@"[mm:ss.SS"];
            
            //时间
            //将字符串按照一定的时间格式转换成时间
            NSDate * date1 = [fm dateFromString:timestr];
            //            NSLog(@"%@",date1);
            
            //转换成时间戳
            NSTimeInterval  time1 = [date1 timeIntervalSince1970];
            //            NSLog(@"%f",time1);
            
            NSDate * date2 = [fm dateFromString:@"[00:00.00"];
            NSTimeInterval time2 = [date2 timeIntervalSince1970];
            
            //最后获取到的时间戳
            NSTimeInterval time = time1 - time2;
            
            
            
            
            //            NSLog(@"%f",time);
            
            [lyric setTime:time];
            
            //保存歌词到数组
            [_lyricArray addObject:lyric];
        }
        
    }
    
    
    //    NSLog(@"%@",_lyricArray);
    
    
    //对歌词按照时间排序
    for (int i = 0; i < [_lyricArray count] - 1; i++) {
        for (int j = i + 1; j < [_lyricArray count]; j++) {
            
            WLTLyric * lyric_i = [_lyricArray objectAtIndex:i];
            WLTLyric * lyric_j = _lyricArray[j];
            
            if ([lyric_i time] > [lyric_j time]) {
                
                [_lyricArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
   
}

//根据时间显示歌词
- (NSString *)showLyricWithTime:(NSTimeInterval)time{
    
    for (int i = (int)[_lyricArray count] - 1; i >= 0; i -- ) {
        
        WLTLyric * lyric = [_lyricArray objectAtIndex:i];
        if (lyric.time <= time) {
            
            return [lyric lyric];
        }
    }
    
    return @"......";
}



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com