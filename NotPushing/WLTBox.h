//
//  WLTBox.h
//  WLT优化game
//
//  Created by MS on 15-9-27.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSUInteger{
    direction_BOXLEFT,
    direction_BOXRIGHT,
    direction_BOXUP,
    direction_BOXDOWN,
    direction_BOXNIL
    
    
    
}directionBOXEnum;
@interface WLTBox : UIImageView

@property (nonatomic,assign)directionBOXEnum direction;
@property (nonatomic,assign)BOOL isMoving;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com