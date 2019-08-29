//
//  WLTMap.h
//  WLT优化game
//
//  Created by MS on 01-1-1.
//  Copyright (c) 2001年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTPersonView.h"
#import "WLTBox.h"
#import "ViewController.h"
#import "WLTWall.h"
#import "WLTPoint.h"
@interface WLTMap : NSObject<UIScrollViewDelegate>

@property(nonatomic,strong)WLTPersonView * person;
@property(nonatomic,strong)NSMutableArray * boxArray;
@property(nonatomic,strong)NSMutableArray * wallArray;
@property(nonatomic,strong)NSMutableArray * pointArray;
@property(nonatomic,assign)NSUInteger  gatherCount;
@property(nonatomic,strong)UIImageView *  levelAnimation;//开场动画
@property(nonatomic,strong)NSMutableArray *  ItemArray; //道具

@property(nonatomic,strong)UILabel * label;//每关对白

-(void)addtext:(NSString *)text; //添加字幕
-(UIImageView *)map1; //关卡地图1-10
-(UIImageView *)map2;
-(UIImageView *)map3;
-(UIImageView *)map4;
-(UIImageView *)map5;
-(UIImageView *)map6;
-(UIImageView *)map7;
-(UIImageView *)map8;
-(UIImageView *)map9;
-(UIImageView *)map10;
-(void)levelLabel:(NSString *)levelName;

-(NSArray *)playAnimation;//开场动画
+(WLTMap *)sharedWltMap;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com