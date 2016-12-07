//
//  MyBuDeJie.h
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/28.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "UIView+Frame.h"
#import "UIBarButtonItem+Item.h"
#import "XMGConst.h"
#define XMGColor(r,g,b)  [UIColor colorWithRed:(r) / 256.0 green:(g) / 256.0 blue:(b) / 256.0 alpha:1]

#define XMGRandomColor XMGColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define XMGGrayColor(v) XMGColor(v,v,v)

#define XMGAFNWriteToPlist(fileName) [responseObject writeToFile:[NSString stringWithFormat:@"/Users/chihaolun/Desktop/%@.plist",fileName] atomically:YES]
/***********屏幕适配*************/
#define XMGScreenW [UIScreen mainScreen].bounds.size.width
#define XMGScreenH [UIScreen mainScreen].bounds.size.height
#define iphone6P (XMGScreenH == 736)
#define iphone6 (XMGScreenH == 667)
#define iphone5 (XMGScreenH == 568)
#define iphone4 (XMGScreenH == 480)
/***********屏幕适配*************/
