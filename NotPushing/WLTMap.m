//
//  WLTMap.m
//  WLT优化game
//
//  Created by MS on 01-1-1.
//  Copyright (c) 2001年 MS. All rights reserved.
//
/* _boxImage = [UIImage imageNamed:@"箱子"];
 _boxImage2 = [UIImage imageNamed:@"小木桶空_0.png"];
 _wallImage1 = [UIImage imageNamed:@"小木桶倒.png"];
 _wallImage2 = [UIImage imageNamed:@"小木箱01"];
 _wallImage3 = [UIImage imageNamed:@"罐子01.png"];
 _wallImage4 = [UIImage imageNamed:@"小木箱组合_0.png"];
  _wallImage5 = [UIImage imageNamed:@"小木桶满_0.png"];
 */
#import "WLTMap.h"
#import "WLTData.h"
#import "GameItem.h"
#import "Header.h"
#import "GameItem.h"
#import "WLTImage.h"
#import "WLTAnimationManager.h"
@implementation WLTMap
{
  NSMutableArray * pointArray1;
  UIImageView * backGroundview;
    WLTImage * allImage;
    float _zoom;
    float hi;
}
-(instancetype)init{
    if (self = [super init]) {
        
        _boxArray = [[NSMutableArray alloc]init];
        _wallArray = [[NSMutableArray alloc]init];
        _pointArray = [[NSMutableArray alloc]init];
        _person = [[WLTPersonView alloc]init];
        _levelAnimation =[[UIImageView alloc]init];
        _ItemArray = [[NSMutableArray alloc]init];
       
        pointArray1 = [[NSMutableArray alloc]init];
        allImage = [WLTImage sharedWLTImage];
        if (iPhone5) {
            _zoom = 0.85;
            hi=35;
        }
        if(Screen_width==320&&Screen_height==480){
           _zoom = 0.75;
            hi=30;
            
        }
        
        for (int i =0; i<=12; i++) {
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"水花_000%d.png",i]];
            [pointArray1 addObject:image];
        }
        
    }
    return  self;
    
}
+(WLTMap *)sharedWltMap{
    static WLTMap * map;
    if (map == nil) {
        map = [[WLTMap alloc]init];
    }
    return  map;
    
}
-(NSArray *)playAnimation{
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    for (int i =1; i<4; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"yindao%d.jpg",i]];
        [animation addObject:image];
    }
    return animation;
    
    
    
}

