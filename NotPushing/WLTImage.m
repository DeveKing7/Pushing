//需要做适配的地方  主界面的所有按钮 人物移动时候的碰撞位置 菜单按钮 等 还有关卡的物体位置 还有这里的每关关卡图
//  WLTImage.m
//  NotPushing
//
//  Created by MS on 15-10-20.
//  Copyright (c) 2015年 WLT. All rights reserved.
//

#import "WLTImage.h"
#import "Header.h"
@implementation WLTImage
+(id)sharedWLTImage{
    static WLTImage * image;
    if (image == nil) {
        image = [[WLTImage alloc]init];
        
       
        
        
    }
    return image;
    
}
-(instancetype)init{
    
    if (self =[super init]) {
       _backgroundImage =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"背景" ofType:@"png"]];
        _boxImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"箱子" ofType:@"png"]];
        _boxImage2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"小木桶空_0" ofType:@"png"]];
         _stoneImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"stone"ofType:@"png"]];
        _tankWallImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tankwall"ofType:@"jpg"]];
        _wallImage1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"小木桶倒" ofType:@"png"]];
        _wallImage2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"小木箱01" ofType:@"png"]];
        _wallImage3 =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"罐子01" ofType:@"png"]];
        _wallImage4 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"小木箱组合_0" ofType:@"png"]];
        _wallImage5 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"小木桶满_0" ofType:@"png"]];
        _imageUp =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_up" ofType:@"png"]];
        _imageDown =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_down" ofType:@"png"]];
        _imageLeft =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_left" ofType:@"png"]];
        _imageRight =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button_right" ofType:@"png"]];
        _unfoladArray = [[NSMutableArray alloc]init];
       
        for (int i =1; i<=28; i++) {
            UIImage * image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"leida%d",i] ofType:@"jpg"]];
            [_unfoladArray addObject:image];
        }
    }
    
    return self;
    
}
-(UIImage *)getLevelImageIndex:(NSString *)level{
    
    UIView * view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UIImageView * back =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    back.image = [UIImage imageNamed:@"level2"];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(120, 260, 120, 150)];
    if (iPhone5) {
        label.frame =CGRectMake(130*0.85, 260*0.85, 120*0.85, 150*0.85);

    }
    if (Screen_width==320&&Screen_height==480) {
      label.frame =CGRectMake(130*0.75, 260*0.75, 120*0.75, 150*0.75);
    }
    
    label.backgroundColor = [UIColor whiteColor];
    label.text = level;
    label.textColor = [UIColor colorWithRed:66/255.0 green:107/255.0 blue:120/255.0 alpha:1];
    
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont boldSystemFontOfSize:80];
    [view addSubview:back];
    [view addSubview:label];
    //把UIView 转换成图片
        UIGraphicsBeginImageContext(view.bounds.size);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    
    
    

    
    
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
