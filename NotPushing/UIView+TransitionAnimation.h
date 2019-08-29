//
//  UIView+TransitionAnimation.h
//  04ModelViewControllerAnimation
//
//  Created by 余婷 on 15/10/8.
//  Copyright (c) 2015年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

//动画效果的枚举
typedef enum : NSUInteger {
    TransitionPageCurl,
    TransitionPageUnCurl,
    TransitionRippleEffect,
    TransitionSuckEffect,
    TransitionCube,
    TransitionOglFlip
} TransitionType;

//动画方向的枚举
typedef enum : NSUInteger {
    FROM_LEFT,
    FROM_RIGHT,
    FROM_TOP,
    FROM_BOTTOM
} TransitionToward;


@interface UIView(TransitionAnimation)


- (void)addTransitionAnimationWithDuration:(CGFloat)duration type:(NSInteger)type subType:(NSInteger)subType;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com