-(UIImageView *)map1{
    //清理数据 释放空间
    _person=nil;
    backGroundview=nil;
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    _gatherCount = 0;
  
    //关卡界面
   backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    UILabel * table = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 100, 30)];
    table.text=@"level1";
    table.textColor = [UIColor whiteColor];
    [table setFont:[UIFont boldSystemFontOfSize:20]];
    [table setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];
    table.layer.shadowColor = [[UIColor blackColor]CGColor];
    table.layer.shadowOffset = CGSizeMake(4, 4);
    table.layer.shadowOpacity = 10;
    table.layer.shadowRadius = 1;
    [backGroundview addSubview:table];
    
    
    
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake(50, 550, 35, 35)];
    if (iPhone5) {
        _person.frame = CGRectMake(50, 450, 30, 30);
    }
    if(Screen_width==320&&Screen_height==480){
       _person.frame = CGRectMake(50, 380, 25, 25);
        
    }
    
    //设置静止时图片
  
            _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"player_down_1" ofType:@"png"]];
  
    
    
    
    _person.isMoving = NO;
    
    
    //创建一个箱子
    WLTBox * box = [[WLTBox alloc]init];
    box = [[WLTBox alloc]init];
    box.image = allImage.boxImage;
    box.frame = CGRectMake(270, 520, 40, 40);
    box.direction=direction_BOXNIL;
    [backGroundview addSubview:box];
    
    WLTBox * box2 = [[WLTBox alloc]init];
    box2.image = allImage.boxImage;
    box2.frame = CGRectMake(200, 520, 40, 40);
    box2.direction=direction_BOXNIL;
    [backGroundview addSubview:box2];
    
    WLTBox * box3 = [[WLTBox alloc]init];
    box3.image = allImage.boxImage;
    box3.frame = CGRectMake(80, 150, 40, 40);
    box3.direction=direction_BOXNIL;
    [backGroundview addSubview:box3];
    //IPHONE5适配
    if(iPhone5){
        
        box.frame = CGRectMake(160, 450, 35, 35);
        box2.frame = CGRectMake(230, 450, 35, 35);
        box3.frame = CGRectMake(80, 150, 35, 35);
        
    }
    if(Screen_width==320&&Screen_height==480){
        box.frame = CGRectMake(270*_zoom, 520*_zoom, 30, 30);
        box2.frame = CGRectMake(200*_zoom, 520*_zoom, 30, 30);
        box3.frame = CGRectMake(80*_zoom, 150*_zoom, 30, 30);
        
    }
    [_boxArray addObject:box];
    [_boxArray addObject:box2];
    [_boxArray addObject:box3];
    
    
    
    for (int i = 0 ; i <200; i+=40) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(25+i,400, 40, 40)];
        if(Screen_width==320&&Screen_height==480){
            image.frame = CGRectMake((25+i)*_zoom,400*_zoom, 30, 30);
        }
        [image setImage:allImage.wallImage1];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    int j =5;
    if (iPhone5) {
        j=4;
    }
    if(Screen_width==320&&Screen_height==480){
        j=3;
    }
    for (int i = 0 ; i <j; i++) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80-i*40,250, 40, 40)];
        if(Screen_width==320&&Screen_height==480){
            image.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-80-i*40,250*_zoom, 30, 30);
        }
        [image setImage:allImage.wallImage1];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    
    
    
    
    WLTPoint * point1 = [[WLTPoint alloc]initWithFrame:CGRectMake(200, 50, 40, 40)];
    WLTPoint * point2 = [[WLTPoint alloc]initWithFrame:CGRectMake(40, 50, 40, 40)];
    WLTPoint * point3 = [[WLTPoint alloc]initWithFrame:CGRectMake(300, 50, 40, 40)];
    if(iPhone5){
        
        point1.frame = CGRectMake(200, 50,35, 35);
         point2.frame = CGRectMake(40, 50,35, 35);
         point3.frame = CGRectMake(200, 150,35, 35);
        
    }
    if(Screen_width==320&&Screen_height==480){
        point1.frame = CGRectMake(200*_zoom, 50*_zoom, 30, 30);
        point2.frame = CGRectMake(40*_zoom, 50*_zoom, 30, 30);
        point3.frame = CGRectMake(300*_zoom, 50*_zoom, 30, 30);
    }
    point1.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
    point1.layer.cornerRadius = 10;
    point2.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
    
    point3.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
    
    point2.layer.cornerRadius = 10;
    point3.layer.cornerRadius = 10;
    
    [point1 setAnimationImages:pointArray1];
    [point1 setAnimationDuration:3];
    [point1 setAnimationRepeatCount:0];
    [point1 startAnimating];
    [point2 setAnimationImages:pointArray1];
    [point2 setAnimationDuration:3];
    [point2 setAnimationRepeatCount:0];
    [point2 startAnimating];
    [point3 setAnimationImages:pointArray1];
    [point3 setAnimationDuration:3];
    [point3 setAnimationRepeatCount:0];
    [point3 startAnimating];
    [backGroundview addSubview:point1];
    [backGroundview addSubview:point2];
    [backGroundview addSubview:point3];
    
    [backGroundview insertSubview:_person belowSubview:point1];
    [backGroundview insertSubview:_person belowSubview:point2];
    [backGroundview insertSubview:_person belowSubview:point3];
    [backGroundview addSubview:_person];
    [_pointArray addObject:point1];
    [_pointArray addObject:point2];
    [_pointArray addObject:point3];
    //每关开始前播放动画
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"1"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
     [_levelAnimation startAnimating];
    
    
    return backGroundview;
    
    
    
    
}
-(UIImageView *)map2{
    //清理数据 释放空间
    _person=nil;
    backGroundview=nil;
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    UILabel * table = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 100, 30)];
    table.text=@"level2";
    table.textColor = [UIColor whiteColor];
    [table setFont:[UIFont boldSystemFontOfSize:20]];
    [table setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];
    table.layer.shadowColor = [[UIColor blackColor]CGColor];
    table.layer.shadowOffset = CGSizeMake(4, 4);
    table.layer.shadowOpacity = 10;
    table.layer.shadowRadius = 1;
    [backGroundview addSubview:table];
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake(50, 550, 35, 35)];
    if (iPhone5) {
        _person.frame = CGRectMake(50, 450, 30, 30);
    }
    if(Screen_width==320&&Screen_height==480){
         _person.frame = CGRectMake(50, 380, 25, 25);
    }

    //设置静止时图片
 
            _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"player_down_1" ofType:@"png"]];
    
    
    
    
    
    _person.isMoving = NO;
    
    
    
    //创建一个箱子
    WLTBox * box = [[WLTBox alloc]init];
    box = [[WLTBox alloc]init];
    box.image = allImage.boxImage;
    box.frame = CGRectMake(210, 300, 40, 40);
    box.direction=direction_BOXNIL;
    [backGroundview addSubview:box];
    
    WLTBox * box2 = [[WLTBox alloc]init];
    box2.image = allImage.boxImage;
    box2.frame = CGRectMake(200, 520, 40, 40);
    box2.direction=direction_BOXNIL;
    [backGroundview addSubview:box2];
    
    WLTBox * box3 = [[WLTBox alloc]init];
    box3.image = allImage.boxImage;
    box3.frame = CGRectMake(100, 50, 40, 40);
    box3.direction=direction_BOXNIL;
    [backGroundview addSubview:box3];
    if(iPhone5){
        box.frame = CGRectMake(210*0.8, 300*0.8, 35, 35);
        box2.frame = CGRectMake(200*0.8, 520*0.8, 35, 35);
        box3.frame = CGRectMake(100*0.8, 40*0.8, 35, 35);
        
        
    }
    if(Screen_width==320&&Screen_height==480){
        box.frame = CGRectMake(210*_zoom, 300*_zoom, 30, 30);
        box2.frame = CGRectMake(200*_zoom, 520*_zoom, 30, 30);
        box3.frame = CGRectMake(100*_zoom, 40*_zoom, 30, 30);

    }
    [_boxArray addObject:box];
    [_boxArray addObject:box2];
    [_boxArray addObject:box3];
    
    
    
    for (int i = 0 ; i <120; i+=40) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(210,130+i, 60, 40)];
        if (iPhone5) {
            image.frame = CGRectMake(210*0.8, (130+i)*0.8, 50, 30);
        }
        if(Screen_width==320&&Screen_height==480){
             image.frame = CGRectMake(210*_zoom, (130+i)*_zoom, 50, 30);
            
        }
        [image setImage:allImage.wallImage2];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    for (int i = 0 ; i <120; i+=40) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(100,130+i, 30, 30)];
        if (iPhone5) {
            image.frame = CGRectMake(100*0.8, (130+i)*0.8, 25, 25);
        }
        if(Screen_width==320&&Screen_height==480){
            image.frame = CGRectMake(100*_zoom, (130+i)*_zoom, 25, 25);
            
        }
        [image setImage:allImage.wallImage3];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    for (int i = 0 ; i <=75; i+=75) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(210+i,250, 60, 40)];
        if (iPhone5) {
            image.frame = CGRectMake((210+i)*0.8, 250*0.8, 50, 30);
        }
        if(Screen_width==320&&Screen_height==480){
             image.frame = CGRectMake((210+i)*_zoom, 250*_zoom, 50, 30);
            
        }
        [image setImage:allImage.wallImage2];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    for (int i = 0 ; i <=75; i+=75) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(220+i,400, 60, 40)];
        if (iPhone5) {
            image.frame = CGRectMake((220+i)*0.8, 400*0.8, 50, 30);
        }
        if(Screen_width==320&&Screen_height==480){
             image.frame = CGRectMake((220+i)*_zoom, 400*_zoom, 50, 30);
            
        }
        [image setImage:allImage.wallImage2];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    for (int i = 0 ; i <120; i+=40) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(25+i,450, 60, 40)];
        if (iPhone5) {
            image.frame = CGRectMake((25+i)*0.8, 450*0.8, 50, 30);
        }
        if(Screen_width==320&&Screen_height==480){
            image.frame = CGRectMake((25+i)*_zoom, 450*_zoom, 50, 30);
            
        }
        [image setImage:allImage.wallImage2];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    
    WLTPoint * point1 = [[WLTPoint alloc]initWithFrame:CGRectMake(40, 350, 40, 40)];
    WLTPoint * point2 = [[WLTPoint alloc]initWithFrame:CGRectMake(30, 40, 40, 40)];
    WLTPoint * point3 = [[WLTPoint alloc]initWithFrame:CGRectMake(300, 200, 40, 40)];
    if (iPhone5) {
       point1.frame = CGRectMake(40*0.8, 350*0.8, 35, 35);
        point2.frame = CGRectMake(30*0.8, 40*0.8, 35, 35);
        point3.frame = CGRectMake(300*0.8, 200*0.8, 35, 35);
    }
    if(Screen_width==320&&Screen_height==480){
        point1.frame = CGRectMake(40*_zoom, 350*_zoom, 30, 30);
        point2.frame = CGRectMake(30*_zoom, 40*_zoom, 30, 30);
        point3.frame = CGRectMake(300*_zoom, 200*_zoom, 30, 30);
        
    }
    point1.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
    point1.layer.cornerRadius = 10;
    point2.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
    point2.layer.cornerRadius = 10;
    point3.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
    point3.layer.cornerRadius = 10;
    
    [point1 setAnimationImages:pointArray1];
    [point1 setAnimationDuration:3];
    [point1 setAnimationRepeatCount:0];
    [point1 startAnimating];
    [point2 setAnimationImages:pointArray1];
    [point2 setAnimationDuration:3];
    [point2 setAnimationRepeatCount:0];
    [point2 startAnimating];
    [point3 setAnimationImages:pointArray1];
    [point3 setAnimationDuration:3];
    [point3 setAnimationRepeatCount:0];
    [point3 startAnimating];
    [backGroundview addSubview:point1];
    [backGroundview addSubview:point2];
    [backGroundview addSubview:point3];
    
    [backGroundview insertSubview:_person belowSubview:point1];
    [backGroundview insertSubview:_person belowSubview:point2];
    [backGroundview insertSubview:_person belowSubview:point3];
    [backGroundview addSubview:_person];
    [_pointArray addObject:point1];
    [_pointArray addObject:point2];
    [_pointArray addObject:point3];
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"2"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
     [_levelAnimation startAnimating];
    return backGroundview;
    
    
    
    
}
-(UIImageView *)map3{
    //清理数据 释放空间
    _person=nil;
    backGroundview=nil;
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    UILabel * table = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 100, 30)];
    table.text=@"level3";
    table.textColor = [UIColor whiteColor];
    [table setFont:[UIFont boldSystemFontOfSize:20]];
    [table setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];
    table.layer.shadowColor = [[UIColor blackColor]CGColor];
    table.layer.shadowOffset = CGSizeMake(4, 4);
    table.layer.shadowOpacity = 10;
    table.layer.shadowRadius = 1;
    [backGroundview addSubview:table];
    
    
   
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake(60, 580, 35, 35)];
    
    if (iPhone5) {
        _person.frame = CGRectMake(50, 500, 30, 30);
    }
    if(Screen_width==320&&Screen_height==480){
       _person.frame = CGRectMake(50, 400, 25, 25);
    }
            _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"player_down_1" ofType:@"png"]];
            _person.isMoving = NO;
    
    
    
    //创建箱子
    
    
    WLTBox * box1 = [[WLTBox alloc]init];
    box1.image = allImage.boxImage2;
    box1.frame = CGRectMake(50, 300, 40, 40);
    box1.direction=direction_BOXNIL;
    [backGroundview addSubview:box1];
    
    WLTBox * box2 = [[WLTBox alloc]init];
    box2.image = allImage.boxImage2;
    box2.frame = CGRectMake(100, 300, 40, 40);
    box2.direction=direction_BOXNIL;
    [backGroundview addSubview:box2];
    
    WLTBox * box3 = [[WLTBox alloc]init];
    box3.image =allImage.boxImage2;
    box3.frame = CGRectMake(150,300, 40, 40);
    box3.direction=direction_BOXNIL;
    [backGroundview addSubview:box3];
    
    WLTBox * box4 = [[WLTBox alloc]init];
    box4.image = allImage.boxImage2;
    box4.frame = CGRectMake(200, 400, 40, 40);
    box4.direction=direction_BOXNIL;
    [backGroundview addSubview:box4];
    
    WLTBox * box5 = [[WLTBox alloc]init];
    box5.image = allImage.boxImage2;
    box5.frame = CGRectMake(230, 500, 40, 40);
    box5.direction=direction_BOXNIL;
    [backGroundview addSubview:box5];
    if (iPhone5) {
        box1.frame = CGRectMake(50*_zoom, 300*_zoom, 35, 35);
        box2.frame = CGRectMake(100*_zoom, 300*_zoom, 35, 35);
        box3.frame = CGRectMake(150*_zoom,300*_zoom, 35, 35);
        box4.frame = CGRectMake(200*_zoom, 400*_zoom, 35, 35);
        box5.frame = CGRectMake(230*_zoom, 500*_zoom, 35, 35);
    }
    if(Screen_width==320&&Screen_height==480){
        box1.frame = CGRectMake(50*_zoom, 300*_zoom, 30, 30);
        box2.frame = CGRectMake(100*_zoom, 300*_zoom, 30, 30);
        box3.frame = CGRectMake(150*_zoom,300*_zoom, 30, 30);
        box4.frame = CGRectMake(200*_zoom, 400*_zoom, 30, 30);
        box5.frame = CGRectMake(230*_zoom, 500*_zoom, 30, 30);

    }
    [_boxArray addObject:box1];
    [_boxArray addObject:box2];
    [_boxArray addObject:box3];
    [_boxArray addObject:box4];
    [_boxArray addObject:box5];
    //创建宝箱
    
    
    

    WLTWall *image =[[WLTWall alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"baoxiang_01_1.png" ofType:nil]]];
     image.itemName = @"药水";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"baoxiang" object:@"0"];
    image.userInteractionEnabled = YES;
    image.frame = CGRectMake(300, 300, 30, 30);
    if (iPhone5) {
        image.frame = CGRectMake(300*_zoom, 300*_zoom, 25, 25);
    }
    if(Screen_width==320&&Screen_height==480){
       image.frame = CGRectMake(300*_zoom, 300*_zoom, 25, 25);
        
    }
    [backGroundview addSubview:image];
    [_wallArray addObject:image];

  

   
       //创建障碍
    for (int i = 0 ; i <=100; i+=100) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(250,240+i, 100, 50)];
        if (iPhone5) {
            image.frame  =CGRectMake(250*0.85, (240+i)*0.85, 80, 30);
        }
        if(Screen_width==320&&Screen_height==480){
           image.frame  =CGRectMake(250*_zoom, (240+i)*_zoom, 80, 30);
            
        }
        [image setImage:allImage.wallImage4];
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }

    
    for (int i = 0 ; i <=120; i+=60) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(30+i,530, 40, 40)];
        if (iPhone5) {
            image.frame  =CGRectMake((30+i)*0.85, 530*0.85, 35, 35);
        }
        if(Screen_width==320&&Screen_height==480){
            image.frame  =CGRectMake((30+i)*_zoom, 480*_zoom, 30, 30);
            
        }
        [image setImage:allImage.wallImage5];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    for (int i = 0 ; i <=120; i+=120) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(130+i,200, 40, 40)];
        if (iPhone5) {
            image.frame  =CGRectMake((130+i)*0.85, 200*0.85, 35, 35);
        }
        if(Screen_width==320&&Screen_height==480){
            image.frame  =CGRectMake((130+i)*_zoom, 200*_zoom, 30, 30);
            
        }
        [image setImage:allImage.wallImage5];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    
    for (int i = 0 ; i <=100; i+=50) {
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(26+i,100, 40, 40)];
        if (iPhone5) {
            image.frame  =CGRectMake((26+i)*0.85, 100*0.85, 35, 35);
        }
        if(Screen_width==320&&Screen_height==480){
            image.frame  =CGRectMake((26+i)*_zoom, 100*_zoom, 30, 30);
            
        }
        [image setImage:allImage.wallImage5];
        [backGroundview addSubview:image];
        [_wallArray addObject:image];
    }
    
    //创建漏水点
    for (int i = 0 ; i <=300; i+=260) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(40+i, 40, 40, 40)];
        if (iPhone5) {
            point.frame  =CGRectMake((40+i)*0.85, 40*0.85, 35, 35);
        }
        if(Screen_width==320&&Screen_height==480){
            point.frame  =CGRectMake((40+i)*_zoom, 40*_zoom, 30, 30);
        }
        [_pointArray addObject:point];
    }
    for (int i = 0 ; i <120; i+=60) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(40, 150+i, 40, 40)];
        if (iPhone5) {
            point.frame  =CGRectMake(40*0.85, (150+i)*0.85, 35, 35);
        }
        if(Screen_width==320&&Screen_height==480){
            point.frame  =CGRectMake(40*_zoom, (150+i)*_zoom, 30, 30);
        }
        [_pointArray addObject:point];
    }
    for (int i = 0 ; i <=0; i++) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(80, 400+i, 40, 40)];
        if (iPhone5) {
            point.frame  =CGRectMake(80*0.85, (400+i)*0.85, 35, 35);
        }
        if(Screen_width==320&&Screen_height==480){
            point.frame  =CGRectMake(80*_zoom, (400+i)*_zoom, 30, 30);
        }
        [_pointArray addObject:point];
    }
    
    
    
    for (WLTPoint * point in _pointArray) {
        [point setAnimationDuration:2];
        [point setAnimationImages:pointArray1];
        [point setAnimationRepeatCount:0];
        [point startAnimating];
        [backGroundview addSubview:point];
        [backGroundview insertSubview:_person belowSubview:point];
        point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
        point.layer.cornerRadius = 10;
    }
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"3"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
    [_levelAnimation startAnimating];
    
    [backGroundview addSubview:_person];
   
    [self addtext:@"咦~？！这个房间怎么没有箱子？"];
   
    
    for (WLTBox * box in _boxArray) {
        box.isMoving = YES;
    }
    //此关卡默认没有箱子可以推~~
    return backGroundview;
    
    
    
    
}

