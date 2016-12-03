//
//  XMGTitleButton.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/2.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTitleButton.h"

@implementation XMGTitleButton

- (void)setHighlighted:(BOOL)highlighted{

}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;

}

@end
