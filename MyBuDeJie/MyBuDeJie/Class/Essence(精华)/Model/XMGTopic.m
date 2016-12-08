//
//  XMGTopic.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/5.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic

- (CGFloat)cellHeight{
    
    if (_cellHeight) return _cellHeight;
    
    CGFloat cellHeight = 0;
    
    cellHeight += 55;
    
    CGSize textMaxSize = CGSizeMake(XMGScreenW - 2 * XMGMarin,MAXFLOAT);
    
    cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMarin;
    cellHeight += 35 + XMGMarin;
    
    return cellHeight;

}

@end
