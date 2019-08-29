//
//  WLTMenu.h
//  WLT优化game
//
//  Created by MS on 15-10-8.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  ValueDelegate <NSObject>

-(void)getValue:(NSUInteger )ret;


@end
@interface WLTMenu : UIViewController

@property(nonatomic,weak) id <ValueDelegate> delegate;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com