//
//  WLTData.h
//  WLT优化game
//
//  Created by MS on 15-10-9.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTData : NSObject
-(BOOL )firstLoadGame;
+(id)sharedWLTData;

-(NSUInteger)LoadPlayer;     //读取玩家人物
-(void)SavePlayer:(NSUInteger)index;  //存储玩家人物



-(NSUInteger)loadLevel;//读取关卡数
-(void)saveLevel:(NSUInteger)level;//保存关卡数
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com