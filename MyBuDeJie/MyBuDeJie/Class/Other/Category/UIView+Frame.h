//
//  UIView+Frame.h
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/28.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat xmg_width;
@property CGFloat xmg_height;
@property CGFloat xmg_x;
@property CGFloat xmg_y;
@property CGFloat xmg_centerX;
@property CGFloat xmg_centerY;

+ (instancetype)xmg_viewFromXib;

@end
