//
//  XMGTabBar.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/28.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTabBar.h"

@interface XMGTabBar ()

@property (nonatomic,weak) UIButton *plusButton;

@property (nonatomic, weak) UIControl *previousClickedTabBarButton;
@end

@implementation XMGTabBar

- (UIButton *)plusButton{

    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        _plusButton = btn;
    }
    
    return _plusButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    NSLog(@"%@",self.subviews);
    
    NSInteger count = self.items.count;
    CGFloat btnW = self.xmg_width / (count + 1);
    CGFloat btnH = self.xmg_height;
    CGFloat x = 0;
    int i = 0;
    
    for (UIControl *tabBarButton in self.subviews) {
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            
            if (i == 2) {
                i += 1;
            }
            x = i * btnW;
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
            
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.plusButton.center = CGPointMake(self.xmg_width * 0.5, self.xmg_height * 0.5);

}


- (void)tabBarButtonClick:(UIControl *)tabBarButton{

    if (self.previousClickedTabBarButton == tabBarButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XMGTabBarButtonDidRepeatClickNotification object:nil];
        
        
    }
    self.previousClickedTabBarButton = tabBarButton;


}
@end
