//
//  GameItem.h
//  WLT优化game
//
//  Created by MS on 15-10-11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GameItem : NSObject
+(id)sharedGameItem;
@property(nonatomic,strong)UIImageView * item;
-(UIImageView *)showItemDT:(NSUInteger )index;
-(UIImageView *)showItemJT:(NSUInteger )index;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com