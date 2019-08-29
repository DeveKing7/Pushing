//
//  WLTAnimationManager.h
//  WLT优化game
//
//  Created by MS on 15-9-24.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTPersonView.h"
@interface WLTAnimationManager : NSObject
//给我一个方向，我就给你这个方向对应的动画数组
@property(nonatomic,strong) UIImageView * Explode;
-(NSArray *)getAnimationArrywith:(directionEnum)direction;
+(WLTAnimationManager *)shareManager;
-(UIImageView *)Explode;//坦克爆炸效果
-(void)choosePlayerAnimation:(NSUInteger )index;
-(void)creatPlayer1;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com