-(UIImageView *)map4{
    if (iPhone5) {
        _zoom = 0.85;
    }
    //清理数据 释放空间
    _person=nil;
    backGroundview=nil;
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    [self levelLabel:@"level4"];
  
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+100, 35, 35)];
    
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        _person.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+100, 30, 30);
    }
   
    
            _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"player_down_1" ofType:@"png"]];
    
    
    
    _person.isMoving = NO;
    
    
    
    
    
    
    

    
    
     int j = 38;
    //创建障碍
    for (int i = 0 ; i <=6; i++) {
        
        if (i==3||i==0||i==6) {
            continue;
        }
        if (i==4) {
            j=50;
        }
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(j+40*i,240, 39, 39)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame = CGRectMake(j*_zoom+40*_zoom*i, 240*_zoom, hi, hi);
        }
        [image setImage:allImage.wallImage2];
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
    for (int i = 0 ; i <2; i++) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(35+i*265, 240, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake(35*_zoom+i*265*_zoom, 240*_zoom, hi, hi);
        }
        [_pointArray addObject:point];
    }
    
    //创建箱子
              for (int i =0 ; i<5; i++) {
                WLTBox * box = [[WLTBox alloc]init];
                box.image = allImage.boxImage;
                box.frame = CGRectMake(165, 160+i*40, 40, 40);
                  if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                      box.frame = CGRectMake(165*_zoom, 155*_zoom+i*43*_zoom, hi, hi);
                  }
                box.direction=direction_BOXNIL;
                [backGroundview addSubview:box];
                [_boxArray addObject:box];
        
            }
    

    
    
    //创建漏水点
    for (int i = 0 ; i <=300; i+=260) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(40+i, 40, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake(40*_zoom+i*_zoom, 40*_zoom, hi, hi);
        }

        [_pointArray addObject:point];
    }
    
    for (int i = 0 ; i <=1; i++) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(240, 325+i*45, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake(240*_zoom, 335*_zoom+i*45*_zoom, hi, hi);
        }

        [_pointArray addObject:point];
    }
    for (int i =0 ; i<1; i++) {
        WLTBox * box = [[WLTBox alloc]init];
        box.image = allImage.boxImage;
        box.frame = CGRectMake(300, 365, 40, 40);
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            box.frame = CGRectMake(300*_zoom, 380*_zoom, hi, hi);
        }

        box.direction=direction_BOXNIL;
        [backGroundview addSubview:box];
        [_boxArray addObject:box];
        
    }
    
    for (WLTPoint * point in _pointArray) {
        [point setAnimationDuration:2];
        [point setAnimationImages:pointArray1];
        [point setAnimationRepeatCount:0];
        [point startAnimating];
        [backGroundview addSubview:point];
        [backGroundview insertSubview:_person belowSubview:point];
        point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
        point.layer.cornerRadius = 10;
    }
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"4"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
    
    
[backGroundview addSubview:_person];
    
    return backGroundview;
    
    
    
    
}
-(UIImageView *)map5{
    if (iPhone5) {
        _zoom =0.85;
    }
    //清理数据 释放空间
    _person=nil;
    backGroundview=nil;
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    [self levelLabel: @"level5"];
    
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+200, 35, 35)];
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
       _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+150, 30, 30)];
    }
    
    _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"player_down_1" ofType:@"png"]];
    
    
    
    _person.isMoving = NO;
    
    
    
    
    
    
    
    
    
    
    int j = 38;
    //创建障碍
    for (int i = 0 ; i <=14; i++) {
        
       
        if (i==5) {
            j=146;
        }
        if (i==10) {
            j=38;
        }
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(j+i%5*40,170+i/5*120, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame = CGRectMake(j*_zoom+i%5*40*_zoom,170*_zoom+i/5*135*_zoom, hi, hi);
        }
        [image setImage:allImage.wallImage2];
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
    //  创建箱子
    for (int i =0 ; i<3; i++) {
        WLTBox * box = [[WLTBox alloc]init];
        box.image = allImage.boxImage;
        box.frame = CGRectMake(105, 210+i*40, 40, 40);
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            box.frame = CGRectMake(100*_zoom,215*_zoom+i*44*_zoom, hi, hi);
        }
        box.direction=direction_BOXNIL;
        [backGroundview addSubview:box];
        [_boxArray addObject:box];
        
    }
    for (int i =0 ; i<1; i++) {
        WLTBox * box = [[WLTBox alloc]init];
        box.image = allImage.boxImage;
        box.frame = CGRectMake(238, 410, 40, 40);
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            box.frame = CGRectMake(245*_zoom,420*_zoom, hi, hi);
        }
        box.direction=direction_BOXNIL;
        [backGroundview addSubview:box];
        [_boxArray addObject:box];
        
    }
    

    

    
    
    
    //创建漏水点
    int h = 1;
    for (int i = 0 ; i <=2; i++) {
        if (i==1||i==3) {
            h=80;
        }
        if (i==0||i==2) {
            h=0;
        }
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(40+i*130, h+45, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake(40*_zoom+i*130*_zoom,(h+45)*_zoom, hi, hi);
        }
        [_pointArray addObject:point];
    }
    
    for (int i = 0 ; i <1; i++) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(300, 125, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake(300*_zoom, 125*_zoom, hi, hi);
        }
        [_pointArray addObject:point];
    }
    
    for (WLTPoint * point in _pointArray) {
        [point setAnimationDuration:2];
        [point setAnimationImages:pointArray1];
        [point setAnimationRepeatCount:0];
        [point startAnimating];
        [backGroundview addSubview:point];
        [backGroundview insertSubview:_person belowSubview:point];
        point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
        point.layer.cornerRadius = 10;
    }
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"5"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
    
     [_levelAnimation startAnimating];
    
    
    return backGroundview;
    
    
    
    
}
-(UIImageView *)map6{
    if (iPhone5) {
        _zoom = 0.85;
    }
    //清理数据 释放空间
    _person=nil;
    backGroundview=nil;
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    [self levelLabel: @"level6"];
    
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+200, 35, 35)];
    if(iPhone5||(Screen_width==320&&Screen_height==480)){
         _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+150, 30, 30)];
    }
    
    _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"player_down_1" ofType:@"png"]];
    
    
    
    _person.isMoving = NO;
    
    
    
    
    
    
    
    
    
    //此关卡所有障碍物和箱子全部隐藏

    //创建障碍
    for (int i = 0 ; i <=6; i++) {
        
        if (i==4||i==1) {
            continue;
        }
       
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i*45+30,420, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame =CGRectMake((i*45+30)*_zoom,420*_zoom, hi, hi);
        }
        [image setImage:allImage.wallImage2];
     
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
  //   创建箱子
    for (int i =0 ; i<2; i++) {
        WLTBox * box = [[WLTBox alloc]init];
        if (i==0) {
            box.image =allImage.boxImage;
        }
        else {
        box.image = allImage.wallImage2;
        }
        box.frame = CGRectMake(75+i*135, 420, 40, 40);
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            box.frame =CGRectMake((75+i*135)*_zoom,420*_zoom, hi, hi);
        }
     
        box.direction=direction_BOXNIL;
        [backGroundview addSubview:box];
        [_boxArray addObject:box];
        
    }
    //创建障碍
    for (int i = 0 ; i <=6; i++) {
        
        if (i==2||i==5||i==6) {
            continue;
        }
        
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i*45+30,250, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame =CGRectMake((i*45+30)*_zoom,250*_zoom, hi, hi);
        }
        [image setImage:allImage.wallImage2];
        
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
    
    for (int i = 0 ; i <=6; i++) {
        
//        if (i==5) {
//            continue;
//        }
        
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i*45+30,100, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame =CGRectMake((i*45+30)*_zoom,100*_zoom, hi, hi);
        }
        [image setImage:allImage.wallImage2];
        
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
    int j =0;
    for (int i =0 ; i<3; i++) {
        WLTBox * box = [[WLTBox alloc]init];
        box.image = allImage.boxImage;
        box.direction=direction_BOXNIL;
        [backGroundview addSubview:box];
        [_boxArray addObject:box];

        if (i==2) {
            j=-50;
            i=0;
            box.frame = CGRectMake(255+i*40, 250+j, 40, 40);
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
               box.frame =CGRectMake((255+i*40)*_zoom,(250+j)*_zoom, hi, hi);
            }
            break;
        }
        box.frame = CGRectMake(255+i*40, 250+j, 40, 40);
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            box.frame =CGRectMake((255+i*45)*_zoom,(250+j)*_zoom, hi, hi);
        }
        
    }
    
    
    
    
    
    
    
    //创建漏水点
   
      int h = 50;
    for (int i = 0 ; i <4; i++) {
        if (i==2) {
            h=110;
        }
        if (i==3) {
            h=145;
        }
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(300, 145+i*h, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
             point.frame =CGRectMake(300*_zoom,(145+i*h)*_zoom, hi, hi);
        }
        [_pointArray addObject:point];
    }
    for (int i = 0 ; i <1; i++) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(75, 370, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame =CGRectMake(75*_zoom,370*_zoom, hi, hi);
        }
        [_pointArray addObject:point];
    }
    
    for (WLTPoint * point in _pointArray) {
        [point setAnimationDuration:2];
        [point setAnimationImages:pointArray1];
        [point setAnimationRepeatCount:0];
        [point startAnimating];
        [backGroundview addSubview:point];
        [backGroundview insertSubview:_person belowSubview:point];
        point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
        point.layer.cornerRadius = 10;
    }
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"6"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
     [_levelAnimation startAnimating];
    
    
     [self addtext:@"咦~这关感觉怪怪的。。"];
    [backGroundview addSubview:_person];
    return backGroundview;
    
    
    
    
}
-(UIImageView *)map7{
   
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
      backGroundview=nil;
        backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    [self levelLabel: @"level7"];
    
    
     _person=nil;
        _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+220, 35, 35)];
   
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        _person.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+200, 30, 30);
    }
    
    
   
    _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"player_down_1" ofType:@"png"]];
                     
    
    
    
    _person.isMoving = NO;
    
    
    
    
    
    
    
    
   
    
    //创建障碍
    for (int i = 0 ; i <=6; i++) {
        
        if (i==4||i==1) {
            continue;
        }
        
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i*45+30,500, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame = CGRectMake((i*45+30)*_zoom,500*_zoom, hi, hi);
        }
        [image setImage:allImage.wallImage2];
        
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(165, 390, 40, 40)];
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        scrollView.frame = CGRectMake((165)*_zoom,390*_zoom, hi, hi);
    }
    WLTWall * wall = [[WLTWall alloc]initWithFrame:CGRectMake(165,390, 40, 40)];
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        wall.frame = CGRectMake((165)*_zoom,390*_zoom, hi, hi);
    }
    [wall setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tankUp" ofType:@"png"]]];
    [wall setHidden:YES];
    wall.tag=20;
    [_wallArray addObject:wall];
    [backGroundview addSubview:wall];

    
    //要显示的图的总大小
    scrollView.contentSize = CGSizeMake(80, 40);
    if (iPhone5) {
      scrollView.contentSize = CGSizeMake(70, 35);
    }
    //弹簧效果不开启
    scrollView.bounces= NO;
    //水平和垂直条关闭
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    //是否整页滑动 是
    scrollView.pagingEnabled =YES;
  
    [backGroundview addSubview:scrollView];
    
    
    for (int i = 0; i<2; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*40,0,40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            imageView.frame = CGRectMake((i*40)*_zoom,0, hi, hi);
        }
        [imageView setImage:allImage.wallImage2];
      
       
        if (i==1) {
            imageView.image = [UIImage imageNamed:@"tankUp"];
        }
        imageView.userInteractionEnabled = YES;
         [scrollView addSubview:imageView];
        scrollView.delegate = self;
        

        
    }
    
    for (int i = 0 ; i <49; i++) {
        
        if (i==45) {
            continue;
        }
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i%7*45+30,150+i/7*40, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame = CGRectMake((i%7*45+30)*_zoom,(150+i/7*40)*_zoom, hi, hi);
        }
        [image setImage:allImage.wallImage2];
        
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
         //创建障碍

    
    
    
    
    
    
    
    //创建漏水点
    

    for (int i = 0 ; i <7; i++) {
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(35+i*45, 45, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake((35+i*45)*_zoom,(45)*_zoom, hi, hi);
        }
        [_pointArray addObject:point];
    }
    //   创建箱子
    for (int i =0 ; i<7; i++) {
        WLTBox * box = [[WLTBox alloc]init];
        box.image = allImage.stoneImage;
        box.frame = CGRectMake(35+i*45, 95, 40, 40);
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            box.frame = CGRectMake((35+i*45)*_zoom,(95)*_zoom, hi, hi);
        }
        box.direction=direction_BOXNIL;
        [backGroundview addSubview:box];
        [_boxArray addObject:box];
        
    }

    for (WLTPoint * point in _pointArray) {
        [point setAnimationDuration:2];
        [point setAnimationImages:pointArray1];
        [point setAnimationRepeatCount:0];
        [point startAnimating];
        [backGroundview addSubview:point];
        [backGroundview insertSubview:_person belowSubview:point];
        point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
        point.layer.cornerRadius = 10;
    }
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"7"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
     [_levelAnimation startAnimating];
    
    [backGroundview addSubview:_person];
    [self addtext:@"晕  这让我怎么过去啊。那中间箱子后面好像藏着什么.."];
    return backGroundview;
    
    
    
    
}
-(UIImageView *)map8{
    
    if (iPhone5) {
        hi=30;
    }
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
   
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    [backGroundview setImage:allImage.backgroundImage];
     backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    [self levelLabel: @"level8"];
    
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+240, 35, 35)];
    
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        _person.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+200, 30, 30);

    }
    
    
    
    _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tankUp" ofType:@"png"]];
    
    
    
    
    _person.isMoving = NO;
    
    
    
    
    
    
    
    
    
    
    //创建障碍
    for (int i = 0 ; i <=6; i++) {
        
        if (i==2||i==3) {
            continue;
        }
        
        WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i*45+30,400, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            image.frame = CGRectMake((i*45+30)*_zoom,(400)*_zoom, hi, hi);
            
        }
        [image setImage:allImage.tankWallImage];
        
        [backGroundview addSubview:image];
        
        [_wallArray addObject:image];
    }
    
    
    for (int i = 0 ; i <=60; i++) {
        
        if (i==2||i==3||i==42||i==46||i==18||i==22||i==35||i==39||i==25||i==11||i==9||i==31||i==46||i==52||i==53||i==60) {
            WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i%7*45+30,120+i/7*40, 40, 40)];
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                image.frame = CGRectMake((i%7*45+30)*_zoom,(120+i/7*40)*_zoom, 30, 30);
                
            }
            [image setImage:allImage.tankWallImage];
            
            [backGroundview addSubview:image];
            
            [_wallArray addObject:image];
        }
       
    }
    //创建障碍
    
    
    
    
    
    
    
    
    //创建漏水点
    
    int j =175;
    for (int i = 0 ; i <3; i++) {
        if (i==2) {
            j=135;
        }
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(33+i*j, 280, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake((33+i*j)*_zoom,(288)*_zoom, hi, hi);
            
        }
        
        [_pointArray addObject:point];
    }
    for (int i = 0 ; i <1; i++) {
        
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(165, 200, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake((165)*_zoom,(200)*_zoom, hi, hi);
            
        }
        
        [_pointArray addObject:point];
    }
    for (int i = 0 ; i <1; i++) {
        
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(120, 480, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake((120)*_zoom,(480)*_zoom, hi, hi);
            
        }
        
        [_pointArray addObject:point];
    }
    //   创建箱子
    for (int i =0 ; i<5; i++) {
        WLTBox * box = [[WLTBox alloc]init];
      
        box.frame = CGRectMake(75+i*45, 520, 40, 40);
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
           box.frame = CGRectMake((75+i*45)*_zoom,(520)*_zoom, hi, hi);
            
        }
          box.image = allImage.stoneImage;
        box.direction=direction_BOXNIL;
        [backGroundview addSubview:box];
        [_boxArray addObject:box];
        
    }
    
    for (WLTPoint * point in _pointArray) {
        [point setAnimationDuration:2];
        [point setAnimationImages:pointArray1];
        [point setAnimationRepeatCount:0];
        [point startAnimating];
        [backGroundview addSubview:point];
        [backGroundview insertSubview:_person belowSubview:point];
        point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
        point.layer.cornerRadius = 10;
    }
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"8"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
   
  
    [backGroundview addSubview:_person];
    
      [backGroundview addSubview:_levelAnimation];
   
    return backGroundview;
    
    
    
    
}


