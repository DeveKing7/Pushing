//
//  WLTPersonView.h
//  WLT优化game
//
//  Created by MS on 15-9-24.
//  Copyright (c) 2015年 MS. All rights reserved.
//
//在工程中我们可以专门使用一个.h文件来管理工程中所有的枚举宏
#import <UIKit/UIKit.h>
typedef enum :NSUInteger{
    direction_LEFT,
    direction_RIGHT,
    direction_UP,
    direction_DOWN
    
    
    
    
}directionEnum;
@interface WLTPersonView : UIImageView
@property (nonatomic,assign)directionEnum direction;
@property (nonatomic,assign)BOOL isMoving;
@property (nonatomic,assign)BOOL isWall;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com