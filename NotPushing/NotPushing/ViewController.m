//
//  ViewController.m
//  这不是推箱子
//
//  Created by MS on 15-9-24.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "ViewController.h"
#import "WLTPersonView.h"
#import "WLTAnimationManager.h"
#import "WLTBox.h"
#import "WLTMap.h"
#import "WLTWall.h"
#import <AVFoundation/AVFoundation.h>
#import "WLTSongManager.h"
#import "WLTAnalysis.h"
#import "Header.h"
#import "UIView+TransitionAnimation.h"
#import "WLTLevel.h"
#import  "WLTData.h"
#import "GameEndViewController.h"
#import "WLTTimeView.h"
#import "WLTTime.h"
#import "WLTImage.h"


@interface ViewController ()<AVAudioPlayerDelegate,sendValueDelegate>{
    AVAudioPlayer * _player;//音乐
    
    WLTTime * _timeData;
    
    WLTImage * allImage;
    
}
@end

@implementation ViewController
{
    
    // 声明一直存在的物体为 全局变量
    
    NSTimer * _timer;//负责人物移动
    NSTimer * _timer2;//负责关卡计时
    UILabel * _label;//显示时间
    NSTimer * _timer6;//循环箱子是否达到目的地
    NSTimer * _timer7;//循环检测玩家摆放箱子的成功数量
    //  NSTimer * _timer8;//循环检测是否通关
    NSTimer * _timer9;//播放背景音乐
    NSTimer * _lyctimer;//显示字幕
    
    NSTimer * showText;//显示对白语句
    
    NSTimer * _boxTimer;//箱子完成后要有点的属性一致
    NSMutableArray * boxArray;//所有箱子
    NSMutableArray * wallArray;//所有墙体
    NSMutableArray * pointArray;//所以完成点
    CGRect personRect; //碰撞到墙时人物所在位置
    CGRect  wallRect; //碰到的墙所在位置
    CGRect boxRect;//碰到墙时箱子所在位置
    CGRect rectBoxall;//获取移动箱子的位置
    
    
    
    
    
    
    WLTBox * _box;
    WLTPoint * _point; //用于将箱子位置移动到未移动过的漏水点
    
    
    
    int i;//控制对白字幕播放的时间
    int j;//控制物品出现状态
    
    NSUInteger musicIndex;
    
    NSUInteger playerAnimation;
    
    int mm,ss,SS;
    
    int _speed;
    
    //为去除警告而设置全局
    NSTimer * timer12;
    NSTimer * timer11;
    
    int countStop;//判断多点操作什么时候停止移动
}
//隐藏状态栏