-(UIImageView *)map9{
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
    
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    [self levelLabel: @"level9"];
    
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 50, 35, 35)];
    
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        _person.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2,50, 30, 30);
        
    }
    
    
    
    _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tankDown" ofType:@"png"]];
    
    
    
    
    _person.isMoving = NO;
    
    
    
    //创建漏水点
    
    int j =80;
    for (int i = 0 ; i <3; i++) {
        if (i==2) {
            j=60;
        }
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(165, 320+i*j, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake((165)*_zoom,(320+i*j)*_zoom, 30, 30);
            
        }
         [_pointArray addObject:point];
    }
   
    for (int i = 0 ; i <2; i++) {
       
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(165+i*40, 200-i*40, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake((165+i*40)*_zoom,(200-i*40)*_zoom, 30, 30);
            
        }
        [_pointArray addObject:point];
    }
    
    for (int i = 0 ; i <1; i++) {
        
        WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(75, 560, 40, 40)];
        if (iPhone5||(Screen_width==320&&Screen_height==480)) {
            point.frame = CGRectMake(65,472, 30, 30);
            
        }
        [_pointArray addObject:point];
    }
    
        for (WLTPoint * point in _pointArray) {
            [point setAnimationDuration:2];
            [point setAnimationImages:pointArray1];
            [point setAnimationRepeatCount:0];
            [point startAnimating];
            [backGroundview addSubview:point];
            [backGroundview insertSubview:_person belowSubview:point];
            point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
            point.layer.cornerRadius = 10;
        }
    

    
    
    
    
    
    
    //创建障碍
    
    
    for (int i = 0 ; i <=83; i++) {
        
        if (i==1||i==5||i==7||i==22||i==34||i==28||i==23||i==35||i==39||i==74||i==10||i==61||i==31||i==53||i==51||i==69||i==60||i==13||i==65||i==77||i==71) {
            WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i%7*45+30,120+i/7*40, 40, 40)];
            
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                image.frame = CGRectMake((i%7*45+30)*_zoom,(120+i/7*40)*_zoom, 30, 30);
                
            }
            [image setImage:allImage.tankWallImage];
            [backGroundview addSubview:image];
            
            [_wallArray addObject:image];
           
        }else if(i==18||i==3||i==43||i==47||i==50||i==73)
        {
            WLTBox * box = [[WLTBox alloc]init];
            
            box.frame = CGRectMake(i%7*45+30,120+i/7*40, 40, 40);
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                box.frame = CGRectMake((i%7*45+30)*_zoom,(120+i/7*40)*_zoom, 30, 30);
                
            }
            box.image = allImage.stoneImage;
            box.direction=direction_BOXNIL;
            [backGroundview addSubview:box];
            [_boxArray addObject:box];
         
            
            
            
            
        }

        
        else {
            WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i%7*45+30,120+i/7*40, 40, 40)];
            
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                image.frame = CGRectMake((i%7*45+30)*_zoom,(120+i/7*40)*_zoom, 30, 30);
                
            }
            [image setImage:allImage.wallImage2];
            image.isCrash = YES;
            [backGroundview addSubview:image];
            
            [_wallArray addObject:image];

            
        }
        
        
    }
  
 
    
  
    
    
  
   
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"9"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
    
    
    [backGroundview addSubview:_person];
    
    [backGroundview addSubview:_levelAnimation];
    return  backGroundview;
    
}

