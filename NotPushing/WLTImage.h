//
//  WLTImage.h
//  NotPushing
//
//  Created by MS on 15-10-20.
//  Copyright (c) 2015年 WLT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WLTImage : NSObject
@property(nonatomic,strong)UIImage * backgroundImage; //背景图片
@property(nonatomic,strong)UIImage * boxImage;  //默认箱子
@property(nonatomic,strong)UIImage * boxImage2;
@property(nonatomic,strong)UIImage * wallImage1;
@property(nonatomic,strong)UIImage * stoneImage;//石墙
@property(nonatomic,strong)UIImage * tankWallImage;//坦克墙
@property(nonatomic,strong)UIImage * wallImage2; //默认墙
@property(nonatomic,strong)UIImage * wallImage3;
@property(nonatomic,strong)UIImage * wallImage4;
@property(nonatomic,strong)UIImage * wallImage5;
@property(nonatomic,strong)UIImage * imageUp;  //方向上图片
@property(nonatomic,strong)UIImage * imageDown;//方向下图片
@property(nonatomic,strong)UIImage * imageLeft;//方向左图片
@property(nonatomic,strong)UIImage * imageRight;//方向右图片
@property(nonatomic,strong)NSMutableArray *  unfoladArray;
-(UIImage *)getLevelImageIndex:(NSString *)level;
+(id)sharedWLTImage;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com