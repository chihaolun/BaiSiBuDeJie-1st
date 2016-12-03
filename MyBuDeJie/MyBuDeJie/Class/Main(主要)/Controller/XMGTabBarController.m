//
//  XMGTabBarController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/26.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGEssenceViewController.h"
#import "XMGFriendTrendViewController.h"
#import "XMGMeViewController.h"
#import "XMGNewViewController.h"
#import "XMGPublishViewController.h"
#import "UIImage+Image.h"
#import "XMGTabBar.h"
#import "XMGNavigationViewController.h"

@interface XMGTabBarController ()

@end

@implementation XMGTabBarController

+ (void)load{

    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
    [self setUpAllTitleButton];
    [self setUpTabBar];
}

- (void)setUpTabBar{

    XMGTabBar *tabBar = [[XMGTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setUpAllChildViewController{
    
    XMGEssenceViewController *essenceVc = [[XMGEssenceViewController alloc] init];
    XMGNavigationViewController *nav = [[XMGNavigationViewController alloc] initWithRootViewController:essenceVc];
    // initWithRootViewController:push
    
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav];
    
    // 新帖
    XMGNewViewController *newVc = [[XMGNewViewController alloc] init];
    XMGNavigationViewController *nav1 = [[XMGNavigationViewController alloc] initWithRootViewController:newVc];
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav1];
    
//    // 发布
//    XMGPublishViewController *publishVc = [[XMGPublishViewController alloc] init];
//    // tabBarVc:会把第0个子控制器的view添加去
//    [self addChildViewController:publishVc];
    
    // 关注
    XMGFriendTrendViewController *ftVc = [[XMGFriendTrendViewController alloc] init];
    XMGNavigationViewController *nav3 = [[XMGNavigationViewController alloc] initWithRootViewController:ftVc];
    // initWithRootViewController:push
    
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav3];
    
    // 我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([XMGMeViewController class]) bundle:nil];
    
    XMGMeViewController *meVc = [storyboard instantiateInitialViewController];
    XMGNavigationViewController *nav4 = [[XMGNavigationViewController alloc] initWithRootViewController:meVc];
    // initWithRootViewController:push
    
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav4];

}

- (void)setUpAllTitleButton{

    // 0:nav
   UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    
//  
//    // 2:发布
//    UIViewController *publishVc = self.childViewControllers[2];
//    publishVc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    publishVc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    
    // 3.关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
    
}

@end
