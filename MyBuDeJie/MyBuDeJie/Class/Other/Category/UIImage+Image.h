//
//  UIImage+Image.h
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/26.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

- (instancetype)xmg_circleImage;

+ (instancetype)xmg_circleImageNamed:(NSString *)name;



@end
