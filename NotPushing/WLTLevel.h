//
//  WLTLevel.h
//  WLT优化game
//
//  Created by MS on 15-10-8.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
//协议委托中，在.H里先写这个
@protocol  sendValueDelegate <NSObject>

-(void)getValue:(NSUInteger )ret;


@end

@interface WLTLevel : UIViewController

@property(nonatomic,weak) id <sendValueDelegate> delegate;


@property(nonatomic,assign) NSUInteger levelIndex;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com