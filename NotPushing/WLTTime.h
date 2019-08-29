//
//  WLTTime.h
//  WLT优化game
//
//  Created by MS on 15-10-12.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTTime : NSObject
@property(nonatomic,strong) NSMutableArray * timeArray;
-(void)saveLeveTime:(NSUInteger )level andTime:(NSString *)time;
-(void)loadTime;



@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com