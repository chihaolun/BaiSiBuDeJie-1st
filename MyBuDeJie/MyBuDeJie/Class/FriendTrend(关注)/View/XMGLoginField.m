//
//  XMGLoginField.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/30.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGLoginField.h"
#import "UITextField+Placeholder.h"

@implementation XMGLoginField

- (void)awakeFromNib{

    self.tintColor = [UIColor whiteColor];

    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
     [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
//
    self.placeholderColor = [UIColor lightGrayColor];
}

- (void)textBegin{

    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];

    self.placeholderColor = [UIColor whiteColor];
}

- (void)textEnd{

    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    self.placeholderColor = [UIColor lightGrayColor];
}

@end
