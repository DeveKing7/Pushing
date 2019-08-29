//
//  WLTSongManager.m
//  WLTMusic0.1
//
//  Created by MS on 15-9-26.
//  Copyright (c) 2015年 WLT. All rights reserved.
//

#import "WLTSongManager.h"
#import "Header.h"
@implementation WLTSongManager{
    NSMutableArray * _musicArray;
}
- (instancetype)init{
    if (self = [super init]) {
        _musicArray = [[NSMutableArray alloc] init];
        [self creatMusic];
        [self addMusic];
        
    }
    return self;
}

+ (id)defaultManager{
    static WLTSongManager * manager =nil;
    if (manager == nil) {
        manager =[[WLTSongManager alloc] init];
        
    }
    return manager;
}


- (void)creatMusic{
    //先把音乐放到沙盒Documents路径下
    NSFileManager * fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:MUSIC_PATH]) {
        [fm createDirectoryAtPath:MUSIC_PATH withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //拿到包中相同类型的所有文件
    NSArray * allMp3Array = [[NSBundle mainBundle] pathsForResourcesOfType:@"mp3" inDirectory:nil];
   // NSLog(@"%@",allMp3Array);
    
    
    for (NSString * appPath in allMp3Array) {
        NSArray * array = [appPath componentsSeparatedByString:@"/"];
        NSString * name = [array lastObject];
        
        //将音频文件拷贝到沙盒目录下
        [fm copyItemAtPath:appPath toPath:[MUSIC_PATH stringByAppendingPathComponent:name] error:nil];
        
        
    }
    //将lrc文件拷贝到沙盒目录下
    NSArray * allLrcArray = [[NSBundle mainBundle] pathsForResourcesOfType:@"lrc" inDirectory:nil];
    for (NSString * lrcPath in allLrcArray) {
        NSArray * array = [lrcPath componentsSeparatedByString:@"/"];
        NSString * name = [array lastObject];
        //拷贝
        [fm copyItemAtPath:lrcPath toPath:[MUSIC_PATH stringByAppendingPathComponent:name] error:nil];
        
    }
}


- (void)addMusic{
    
    
  //  NSLog(@"%@", MUSIC_PATH);
   
    NSFileManager * fm =[NSFileManager defaultManager];
    //遍历拿到所有的文件
    NSArray * allfiles = [fm contentsOfDirectoryAtPath:MUSIC_PATH error:nil];
    for (NSString * musicName in allfiles) {
        if ([musicName hasSuffix:@"mp3"]) {
            WLTSong * song = [[WLTSong alloc] init];
            song.musicPath = [MUSIC_PATH stringByAppendingPathComponent:musicName];
            //吧歌名切出来
          
            song.lrcPath = [[NSBundle mainBundle] pathForResource:@"bgm_ending_0" ofType:@"m4a"];
            
            //将歌曲存到数组里
            [_musicArray addObject:song];
        }
    }
    
}



- (WLTSong *)getSongWithIndex:(NSUInteger)index{
    if (index<_musicArray.count) {
        WLTSong * song = _musicArray[index];
        return song;
    }
    
    
    return nil;
}

- (NSUInteger)countOfMusic{
    return  _musicArray.count;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com