//
//  AppDelegate.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/24.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "AppDelegate.h"

#import "XMGADViewController.h"
#import <AFNetworking.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.设置窗口根控制器
     //XMGTabBarController *tabBarVc = [[XMGTabBarController alloc] init];
    
    XMGADViewController *adVc = [[XMGADViewController alloc] init];
    self.window.rootViewController = adVc;
    
    
    
    // 2.1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    // 精华
    // 3.显示窗口 1.成为UIApplication主窗口 2.
    [self.window makeKeyAndVisible];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
