//
//  WLTData.m
//  WLT优化game
//
//  Created by MS on 15-10-9.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTData.h"
#import "Header.h"
@implementation WLTData
+(id)sharedWLTData{
    static WLTData * data;
    if (data==nil) {
        data = [[WLTData alloc]init];
        
    }
    return data;
    
    
}

-(BOOL)firstLoadGame{
    
    BOOL  ret = NO;//判断是否第一次进入游戏
    
    ret = (int)[[NSUserDefaults standardUserDefaults] objectForKey:@"one"];
    
     [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",ret] forKey:@"one"];
    return ret;
}
-(NSUInteger)LoadPlayer{
    
   NSString * strIndex =  [[NSUserDefaults standardUserDefaults] objectForKey:@"player"];
    
    NSUInteger index = [strIndex integerValue];
    
    return index;
    
    
}
-(void)SavePlayer:(NSUInteger)index{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",index] forKey:@"player"];
    
    
    
}

-(void)saveLevel:(NSUInteger)level{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu",level] forKey:@"level"];
    
    
}

-(NSUInteger)loadLevel{
    
    NSString * strIndex =  [[NSUserDefaults standardUserDefaults] objectForKey:@"level"];
    
    NSUInteger index = [strIndex integerValue];
    
    return index;
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com