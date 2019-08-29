//
//  WLTTime.m
//  WLT优化game
//
//  Created by MS on 15-10-12.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "WLTTime.h"
#import "Header.h"

@implementation WLTTime
-(instancetype)init{
    
    if (self= [super init]) {
        
        _timeArray = [[NSMutableArray alloc]init];
        
        NSFileManager * fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:TIME_PATH]) {
            [fm createDirectoryAtPath:TIME_PATH withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
       

        
        
    }
    
    return self;
    
}

-(void)saveLeveTime:(NSUInteger)level andTime:(NSString *)time{
    
   
    
   
    [self loadTime];
    NSDate * date = [NSDate date];
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"YYYY年MM月dd日hh:mm:ss"];
    NSString * levelDate = [format stringFromDate:date];
 
    NSDateFormatter * fm = [[NSDateFormatter alloc] init];
    //设置时间格式
    //m - 分,s - 秒,S - 毫秒
    [fm setDateFormat:@"通关用时 mm:ss.SS"];
    
    //时间
    //将字符串按照一定的时间格式转换成时间
    NSDate * date1 = [fm dateFromString:time];
    //            NSLog(@"%@",date1);
    
    //转换成时间戳
    NSTimeInterval  time1 = [date1 timeIntervalSince1970];
    //            NSLog(@"%f",time1);
    
    NSDate * date2 = [fm dateFromString:@"通关用时 00:00.00"];
    NSTimeInterval time2 = [date2 timeIntervalSince1970];
    
    //最后获取到的时间戳
    NSTimeInterval levelTime = time1 - time2;

    NSMutableDictionary  * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%0.2lf",levelTime] forKey:@"用时"];
    [dict setValue:levelDate forKey:@"日期"];
    
    [_timeArray[level] addObject:dict];
    
   

    
    
    
    NSMutableArray * timeAry =_timeArray[level];
    if (timeAry.count>1) {
        
        for (int i =0; i<timeAry.count-1; i++) {
            for (int j = 0; j<timeAry.count-1-i; j++) {
                
                NSMutableDictionary * t1 = timeAry[j];
                NSMutableDictionary * t2 = timeAry[j+1];
                
                NSString * str1 = [t1 objectForKey:@"用时"];
                NSString * str2 = [t2 objectForKey:@"用时"];
                 double d1 = [str1 doubleValue];
                double d2 = [str2 doubleValue];
                if (d1>d2) {
                
                    
                    [timeAry exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    
                }
                
                
                
            }
            
        }

    }
    NSLog(@"=====%@",timeAry);
   
       [_timeArray writeToFile:TIMEPLIST_PATH atomically:YES];
    
    //如果文件读写处问题 这里的atomically:YES 改成NO试试
      NSLog(@"3 %@",TIMEPLIST_PATH);
    
}

-(void)loadTime{
    [_timeArray removeAllObjects];
    NSFileManager * fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:TIMEPLIST_PATH]) {
      
        _timeArray = [NSMutableArray arrayWithContentsOfFile:TIMEPLIST_PATH];
        NSLog(@"1 %@",TIME_PATH);
    }
    else {
        //这里的LEVEL要加1 否则会崩溃
        for (int i = 0; i<LEVEL+1; i++) {
            NSMutableArray * array = [[NSMutableArray alloc]init];
            [_timeArray addObject:array];
           
            
        }
        [_timeArray writeToFile:TIMEPLIST_PATH atomically:YES];

    }
    
    
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com