- (void)viewDidLoad {
    [super viewDidLoad];
    allImage = [WLTImage sharedWLTImage];
    [self creatUI];
    [[WLTData sharedWLTData] SavePlayer:0];
    [[WLTAnimationManager shareManager] choosePlayerAnimation:0];
    _player.delegate = self;
    //调用背景音乐
    
    // 添加定时器
    _box = [[WLTBox alloc]init];
    _point = [[WLTPoint alloc]init];
    //初始化时间数据
    
    _timeData = [[WLTTime alloc]init];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(gameloop) userInfo:nil repeats:YES];
    
    
    
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(levelTime) userInfo:nil repeats:YES];
    
    [_timer2 setFireDate:[NSDate distantFuture]];//时间暂停
    
    
    
    
    _timer6 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(complete) userInfo:nil repeats:YES];
    
    
    _timer7 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(completeCount) userInfo:nil repeats:YES];
    
    _boxTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(boxTimer) userInfo:nil repeats:YES];
    //    _timer8 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(end1) userInfo:nil repeats:YES];
    
    
    
    
    wallRect = CGRectMake(10, 10, 10, 10);//随意设置一个位置，使默认的墙体和人物的位置不相同
    
    //1秒后调用背景音乐
    _timer9 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(musicTime) userInfo:nil repeats:NO];
    
    showText = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showText) userInfo:nil repeats:YES];
    
    _speed = SPEED;
    
    
    
}
-(void)creatUI{
    countStop=0;
    playerAnimation = [[WLTData sharedWLTData] LoadPlayer];
    [[WLTAnimationManager shareManager] choosePlayerAnimation:playerAnimation];
    WLTMap * map = [WLTMap sharedWltMap];//利用单例可以用于类之间数据的传输。
    UIImageView * backGroundview = [[UIImageView alloc]init];
    SS=0;ss=0;mm=0; //重置所有时间
    [_timer2 setFireDate:[NSDate distantFuture]];//时间暂停
    [showText setFireDate:[NSDate distantFuture]];
    i=0;
    j=0;
    switch (_level) {
            
        case 0:
            backGroundview = [map map1];
            
            break;
        case 1: {
            
            backGroundview = [map map2];
            
        }
            break;
        case 2: {
            
            [showText setFireDate:[NSDate distantPast]];
            
            backGroundview = [map map3];
            
        }
            break;
        case 3: {
            backGroundview = [map map4];
        }
            break;
        case 4: {
            backGroundview = [map map5];
        }
            break;
        case 5: {
            [showText setFireDate:[NSDate distantPast]];
            backGroundview = [map map6];
        }
            break;
        case 6: {
            [showText setFireDate:[NSDate distantPast]];
            backGroundview = [map map7];
        }
            break;
        case 7: {
            
            backGroundview = [map map8];
        }
            break;
        case 8: {
            backGroundview = [map map9];
        }
            
            break;
        case 9: {
            backGroundview = [map map10];
        }
        default:
            break;
    }
    
    
    
    
    
    
    
    [self.view addSubview:backGroundview];
    [backGroundview setTag:1000];
    CGFloat h = 500;
    
    
    UIButton * buttonDown = [[UIButton alloc]initWithFrame:CGRectMake(100, h+70, 60, 60)];
    [buttonDown setImage:allImage.imageDown forState:UIControlStateNormal];
    [backGroundview addSubview:buttonDown];
    UIButton * buttonUp = [[UIButton alloc]initWithFrame:CGRectMake(100, h-10, 60, 60)];
    [buttonUp setImage:allImage.imageUp forState:UIControlStateNormal];
    [backGroundview addSubview:buttonUp];
    UIButton * buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(10, h+70, 60, 60)];
    [buttonLeft setImage:allImage.imageLeft forState:UIControlStateNormal];
    [backGroundview addSubview:buttonLeft];
    UIButton * buttonRight = [[UIButton alloc]initWithFrame:CGRectMake(190, h+70, 60, 60)];
    //按钮适配IPHONE5
    if (iPhone5) {
        h=420;
        buttonDown.frame =CGRectMake(100, h+70, 80, 80);
        buttonUp.frame =CGRectMake(100, h-10, 80, 80);
        buttonLeft.frame =CGRectMake(10, h+70, 80, 80);
        buttonRight.frame =CGRectMake(190, h+70, 80, 80);
    }
    
    if(Screen_width==320&&Screen_height==480){
        
        h=320;
        buttonDown.frame =CGRectMake(100, h+70, 60, 60);
        buttonUp.frame =CGRectMake(100, h-10, 60, 60);
        buttonLeft.frame =CGRectMake(10, h+70, 60, 60);
        buttonRight.frame =CGRectMake(190, h+70, 60, 60);
        
        
    }
    [buttonRight setImage:allImage.imageRight forState:UIControlStateNormal];
    [backGroundview addSubview:buttonRight];
    buttonDown.alpha=0.3;
    buttonLeft.alpha=0.3;
    buttonRight.alpha=0.3;
    buttonUp.alpha =0.3;
    //添加重置游戏按钮
    
    UIButton * Reset = [[UIButton alloc]initWithFrame:CGRectMake(20, 3, 40, 40)];
    //适配IPHONE5
    if (iPhone5) {
        Reset.frame =CGRectMake(210, 2, 30, 30);
    }
    if(Screen_width==320&&Screen_height==480){
    
        Reset.frame =CGRectMake(210, 2, 30, 30);
        
        
    }
    [Reset setImage:[UIImage imageNamed:@"重置按钮.png"] forState:UIControlStateNormal];
    Reset.layer.shadowColor = [[UIColor blackColor]CGColor];
    Reset.layer.shadowOffset = CGSizeMake(3, 3);
    Reset.layer.shadowOpacity = 5;
    Reset.layer.shadowRadius = 2;
    
    [backGroundview addSubview:Reset];
    [Reset addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    //菜单标题
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(300, 10, 50, 30)];
    //适配IPHONE5
    if (iPhone5) {
        button.frame =CGRectMake(250, 10, 40, 20);
    }
    if(Screen_width==320&&Screen_height==480){
        
        button.frame =CGRectMake(250, 10, 40, 20);
        
        
    }
    [button setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    button.layer.shadowColor = [[UIColor blackColor]CGColor];
    button.layer.shadowOffset = CGSizeMake(2, 2);
    button.layer.shadowOpacity = 3;
    button.layer.shadowRadius = 2;
    [button addTarget:self action:@selector(setHiddenMenu) forControlEvents:UIControlEventTouchUpInside];
    [backGroundview addSubview:button];
    //创建菜单
    
    [self menuShow];
    
    //设置按钮控制小人的移动
    [buttonDown addTarget:self action:@selector(personMove:) forControlEvents:UIControlEventTouchDown];
    [buttonUp addTarget:self action:@selector(personMove:) forControlEvents:UIControlEventTouchDown];
    [buttonLeft addTarget:self action:@selector(personMove:) forControlEvents:UIControlEventTouchDown];
    [buttonRight addTarget:self action:@selector(personMove:) forControlEvents:UIControlEventTouchDown];
    
    //设置按钮弹起小人停止移动
    [buttonDown addTarget:self action:@selector(endMove:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    [buttonUp addTarget:self action:@selector(endMove:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    [buttonLeft addTarget:self action:@selector(endMove:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    [buttonRight addTarget:self action:@selector(endMove:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
    
    
    //设置按钮的TAG
    
    [buttonDown setTag:BUTTON_TAG+direction_DOWN];
    [buttonUp setTag:BUTTON_TAG+direction_UP];
    [buttonRight setTag:BUTTON_TAG+direction_RIGHT];
    [buttonLeft setTag:BUTTON_TAG+direction_LEFT];
    
    
    
    
    
    
    
    //创建箱子
    boxArray = [[NSMutableArray alloc]initWithArray:map.boxArray];
    
    
    //创建墙
    wallArray = [[NSMutableArray alloc]init];
    [wallArray addObjectsFromArray:map.wallArray];
    
    //添加完成点
    pointArray = [[NSMutableArray alloc]initWithArray:map.pointArray];
    
    //播放开始关卡动画
    
    
    [map.levelAnimation startAnimating];
    
    //创建关卡过关计时器
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 35)];
    
    _label.text = @"通关用时 00:00.00";
    
    _label.textColor = [UIColor whiteColor];
    [_label setTextAlignment:NSTextAlignmentCenter];
    _label.font = [UIFont boldSystemFontOfSize:20];
    //适配IPHONE5
    if(iPhone5){
        _label.frame = CGRectMake(0, 3, self.view.frame.size.width-40, 35);
        _label.font = [UIFont boldSystemFontOfSize:15];
        
        
    }
    if(Screen_width==320&&Screen_height==480){
        
        _label.frame = CGRectMake(0, 3, self.view.frame.size.width-40, 35);
        _label.font = [UIFont boldSystemFontOfSize:15];
        
    }
    
    [backGroundview insertSubview:_label atIndex:2];
    
    [backGroundview addSubview:_label];
    
    //播放关卡开始地图 加到这里可以覆盖掉4个按钮
    [backGroundview addSubview:map.levelAnimation];
    [map.levelAnimation startAnimating];
}

//背景音乐
- (void)playMusic{
    
    //因为第一首歌没有歌词 所以要判断下 否则会卡主不动
    
    
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bgm_worldmap" ofType:@"m4a"]];
    
    //1.实例化音乐播放器
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //2.准备播放
    [_player prepareToPlay];
    
    _player.delegate = self; //delegate协议必须写到 [_player prepareToPlay];之后。。。。。否则无效果
    
    
}
-(void)menuShow{
    
    UIImageView * background = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    background.image = [UIImage imageNamed:@"菜单背景.png"];
    [self.view addSubview:background];
    background.tag = 1001;
    background.alpha=0.7;
    background.userInteractionEnabled =YES;
    UIButton * back = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 96, 92)];
    [back setImage:[UIImage imageNamed:@"继续.png"] forState:UIControlStateNormal];
    [background addSubview:back];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * level = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 96, 92)];
    [level setImage:[UIImage imageNamed:@"关卡.png"] forState:UIControlStateNormal];
    [background addSubview:level];
    [level addTarget:self action:@selector(chooselevel:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * Themain = [[UIButton alloc]initWithFrame:CGRectMake(75, 400, 150, 92)];
    [Themain setImage:[UIImage imageNamed:@"主菜单.png"] forState:UIControlStateNormal];
    [background addSubview:Themain];
    [Themain addTarget:self action:@selector(Themain) forControlEvents:UIControlEventTouchUpInside];
    
    if(Screen_width==320&&Screen_height==480){
        back.frame =CGRectMake(100, 150, 76, 72);
        level.frame =CGRectMake(100, 250, 76, 72);
       Themain.frame =CGRectMake(75, 350, 120, 72);
        
    }
    background.hidden = YES;
    
    
    
    
}
-(void)Themain{
    
    [boxArray removeAllObjects];
    [wallArray removeAllObjects];
    [ _timer setFireDate:[NSDate distantFuture]];
    [_timer6  setFireDate:[NSDate distantFuture]];
    [_timer7 setFireDate:[NSDate distantFuture]];
    [_boxTimer setFireDate:[NSDate distantFuture]];
    [showText setFireDate:[NSDate distantFuture]];
    [_timer2 setFireDate:[NSDate distantFuture]];
    [_player stop];
    UIImageView * backGroundview = (UIImageView *)[self.view viewWithTag:1000];
    UIImageView * backGroundview2 = (UIImageView *)[self.view viewWithTag:1001];
    [backGroundview removeFromSuperview];
    [backGroundview2 removeFromSuperview];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
-(void)setHiddenMenu{
    [ _timer setFireDate:[NSDate distantFuture]];
    [_timer6  setFireDate:[NSDate distantFuture]];
    [_timer7 setFireDate:[NSDate distantFuture]];
    [_boxTimer setFireDate:[NSDate distantFuture]];
    [showText setFireDate:[NSDate distantFuture]];
    [_timer2 setFireDate:[NSDate distantFuture]];
    UIImageView * background = (UIImageView *)[self.view viewWithTag:1001];
    
    [background setHidden:NO];
    
}

//返回继续按钮
-(void)back{
    [ _timer setFireDate:[NSDate distantPast]];
    [_timer6  setFireDate:[NSDate distantPast]];
    [_timer7 setFireDate:[NSDate distantPast]];
    [_boxTimer setFireDate:[NSDate distantPast]];
    [showText setFireDate:[NSDate distantPast]];
    [_timer2 setFireDate:[NSDate distantPast]];
    UIImageView * background = (UIImageView *)[self.view viewWithTag:1001];
    
    [background setHidden:YES];
    
}
-(void)chooselevel:(UIButton *)button{
    
    
    
    //这里暂时采用协议方法回传值 但是我想如果用 消息中心（观察者）方法会更简单
    WLTLevel * levelmenu = [[WLTLevel alloc]init];
    levelmenu.delegate = self;
    
    
    
    
    [self presentViewController:levelmenu animated:YES completion:nil];
    
    
}

-(void)getValue:(NSUInteger)ret{
    
    switch (ret) {
        case 0:
            _level = 0;
            break;
        case 1:
            _level = 1;
            break;
        case 2:
            _level = 2;
            break;
        case 3:
            _level = 3;
            break;
        case 4:
            _level = 4;
            break;
        case 5:
            _level = 5;
            break;
        case 6:
            _level = 6;
            break;
        case 7:
            _level = 7;
            break;
        case 8:
            _level = 8;
            break;
        case 9:
            _level = 9;
            break;
            
            
        default:
            break;
    }
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer2 setFireDate:[NSDate distantFuture]];
    
    [_timer6 setFireDate:[NSDate distantFuture]];
    [_timer7 setFireDate:[NSDate distantFuture]];
    
    UIImageView * backGroundview = (UIImageView *)[self.view viewWithTag:1000];
    [backGroundview removeFromSuperview];
    UIImageView * backGroundview2= (UIImageView *)[self.view viewWithTag:1001];
    [backGroundview2 removeFromSuperview];
    
    [self creatUI];
    NSLog(@"创建");
    [_timer setFireDate:[NSDate distantPast]];
    
    
    
    
    [_timer6 setFireDate:[NSDate distantPast]];
    
    [_timer7 setFireDate:[NSDate distantPast]];
    
    
    
}
-(void)personMove:(UIButton *)btn{
    
    countStop++;
    
    //开始移动
    WLTMap * mapAnd1 = [WLTMap sharedWltMap];
    mapAnd1.person.direction = btn.tag - BUTTON_TAG;
    mapAnd1.person.isMoving = YES;
    if (mapAnd1.gatherCount!=mapAnd1.pointArray.count) {
        [_timer2 setFireDate:[NSDate distantPast]];
    }
    
    WLTAnimationManager * manager = [WLTAnimationManager shareManager];
    if(_level==7||_level==8||_level==9){
        [manager choosePlayerAnimation:2];
    }
    mapAnd1.person.image=[manager getAnimationArrywith:mapAnd1.person.direction][0];
    [mapAnd1.person setAnimationImages:[manager getAnimationArrywith:mapAnd1.person.direction]];
    mapAnd1.person.animationDuration = 0.3;
    mapAnd1.person.animationRepeatCount = 0;
    [mapAnd1.person startAnimating];
    
    
}
//按钮弹起 人物停止运动时的事件
-(void)endMove:(UIButton *)btn{
    countStop--;
    
    
    if (countStop==0) {
        WLTMap * mapAnd1 = [WLTMap sharedWltMap];
        mapAnd1.person.isMoving = NO;
        
        
        [mapAnd1.person stopAnimating];
    }
    
    
    
    
    
    
}















-(void)boxTimer{
    
    for (WLTBox * box in boxArray) {
        for (WLTPoint * point in pointArray ) {
            if (point.isComplete==YES&&(CGRectIntersectsRect(box.frame, point.frame))) {
                box.isMoving=YES;
                
            }
        }
    }
    
    
    
    
    
}

//人物和箱子移动的判断
-(void)gameloop{
    
    WLTMap * mapAnd1 = [WLTMap sharedWltMap];
    
    if (mapAnd1.person.isMoving == YES) {//这里的判断必须加上箱子和人物重叠时也要执行箱子的移动 否则当鼠标弹起时，人物移动为NO，就无法执行箱子的移动
        CGRect rect = mapAnd1.person.frame;
        WLTBox * pushBox = [[WLTBox alloc]init];
        //这里的距离有问题 改为初始化值
        
        
        int _down=80,_boxDown=80,_up=40,_boxUp=40,_left=25,_boxleft=30,_right=60,_boxRihght=60;
        //IPHONE5适配
        if (iPhone5) {
            _down=65,_boxDown=70;
            _up=30,_boxUp=35,_left=20,_boxleft=25,_right=40,_boxRihght=55;
        }
        if(Screen_width==320&&Screen_height==480){
            
            _down=55,_boxDown=60;
            _up=30,_boxUp=35,_left=20,_boxleft=25,_right=40,_boxRihght=55;
            
            
        }
        CGRect rectBox;
        int count = 0; //判断人同时推了几个箱子
        switch (mapAnd1.person.direction) {
            case direction_DOWN:
                
                
                
            {
                
                if (rect.origin.y+_speed<[UIScreen mainScreen].bounds.size.height-_down){
                    
                    rect.origin.y+= _speed;
                    
                    for (WLTBox * box in boxArray) {
                        if (CGRectIntersectsRect(rect, box.frame)) {
                            pushBox = box;
                            rectBox = box.frame;
                            count++;
                            
                        }
                    }
                    if (count>1) {
                        rect.origin.y-= _speed;
                    }
                    if( CGRectIntersectsRect(rect,pushBox.frame)&&rectBox.origin.y+_speed<[UIScreen mainScreen].bounds.size.height-_boxDown&&(pushBox.isMoving==NO)){
                        
                        
                        pushBox.direction =direction_BOXDOWN;
                        rectBox.origin.y  += _speed;
                        
                        
                    }
                    for (WLTWall * wall in wallArray) {
                        
                        
                        if (CGRectIntersectsRect(pushBox.frame, rect)&&CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.y-= _speed;
                            mapAnd1.person.isMoving = NO;
                            //这里判断人同时与箱子和墙相撞时得动作，要加上mapAnd1.person.isMoving = NO; 反则会有回弹的效果。
                        }
                        if (CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.y-= _speed;
                            
                            
                        }
                        if (CGRectIntersectsRect(rectBox, wall.frame)) {
                            rectBox.origin.y  -= _speed;
                        }
                        if (CGRectIntersectsRect(mapAnd1.person.frame, wall.frame)&&wall.isCrash==YES) {
                            
                            wall.frame =CGRectMake(1000,1000, 0, 0);
                            
                            if(_level==6&&j==0){
                                [[WLTAnimationManager shareManager]
                                 choosePlayerAnimation:2];
                                mapAnd1.person.image = [UIImage imageNamed:@"tankDown"];
                                
                                [showText setFireDate: [NSDate distantPast]];
                                for (WLTWall * wall in wallArray) {
                                    wall.isCrash = YES;
                                    
                                }
                                j=1;
                            }
                        }
                        
                    }
                    
                    //2个箱子相撞
                    for (WLTBox * box in boxArray) {
                        if (pushBox!=box) {
                            
                            
                            if (CGRectIntersectsRect(rectBox, box.frame)) {
                                
                                rectBox.origin.y  -= _speed;
                                rect.origin.y -=_speed;
                            }
                        }
                        
                    }
                    
                    
                    
                    if (CGRectIntersectsRect(rect,rectBox)){
                        
                        
                        rect.origin.y -= _speed;
                        
                        
                        
                    }
                }
            }
                break;
            case direction_UP:
                
                
                
                
                
            {
                if (rect.origin.y>_up) {
                    
                    
                    rect.origin.y-= _speed;
                    
                    for (WLTBox * box in boxArray) {
                        if (CGRectIntersectsRect(rect, box.frame)) {
                            
                            pushBox = box;
                            rectBox = box.frame;
                            count++;
                            
                        }
                    }
                    if (count>1) {
                        rect.origin.y+= _speed;
                    }
                    
                    
                    if(CGRectIntersectsRect(rect,pushBox.frame)&&rectBox.origin.y>_boxUp&&(pushBox.isMoving==NO)){
                        pushBox.direction = direction_BOXUP;
                        rectBox.origin.y  -= _speed;
                        
                        
                        
                    }
                    for (WLTWall * wall in wallArray) {
                        
                        
                        if (CGRectIntersectsRect(pushBox.frame, rect)&&CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.y+= _speed;
                            mapAnd1.person.isMoving = NO;
                            //这里判断人同时与箱子和墙相撞时得动作，要加上mapAnd1.person.isMoving = NO; 反则会有回弹的效果。
                        }
                        
                        if (CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.y+= _speed;
                            
                        }
                        if (CGRectIntersectsRect(rectBox, wall.frame)) {
                            
                            rectBox.origin.y+= _speed;
                        }
                        if (CGRectIntersectsRect(mapAnd1.person.frame, wall.frame)&&wall.isCrash==YES) {
                            
                            wall.frame =CGRectMake(1000,1000, 0, 0);
                            if(_level==6&&j==0){
                                [[WLTAnimationManager shareManager]
                                 choosePlayerAnimation:2];
                                [self personMove:nil];
                                [showText setFireDate: [NSDate distantPast]];
                                mapAnd1.person.image = [UIImage imageNamed:@"tankUp"];
                                //这里不知道为什么吃了坦克后countStop);
                                countStop--;
                                
                                for (WLTWall * wall in wallArray) {
                                    wall.isCrash = YES;
                                }
                                j=1;
                                
                            }
                            
                        }
                        
                    }
                    for (WLTBox * box in boxArray) {
                        if (pushBox!=box) {
                            
                            
                            if (CGRectIntersectsRect(rectBox, box.frame)) {
                                
                                rectBox.origin.y  += _speed;
                            }
                        }
                        
                    }
                    
                    
                    if (CGRectIntersectsRect(rect,rectBox)){
                        
                        
                        
                        rect.origin.y += _speed;
                        
                        
                        
                    }
                }
                
            }
                break;
            case direction_RIGHT:
                
                
            {
                if (rect.origin.x+_speed<[UIScreen mainScreen].bounds.size.width-_right) {
                    
                    
                    rect.origin.x+= _speed;
                    
                    for (WLTBox * box in boxArray) {
                        if (CGRectIntersectsRect(rect, box.frame)) {
                            pushBox = box;
                            rectBox = box.frame;
                            count++;
                        }
                    }
                    if (count>1) {
                        rect.origin.x-= _speed;
                    }
                    
                    if( CGRectIntersectsRect(rect,pushBox.frame)&&rectBox.origin.x+_speed<[UIScreen mainScreen].bounds.size.width-_boxRihght&&(pushBox.isMoving==NO)){
                        rectBox.origin.x  += _speed;
                        pushBox.direction = direction_BOXRIGHT;
                        
                    }
                    
                    for (WLTWall * wall in wallArray) {
                        
                        if (CGRectIntersectsRect(pushBox.frame, rect)&&CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.x-= _speed;
                            mapAnd1.person.isMoving = NO;
                            //这里判断人同时与箱子和墙相撞时得动作，要加上mapAnd1.person.isMoving = NO; 反则会有回弹的效果。
                        }
                        if (CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.x-= _speed;
                        }
                        if (CGRectIntersectsRect(rectBox, wall.frame)) {
                            
                            rectBox.origin.x-= _speed;
                        }
                        if (CGRectIntersectsRect(mapAnd1.person.frame, wall.frame)&&wall.isCrash==YES) {
                            
                            wall.frame =CGRectMake(1000, 1000, 0, 0);
                            
                            switch (_level) {
                                case 2:
                                {
                                    //第2关所需激活的道具
                                    if ([wall.itemName isEqualToString:@"药水"]) {
                                        
                                        
                                        
                                        for (WLTBox * box in boxArray) {
                                            box.isMoving = NO;
                                        }
                                        [[WLTMap sharedWltMap]addtext:@"哇!突然感觉力量好强！"];
                                        i=0; //字幕3秒后消失
                                        [showText setFireDate: [NSDate distantPast]];
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                    break;
                                    
                                default:
                                    break;
                            }
                            
                        }
                    }
                    
                    
                    for (WLTBox * box in boxArray) {
                        if (pushBox!=box) {
                            
                            
                            if (CGRectIntersectsRect(rectBox, box.frame)) {
                                
                                rectBox.origin.x  -= _speed;
                            }
                        }
                        
                    }
                    
                    if (CGRectIntersectsRect(rect,rectBox)){
                        
                        //判断2个箱子是否相撞
                        
                        rect.origin.x -= _speed;
                        
                    }
                }
            }
                break;
            case direction_LEFT:
                
                
            {
                if (rect.origin.x > _left) {
                    
                    
                    rect.origin.x-= _speed;
                    //取出当前所推箱子
                    for (WLTBox * box in boxArray) {
                        if (CGRectIntersectsRect(rect, box.frame)) {
                            pushBox = box;
                            rectBox = box.frame;
                            count++;
                        }
                    }
                    if (count>1) {
                        rect.origin.x+= _speed;
                    }
                    
                    //当前箱子与人得下一步是否相撞
                    if( CGRectIntersectsRect(rect,pushBox.frame)&&rectBox.origin.x > _boxleft&&(pushBox.isMoving==NO)){
                        rectBox.origin.x  -= _speed;
                        pushBox.direction = direction_BOXLEFT;
                        
                    }
                    for (WLTWall * wall in wallArray) {
                        
                        if (CGRectIntersectsRect(pushBox.frame, rect)&&CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.x+= _speed;
                            mapAnd1.person.isMoving = NO;
                            //这里判断人同时与箱子和墙相撞时得动作，要加上mapAnd1.person.isMoving = NO; 反则会有回弹的效果。
                        }
                        
                        if (CGRectIntersectsRect(rect, wall.frame)&&wall.isCrash==NO) {
                            
                            rect.origin.x+= _speed;
                        }
                        
                        if (CGRectIntersectsRect(rectBox, wall.frame)) {
                            
                            rectBox.origin.x+= _speed;
                        }
                        if (CGRectIntersectsRect(mapAnd1.person.frame, wall.frame)&&wall.isCrash==YES) {
                            
                            wall.frame =CGRectMake(1000,1000, 0, 0);
                            //第7关人与坦克相撞 坦克消失  人变成坦克
                            if(_level==6&&j==0){
                                [[WLTAnimationManager shareManager]
                                 choosePlayerAnimation:2];
                                mapAnd1.person.image = [UIImage imageNamed:@"tankDown"];
                                [showText setFireDate: [NSDate distantPast]];
                                for (WLTWall * wall in wallArray) {
                                    wall.isCrash = YES;
                                }
                                j=1;
                            }
                            
                        }
                    }
                    for (WLTBox * box in boxArray) {
                        if (pushBox!=box) {
                            
                            
                            if (CGRectIntersectsRect(rectBox, box.frame)) {
                                
                                rectBox.origin.x  += _speed;
                            }
                        }
                        
                    }
                    if (CGRectIntersectsRect(rect,rectBox)){
                        
                        //
                        
                        rect.origin.x += _speed;
                        
                    }
                    
                }
            }
                break;
            default:
                break;
        }if (pushBox.isMoving==NO) {
            pushBox.frame = rectBox;
        }
        
        mapAnd1.person.frame = rect;
        
        
    }
    
}
//箱子是否达到目的地
-(void)complete{
    WLTMap * map = [WLTMap sharedWltMap];
    for (WLTBox * box in boxArray) {
        
        //  NSLog(@"推箱子完成数量%ld",map.gatherCount);
        
        
        //这里的完成点必须设置成一个类，因为他循环时排除已经完成的点。所以要给他添加一个isComplete属性
        for (WLTPoint * point in map.pointArray ) {
            if (CGRectIntersectsRect(point.frame, box.frame)&&box.isMoving==NO&&point.isComplete==NO) {
                
                timer11 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animation) userInfo:nil repeats:NO];
                
                //    NSLog(@"完成%ld",map.gatherCount);
                
            }
            
            
        }
    }
    
    
}
//显示完成动画 将箱子覆盖漏水点
-(void)animation{
    WLTMap * map = [WLTMap sharedWltMap];
    for (WLTPoint * point in pointArray) {
        for (WLTBox * box in boxArray) {
            if (CGRectIntersectsRect(point.frame, box.frame))
                if (box.isMoving==NO&&point.isComplete==NO) {
                    [UIView animateWithDuration:1 animations:^{
                        //大小变小一点试试
                        box.frame = point.frame;
                        box.layer.borderColor=[UIColor colorWithRed:138/255.0 green:88/255.0 blue:52/255.0 alpha:1].CGColor;
                        box.layer.borderWidth=2;
                    }];
                    
                    box.isMoving = YES;
                    point.isComplete = YES;
                    [point removeFromSuperview];
                    map.gatherCount++;                }
            {
                
                
            }
        }
    }
    NSLog(@"%ld",(unsigned long)boxArray.count);
}
//




//推箱子完成的数量
-(void)completeCount{
    
    WLTMap * map = [WLTMap sharedWltMap];
    if (map.gatherCount == map.pointArray.count) {
        
        [_timer2 setFireDate:[NSDate distantFuture]];
        [_timer setFireDate:[NSDate distantFuture]];
        
        [_timeData loadTime];
        [_timeData saveLeveTime:_level andTime:_label.text];
        
        [_timer6 setFireDate:[NSDate distantFuture]];
        [_timer7 setFireDate:[NSDate distantFuture]];
        _level ++;
        [[WLTData sharedWLTData] saveLevel:_level];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(map.person.frame.origin.x-10, map.person.frame.origin.y+10, 80,100)];
        
        
        [label setFont:[UIFont boldSystemFontOfSize:15]];
        [label setTextColor:[UIColor blueColor]];
        [label setNumberOfLines:0];
        [label setLineBreakMode:NSLineBreakByCharWrapping];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        UIImageView * back = (UIImageView *)[self.view viewWithTag:1000];
        
        if (_level==1) {
            [back addSubview:label];
            [label setText:@"咕咚咕咚~~· 不好！下个房间也漏水了！！"];
        }
        if (_level==2) {
            [back addSubview:label];
            [label setText:@"我去，另一个房间也漏水了！"];
        }
        if (_level==3) {
            [back addSubview:label];
            [label removeFromSuperview];
            
        }
       
        if(_level==10){
            
            [[WLTMap sharedWltMap]addtext:@"啊！！！不好 有地雷！~"];
            WLTAnimationManager * animation = [WLTAnimationManager shareManager];
            animation.Explode.frame = map.person.frame;
            
            [animation.Explode startAnimating];
        }
        timer12 = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextLevel) userInfo:nil repeats:NO];
        
        
    }
    
}
-(void)nextLevel{
    
    if (_level==LEVEL+1) {
        [ _timer setFireDate:[NSDate distantFuture]];
        [_timer6  setFireDate:[NSDate distantFuture]];
        [_timer7 setFireDate:[NSDate distantFuture]];
        [_boxTimer setFireDate:[NSDate distantFuture]];
        [showText setFireDate:[NSDate distantFuture]];
        [_timer2 setFireDate:[NSDate distantFuture]];
        
        [_player stop];
        GameEndViewController * endvc = [[GameEndViewController alloc]init];
        [self.navigationController pushViewController:endvc animated:YES];
        
    }else{
        
        
        
        UIImageView * backGroundview = (UIImageView *)[self.view viewWithTag:1000];
        [backGroundview removeFromSuperview];
        UIImageView * backGroundview2 = (UIImageView *)[self.view viewWithTag:1001];
        [backGroundview2 removeFromSuperview];
        //每一次重载画面都要移除上一次的。。反则TAG值无法获取
        
        [self creatUI];
        [_timer setFireDate:[NSDate distantPast]];
        
        
        [_timer6 setFireDate:[NSDate distantPast]];
        
        [_timer7 setFireDate:[NSDate distantPast]];
    }
    
}
-(void)reset{
    [boxArray removeAllObjects];
    [wallArray removeAllObjects];
    
    
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer2 setFireDate:[NSDate distantFuture]];
    [showText setFireDate:[NSDate distantFuture]];
    [_timer6 setFireDate:[NSDate distantFuture]];
    [_timer7 setFireDate:[NSDate distantFuture]];
    UIImageView * backGroundview = (UIImageView *)[self.view viewWithTag:1000];
    UIImageView * backGroundview2 = (UIImageView *)[self.view viewWithTag:1001];
    [backGroundview removeFromSuperview];
    [backGroundview2 removeFromSuperview];
    [self creatUI];
    [_timer setFireDate:[NSDate distantPast]];
    [showText setFireDate:[NSDate distantPast]];
    [_timer6 setFireDate:[NSDate distantPast]];
    [_timer7 setFireDate:[NSDate distantPast]];
    
    
}

-(void)musicTime{
    
    
    [self playMusic];
    [_player play];
    
}
//循环播放音乐
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [_player play];
    
    
    
}

-(void)showText{
    
    if (_level==2||_level==5||_level==6) {
        i++;
        
        if (i==20) {
            
            [[WLTMap sharedWltMap].label removeFromSuperview];
            [showText setFireDate: [NSDate distantFuture]];
            i=0;
            
        }
        
    }
    
    
}

-(void)levelTime{
    
    
    SS++;
    if (SS==82) {
        SS=0,ss++;
        if (ss==60) {
            ss=0,mm++;
            if (mm==60) {
                mm=0,ss=0,SS=0;
            }
        }
    }
    
    NSString * str = [NSString stringWithFormat:@"%02d:%02d.%02d",mm,ss,SS];
    
    _label.text= [NSString stringWithFormat:@"通关用时 %@",str];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    return NO;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
