//
//  XMGLoginRegisterViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/30.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegisterView.h"
#import "XMGFastLoginView.h"

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation XMGLoginRegisterViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.leadCons.constant = self.leadCons.constant == 0? -self.middleView.xmg_width * 0.5:0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMGLoginRegisterView *loginView = [XMGLoginRegisterView loginView];
    
    [self.middleView addSubview:loginView];
   
    XMGLoginRegisterView *registerView = [XMGLoginRegisterView registerView];
    
    [self.middleView addSubview:registerView];
    
    XMGFastLoginView *fastLoginView = [XMGFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    
    XMGLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
     XMGLoginRegisterView *registerView = self.middleView.subviews[1];
     registerView.frame = CGRectMake(self.middleView.xmg_width * 0.5, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
    XMGFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
    
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
