//
//  WLTMenu.m
//  WLT优化game
///data/Library/Preferences
//  Created by MS on 15-10-8.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTMenu.h"
#import "UIView+TransitionAnimation.h"
#import "WLTLevel.h"
#import <AVFoundation/AVFoundation.h>
#import "WLTMap.h"
#import "ViewController.h"
#import "Header.h"
#import  "WLTData.h"
#import "WLTTimeView.h"
@interface WLTMenu ()<AVAudioPlayerDelegate,UINavigationControllerDelegate>
{
    AVAudioPlayer * _player;
    WLTTimeView * timeView;
    ViewController * startGame;
    WLTLevel * chooseGame ;
}

@end

@implementation WLTMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
       chooseGame = [[ WLTLevel alloc]init];
     timeView = [[WLTTimeView alloc]init];
    [self creatMenu];
    
    
}
//创建主界面
-(void)creatMenu{
    
    UIImageView * background = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    background.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"主菜单背景" ofType:@"png"]];
    
    [self.view addSubview: background];
    UIButton * title = [[UIButton alloc]initWithFrame:CGRectMake(50, 20, 270, 150)];
    if(iPhone5){
        title.frame = CGRectMake(50, 20, 230, 120);
        
    }
    if(Screen_width==320&&Screen_height==480){
        
       title.frame = CGRectMake(50, 50, 230, 120);
        
        
    }
    [title setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"img2" ofType:@"png"]] forState:UIControlStateNormal];
    [self.view addSubview:title];
    [title setUserInteractionEnabled:NO];
    UIButton * playGame = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 120, 50)];
    [playGame setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"play01" ofType:@"png"]] forState:UIControlStateNormal];
    [self.view addSubview:playGame];
    
    UIButton * chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 280, 120, 50)];
    [chooseButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"selet01" ofType:@"png"]] forState:UIControlStateNormal];
    [self.view addSubview:chooseButton];
    
    UIButton * TimeList = [[UIButton alloc]initWithFrame:CGRectMake(100, 360, 120, 50)];
    [TimeList setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"timelist" ofType:@"png"]] forState:UIControlStateNormal];
    [self.view addSubview:TimeList];

    playGame.tag = PLAYGAME;
    chooseButton.tag = CHOOSEGAME;
    TimeList.tag = TIMELIST;
    [playGame addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [chooseButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    
    [TimeList addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];

    
    NSLog(@"%@",NSHomeDirectory());
    
    
    _player.delegate = self;
    
    //隐藏标题栏
    
    self.navigationController.delegate =self;
    
   
   }

-(void)choose:(UIButton *)button{
  
    
    if (button.tag==PLAYGAME) {
      startGame= [[ViewController alloc]init];
        startGame.level = [[WLTData sharedWLTData] loadLevel];
       if( [[WLTData sharedWLTData] loadLevel]==10){
          
       startGame.level =9;
       }
        [self.navigationController pushViewController:startGame animated:YES];
        
        
        
    }
    
    
    if (button.tag==CHOOSEGAME) {
     
       
         [self.navigationController pushViewController:chooseGame animated:YES];
    }
        if (button.tag==TIMELIST) {
            
           
       
       
            
            
            NSLog(@"切换完成3");
        
           
            [self.navigationController pushViewController:timeView animated:YES];
            
            
    
    
    
    
}
    

}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //隐藏导航视图控制器
    if ( viewController == self) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( viewController == timeView ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    

    [super viewDidAppear:animated];
   
    
    
}

-(void)back{
    
    
    
    [self.view.window addTransitionAnimationWithDuration:2 type:5 subType:2];
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
    
    
}

-(void)getValue:(NSUInteger)ret{
    NSLog(@"aaa");
    if (ret==1) {
        [self back];
        [self.delegate getValue:
         1];

    }
    if (ret==2) {
        [self back];
        [self.delegate getValue:
         2];

    }
    if (ret==3) {
        [self back];
        [self.delegate getValue:
         3];

    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com