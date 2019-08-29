//
//  WLTWall.m
//  WLT优化game
//
//  Created by MS on 15-10-4.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTWall.h"

@implementation WLTWall{

    NSUInteger i;
    NSTimer * timer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baoxiang:) name:@"reset" object:nil];
        
        
    }
    return  self;
}
-(void)baoxiang:(NSNotification *)nof{
    
    i=[nof.object integerValue];
    
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    switch (_index) {
        case 0:
        {
            
           
            NSLog(@"5");
            if (i<7) {
                
            
            if (i==2) {
                self.image = [UIImage imageNamed:@"baoxiang_01_2.png"];
            }
            
            if (i==4) {
                self.image = [UIImage imageNamed:@"baoxiang_01_3.png"];
            }
            if (i==6) {
                self.image = [UIImage imageNamed:@"baoxiang_01_4.png"];
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(yaoshui) userInfo:nil repeats:YES];
            }
            }
            i++;
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}
-(void)yaoshui{
    
    self.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"yaoshui_01_1.png" ofType:nil]];

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 25, 30);
    
    self.isCrash=YES;
    

}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com