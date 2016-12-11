//
//  UIImageView+Download.h
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/10.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
@interface UIImageView (Download)


- (void)xmg_setHeader:(NSString *)headerUrl;

- (void)xmg_setOriginImage:(NSString *)originImageURL thumnailImage:(NSString *)thumnailImageURL placeholder:(UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock;
@end
