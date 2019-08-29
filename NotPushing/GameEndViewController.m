//
//  GameEndViewController.m
//  WLT优化game
//
//  Created by MS on 15-10-11.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "GameEndViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WLTSongManager.h"
#import "WLTAnalysis.h"
#import "Header.h"
@interface GameEndViewController ()<AVAudioPlayerDelegate>{
    AVAudioPlayer * _player;//音乐
    
    NSTimer * _timer9;//播放背景音乐
    NSTimer * _lyctimer;//显示字幕
    
}


@end

@implementation GameEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * endBack = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [endBack setImage:[UIImage imageNamed:@"10196500.JPG"]];
    [self.view addSubview:endBack];
    //创建label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, endBack.frame.size.width-100, 150)];
    
    if(iPhone5){
        
        label.frame =CGRectMake(50*0.85, 30*0.85, (endBack.frame.size.width-100)*0.85, 150*0.85);
        
        
    }
 
    //设置字体颜色
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 3000;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [endBack addSubview:label];
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i = 1; i<=7; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"lufei%d",i]];
        [array addObject:image];
        
    }
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(90, 510, 200, 185)];
    image.layer.masksToBounds= YES;
    image.layer.cornerRadius = 20;
    if(iPhone5){
        
        image.frame =CGRectMake(90*0.85, 510*0.85, (200)*0.85, 185*0.85);
        
        
    }
    [endBack addSubview:image];
    [image setAnimationImages:array];
    [image setAnimationDuration:2];
    [image setAnimationRepeatCount:0];
    [image startAnimating];
    image.layer.shadowColor = [[UIColor blackColor]CGColor];
    image.layer.shadowOffset =CGSizeMake(4, 4);
    image.layer.shadowOpacity = 10;
    image.layer.shadowRadius = 10;
    [self playMusic];
    
   
    //调用背景音乐
_lyctimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(lycshow) userInfo:nil repeats:YES];
     _timer9 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(musicTime) userInfo:nil repeats:NO];
}
-(void)lycshow{
    
    UILabel * label = (UILabel *)[self.view viewWithTag:3000];
    
    //通过时间拿到歌词
    NSString * lyric = [[WLTAnalysis sharemanage] showLyricWithTime:_player.currentTime];
    
    label.text = lyric;
    
    
}
- (void)playMusic{
  
    
        WLTAnalysis * analysis = [WLTAnalysis sharemanage];
        [analysis analysisLyricWithPath:[[NSBundle mainBundle] pathForResource:@"end" ofType:@"lrc"]];
    
    
    NSURL * url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bgm_ending_0" ofType:@"m4a"]];
    
    //1.实例化音乐播放器
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //2.准备播放
    [_player prepareToPlay];
    
    _player.delegate = self; //delegate协议必须写到 [_player prepareToPlay];之后。。。。。否则无效果
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)musicTime{
    
    [WLTSongManager defaultManager];
    [self playMusic];
    [_player play];
    
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    //歌曲播放完后 停止音乐并 回到主界面
    [_player stop];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSLog(@"结束了");
    
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