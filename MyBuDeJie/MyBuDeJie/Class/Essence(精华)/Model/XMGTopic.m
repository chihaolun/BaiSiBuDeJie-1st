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
    
    
    
    _cellHeight += 55;
    
    CGSize textMaxSize = CGSizeMake(XMGScreenW - 2 * XMGMarin,MAXFLOAT);
    
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMarin;
    
    if (self.type != XMGTopicTypeWord) {
        
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        CGFloat middleY = _cellHeight;
        CGFloat middleX = XMGMarin;
        
       self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        
        _cellHeight += middleH + XMGMarin;
    }
    
    
    
    if (self.top_cmt.count) {
        _cellHeight += 21;
        
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        NSString *username = cmt[@"user"][@"username"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@",username,content];
        
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMarin;
    }
    
    
    
    _cellHeight += 35 + XMGMarin;
    
    return _cellHeight;

}

@end
