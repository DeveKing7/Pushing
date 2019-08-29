//
//  WLTAnimationManager.m
//  WLT优化game
//
//  Created by MS on 15-9-24.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTAnimationManager.h"

@implementation WLTAnimationManager
{
    NSMutableDictionary * _alldict;
    
    
}
-(instancetype)init{
    
    if (self = [super init]) {
        NSMutableArray * array = [[NSMutableArray alloc]init];
        _alldict = [[NSMutableDictionary alloc]init];
        _Explode = [[UIImageView alloc]init];
        for (int i =1; i<=3; i++) {
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"baoza1_%d.png",i]];
            [array addObject:image];
        }
        [_Explode setAnimationImages:array];
        [_Explode setAnimationDuration:1];
        [_Explode  setAnimationRepeatCount:5];
        NSLog(@"爆炸");
    }

    
    
    return  self;
    
}

-(NSArray *)getAnimationArrywith:(directionEnum)direction{
    

    return [_alldict objectForKey:[NSString stringWithFormat:@"%lu",direction]];
    
    
    
    
    
}
-(void)choosePlayerAnimation:(NSUInteger)index{
    
    switch (index) {
        case 0:
            [self creatPlayer1];
            break;
        case 1:
           // 资源已删除 
        //  [self creatPlayer2];
            break;
        case 2:
            [self creatPlayer3];
            break;
        default:
            break;
    }
    
    
}
//普通人
-(void)creatPlayer1{

    [_alldict removeAllObjects];
    NSMutableArray * downArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=3; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"player_down_%d.png",i]];
        [downArray addObject:image];
    }
    [_alldict setValue:downArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_DOWN]];
    
    NSMutableArray * upArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=3; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"player_up_%d.png",i]];
        [upArray addObject:image];
    }
    [_alldict setValue:upArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_UP]];
    
    NSMutableArray * leftArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=3; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"player_left_%d.png",i]];
        [leftArray addObject:image];
    }
    [_alldict setValue:leftArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_LEFT]];
    
    NSMutableArray * rightArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=3; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"player_right_%d.png",i]];
        [rightArray addObject:image];
    }
    [_alldict setValue:rightArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_RIGHT]];
    
    
    

}
//漩涡鸣人
-(void)creatPlayer2{

    
    
}
//女火影
-(void)creatPlayer3{
    
    [_alldict removeAllObjects];
    NSMutableArray * downArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=1; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"tankDown.png"]];
        [downArray addObject:image];
    }
    [_alldict setValue:downArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_DOWN]];
    
    NSMutableArray * upArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=1; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"tankUp.png"]];
        [upArray addObject:image];
    }
    [_alldict setValue:upArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_UP]];
    
    NSMutableArray * leftArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=1; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"tankLeft.png"]];
        [leftArray addObject:image];
    }
    [_alldict setValue:leftArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_LEFT]];
    
    NSMutableArray * rightArray = [[NSMutableArray alloc] init];
    for (int i = 1 ; i<=1; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"tankRight.png"]];
        [rightArray addObject:image];
    }
    [_alldict setValue:rightArray forKey:[NSString stringWithFormat:@"%lu",(unsigned long)direction_RIGHT]];
    

    
    
}

+(WLTAnimationManager *)shareManager{
    static WLTAnimationManager * manager =nil;
    if (manager == nil) {
        manager = [[WLTAnimationManager alloc]init];
    }
    return manager;
    
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com