//
//  XMGFriendTrendViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/24.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGFriendTrendViewController.h"
#import "XMGLoginRegisterViewController.h"

@interface XMGFriendTrendViewController ()

@end

@implementation XMGFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
}
- (IBAction)clickLoginRegister:(id)sender {
    
    XMGLoginRegisterViewController *loginVc = [[XMGLoginRegisterViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}

- (void)setupNavBar{

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    self.navigationItem.title = @"我的关注";
}

- (void)friendsRecomment{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
