//
//  XMGFastButton.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/30.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGFastButton.h"

@implementation XMGFastButton

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.imageView.xmg_y = 0;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    
    self.titleLabel.xmg_y = self.xmg_height - self.titleLabel.xmg_height;
    
    [self.titleLabel sizeToFit];
    
    self.titleLabel.xmg_centerX = self.xmg_width * 0.5;

}

@end
