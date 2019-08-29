//
//  WLTLevel.m
//  WLT优化game
//
//  Created by MS on 15-10-8.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTLevel.h"
#import "UIView+TransitionAnimation.h"
#import "Header.h"
#import "ViewController.h"
#import "WLTData.h"

@interface WLTLevel (){
    
    
}
@end

@implementation WLTLevel

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIImageView * background = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    background.image = [UIImage imageNamed:@"关卡背景.png"];
    [self.view addSubview:background];
    
    background.userInteractionEnabled =YES;
    UIButton * back = [[UIButton alloc]initWithFrame:CGRectMake(250, 150, 96, 92)];
    if (iPhone5) {
        back.frame = CGRectMake(200, 150, 80, 80);
    }
    if(Screen_width==320&&Screen_height==480){
        
        back.frame = CGRectMake(200, 150, 80, 80);
        
        
    }
    [back setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [background addSubview:back];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray * levelArray = [[NSMutableArray alloc]init];
    NSMutableArray * lockArray = [[NSMutableArray alloc]init];
    for (int j = 0 ; j<2; j++) {
      
        
    for (int i = 0; i<5; i++) {
        UIButton * level = [[UIButton alloc]initWithFrame:CGRectMake(35+i*65, 250+j*70, 50, 50)];
      
             UIImageView * lock = [[UIImageView alloc]initWithFrame:CGRectMake(35+i*65, 250+j*70, 50, 50)];
            if (iPhone5) {
                lock.frame = CGRectMake(35+i*50, 250+j*55, 35, 35);
            }
        if(Screen_width==320&&Screen_height==480){
            
           lock.frame = CGRectMake(35+i*50, 250+j*55, 35, 35);
            
            
        }
        
        [lockArray addObject:lock];
      
        
        if (iPhone5) {
            level.frame = CGRectMake(35+i*50, 250+j*55, 35, 35);
        }
        if(Screen_width==320&&Screen_height==480){
            
           level.frame = CGRectMake(35+i*50, 250+j*55, 35, 35);
            
            
        }
        [levelArray addObject:level];
        
    }
     }
   
    WLTData *levelData= [WLTData sharedWLTData];
    
    for (int i = 0; i<10; i++) {
        UIButton * button = levelArray[i];
       
        [button setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"关卡%d",i+1] ofType:@"png"]] forState:UIControlStateNormal];
        button.tag = BUTTON_LEVEL+i;
        [background addSubview:button];
        //读取玩家进行到得关卡数 
        
        if (i>[levelData loadLevel]) {
            UIImageView * lock = lockArray[i];
            lock.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"suo" ofType:@"png"]];
            button.userInteractionEnabled = NO;
            [background addSubview:lock];
                      continue;
        }
        [button addTarget:self action:@selector(level:) forControlEvents:UIControlEventTouchUpInside];
        
       
    }
    
   
  

}

-(void)back{
    
    
    
  //这里2种返回方法都写上 确保系统会返回到上一页面
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)level:(UIButton *)button{
    
    switch (button.tag-BUTTON_LEVEL) {
        case 0:
            _levelIndex=0;
            break;
        case 1:{
            
        
            _levelIndex=1;
            }
            break;
        case 2:
            _levelIndex=2;
            break;
        case 3:
            _levelIndex=3;
            break;
        case 4:
            _levelIndex=4;
            break;
        case 5:
            _levelIndex=5;
            break;
        case 6:
            _levelIndex=6;
            break;
        case 7:
            _levelIndex=7;
            break;
        case 8:
            _levelIndex=8;
            break;
        case 9:
            _levelIndex=9;
            break;
       
        default:
            break;
    }
    

   
    ViewController * startGame;
    
    if ([[self delegate] respondsToSelector:@selector(getValue:)]) {
        
        [self.delegate getValue:_levelIndex];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    
    }else{
    
       startGame = [[ViewController alloc]init];
    
        startGame.level = _levelIndex;
       
        [self.navigationController pushViewController:startGame animated:YES];
    
    
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