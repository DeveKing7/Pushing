//
//  AppDelegate.m
//  NotPushing
//
//  Created by MS on 15-10-20.
//  Copyright (c) 2015年 WLT. All rights reserved.
//

#import "AppDelegate.h"
#import "WLTMenu.h"
#import "WLTImage.h"
#import "Header.h"
@interface AppDelegate (){
    NSTimer * timer;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [WLTImage sharedWLTImage];
    
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//
//
//    [self.window makeKeyAndVisible];

 [self creatMenu];
    
    
    
    return YES;
}
-(void)creatMenu{
    
    NSLog(@"width=%lf",[UIScreen mainScreen].bounds.size.width);
    NSLog(@"height=%lf",[UIScreen mainScreen].bounds.size.height);
    //他是储存在沙河路径里面的Liabry文件夹里面
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * str =[defaults valueForKey:@"first"];
    
    if (!str) {
        
        //往plist里写字符串
        [defaults setObject:@"one" forKey:@"first"];
        
        UIScrollView * scrollView =[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        scrollView.backgroundColor = [UIColor redColor];
        //要显示的图的总大小
        scrollView.contentSize = CGSizeMake(self.window.bounds.size.width*3, self.window.bounds.size.height);
        //弹簧效果不开启
        scrollView.bounces= NO;
        //水平和垂直条关闭
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        //是否整页滑动 是
        scrollView.pagingEnabled = YES;
        
        WLTMenu * menuvc = [[WLTMenu alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:menuvc];
        
        self.window.rootViewController = nav;
        
        [nav.view addSubview:scrollView];
        
        NSArray * arr = @[[UIImage imageNamed:@"yindao1.jpg"],[UIImage imageNamed:@"yindao2.jpg"],[UIImage imageNamed:@"yindao3.jpg"]];
        
        for (int i = 0; i<arr.count; i++) {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.window.bounds.size.width*i, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
            imageView.image = arr[i];
            
            imageView.userInteractionEnabled = YES;
            [scrollView addSubview:imageView];
            if (i==2) {
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 560, 500, 350)];
               
               
               
                [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:button];
                
            }
        }
        
        
    }else{
        
        WLTMenu * menuvc = [[WLTMenu alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:menuvc];
        
        self.window.rootViewController = nav;
        
        
        
        
    }
    
    
    
    
    
    
    
}
-(void)click{
    
    WLTMenu * menuvc = [[WLTMenu alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:menuvc];
    
    self.window.rootViewController = nav;
    
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)shouldAutorotate{
    return NO;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