-(UIImageView *)map10{
    [_boxArray removeAllObjects];
    [_wallArray removeAllObjects];
    [_pointArray removeAllObjects];
    [_ItemArray removeAllObjects];
    _gatherCount = 0;
    //关卡界面
    
    backGroundview  = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    [backGroundview setImage:allImage.backgroundImage];
    backGroundview.userInteractionEnabled = YES;
    //关卡标题
    
    [self levelLabel: @"level10"];
    
    
    
    _person = [[WLTPersonView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+240, 35, 35)];
    
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        _person.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-20, [UIScreen mainScreen].bounds.size.height/2+200, 30, 30);
        
    }
    
    
    
    _person.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tankUp" ofType:@"png"]];
    
    
    
    
    _person.isMoving = NO;
    
    
    
    
    
    
    
    
    
    
    //创建障碍
    //创建障碍
    
    
    for (int i = 0 ; i <=83; i++) {
        
        if (i==3||i==2||i==13||i==12||i==74||i==28||i==23||i==35||i==31||i==74||i==22||i==31||i==31||i==53||i==51||i==63||i==62||i==25||i==67||i==71||i==21||i==65||i==72||i==79||i==38) {
            
            
            
            WLTBox * box = [[WLTBox alloc]init];
            
            box.frame = CGRectMake(i%7*45+30,50+i/7*40, 40, 40);
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                box.frame = CGRectMake((i%7*45+30)*_zoom,(50+i/7*40)*_zoom, 30, 30);
                
            }
            box.image = allImage.stoneImage;
            box.direction=direction_BOXNIL;
            [backGroundview addSubview:box];
            [_boxArray addObject:box];
            
            
            
                  }else if(i==18||i==3||i==43||i==47||i==50||i==73||i==10||i==32||i==33||i==48||i==59||i==78||i==49||i==52||i==72||i==12||i==31||i==34||i==40||i==69||i==81)
        {
           
            
            WLTPoint * point = [[WLTPoint alloc]initWithFrame:CGRectMake(i%7*45+30,50+i/7*40, 40, 40)];
            
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                point.frame = CGRectMake((i%7*45+30)*_zoom,(50+i/7*40)*_zoom, 30, 30);
                
                
            }
            
            [_pointArray addObject:point];
            

            
            
            
        }else {
           
            WLTWall * image = [[WLTWall alloc]initWithFrame:CGRectMake(i%7*45+30,50+i/7*40, 40, 40)];
            
            if (iPhone5||(Screen_width==320&&Screen_height==480)) {
                image.frame = CGRectMake((i%7*45+30)*_zoom,(50+i/7*40)*_zoom, 30, 30);
                
            }
            [image setImage:allImage.wallImage2];
            image.isCrash = YES;
            [backGroundview addSubview:image];
            
            [_wallArray addObject:image];
            

            
            
            
            
        }
        
        
        
        
        
        
    }
    //创建障碍
    
    
    
    
    
    
    
    
    //创建漏水点
    
  
 
      for (WLTPoint * point in _pointArray) {
        [point setAnimationDuration:2];
        [point setAnimationImages:pointArray1];
        [point setAnimationRepeatCount:0];
        [point startAnimating];
        [backGroundview addSubview:point];
        [backGroundview insertSubview:_person belowSubview:point];
        point.layer.backgroundColor= [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1]CGColor];
        point.layer.cornerRadius = 10;
    }
    
    
    NSMutableArray * animation = [[NSMutableArray alloc]init];
    
    
    UIImage * image1 = [allImage getLevelImageIndex:@"10"];
    [animation addObject:image1];
    
    _levelAnimation = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_levelAnimation setAnimationImages:animation];
    [_levelAnimation setAnimationRepeatCount:1];
    [_levelAnimation setAnimationDuration:1];
    
    
    [backGroundview addSubview:_person];
    
    [backGroundview addSubview:_levelAnimation];
    WLTAnimationManager * boom = [WLTAnimationManager shareManager];
   
    [backGroundview addSubview:boom.Explode];
     [boom.Explode startAnimating];
    return  backGroundview;
}
-(void)addtext:(NSString *)text{
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(_person.frame.origin.x, _person.frame.origin.y-50, 80,100)];
  
    
    [_label setFont:[UIFont boldSystemFontOfSize:15]];
    [_label setTextColor:[UIColor whiteColor]];
    [_label setNumberOfLines:0];
    [_label setLineBreakMode:NSLineBreakByCharWrapping];
    [_label setText:text];
    [backGroundview addSubview:_label];
    
    
}
-(void)levelLabel:(NSString *)levelName{
    UILabel * table;
    if (table ==nil) {
        table = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 100, 30)];
    }
    
    
    
    
    
    table.text=levelName;
    table.textColor = [UIColor whiteColor];
    [table setFont:[UIFont boldSystemFontOfSize:20]];
    [table setFont:[UIFont fontWithName:@"Bradley Hand" size:25]];
    table.layer.shadowColor = [[UIColor blackColor]CGColor];
    table.layer.shadowOffset = CGSizeMake(4, 4);
    table.layer.shadowOpacity = 10;
    table.layer.shadowRadius = 1;
    
    [backGroundview addSubview:table];
  
   
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1.第7关用得 先去获取到当前的偏移量
    
  
    float page =  scrollView.contentOffset.x;
    ;
    if (page==40) {
        WLTWall * wall = (id)[backGroundview viewWithTag:20];
        
        
        wall.isCrash =YES;
        [scrollView setHidden:YES];
        [wall setHidden:NO];
         [self addtext:@"竟然藏着一辆坦克！。"];
    }
    if (iPhone5||(Screen_width==320&&Screen_height==480)) {
        
    
    if (page==35) {
        WLTWall * wall = (id)[backGroundview viewWithTag:20];
        
       
        wall.isCrash =YES;
        [scrollView setHidden:YES];
        [wall setHidden:NO];
        [self addtext:@"竟然藏着一辆坦克！。"];
    }
 }
    
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
