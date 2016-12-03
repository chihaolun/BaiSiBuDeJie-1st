//
//  UIImage+Image.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/26.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageOriginalWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}


@end

