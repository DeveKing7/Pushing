//
//  buttonView.m
//  NotPushing
//
//  Created by MS on 15-10-24.
//  Copyright (c) 2015年 WLT. All rights reserved.
//

#import "buttonView.h"

@implementation buttonView{
    
    NSMutableArray * unfoladArray;
}
-(id)initWithFrame:(CGRect)frame{
    
   
    if (self = [super initWithFrame:frame]) {
        
       
         unfoladArray = [[NSMutableArray alloc]init];
        for (int i =1; i<=28; i++) {
            UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"leida%d",i] ofType:@"jpg"]];
            [unfoladArray addObject:image];
        }
        [self setAnimationImages:unfoladArray];
        [self setAnimationDuration:1];
        [self setAnimationRepeatCount:1];
        

    }
    return self;
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com