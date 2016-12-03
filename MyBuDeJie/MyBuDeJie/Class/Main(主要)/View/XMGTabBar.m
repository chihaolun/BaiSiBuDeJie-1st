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
    
    for (UIView *tabBarButton in self.subviews) {
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            if (i == 2) {
                i += 1;
            }
            x = i * btnW;
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
        }
    }
    
    self.plusButton.center = CGPointMake(self.xmg_width * 0.5, self.xmg_height * 0.5);

}
@end
