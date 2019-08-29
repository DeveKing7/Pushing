//
//  GameItem.m
//  WLT优化game
//
//  Created by MS on 15-10-11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "GameItem.h"

@implementation GameItem
+(id)sharedGameItem{
    static GameItem * game;
    if (game==nil) {
        game = [[GameItem alloc]init];
        
        
    }
    return game;
    
}

-(UIImageView *)showItemDT:(NSUInteger)index{
    NSMutableArray * ary = [[NSMutableArray alloc]init];
    UIImageView * image = [[UIImageView alloc]init];
    switch (index) {
        case 1:
        {
            for (int i =1; i<=4; i++) {
                UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"baoxiang_01_%d",i]];
                [ary addObject:image];
            }
            [image setAnimationImages:ary];
            [image setAnimationDuration:3];
            [image setAnimationRepeatCount:0];
            
            
        }
            break;
            
        default:
            break;
    }
    return image;
    
}
-(UIImageView *)showItemJT:(NSUInteger)index{
    UIImageView * image = [[UIImageView alloc]init];
    switch (index) {
        case 1:
            [image setImage:[UIImage imageNamed:@"yaoshui_01_1.png"]];
            break;
        case 2:
            [image setImage:[UIImage imageNamed:@"baoxiang_01_1.png"]];
            break;
            
        default:
            break;
    }
    return image;
    
    
}
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com