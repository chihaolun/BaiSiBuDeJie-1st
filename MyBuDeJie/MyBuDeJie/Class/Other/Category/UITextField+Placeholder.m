//
//  UITextField+Placeholder.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/30.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

+(void)load{

    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setXMG_Placeholder = class_getInstanceMethod(self, @selector(setXMG_Placeholder:));
    
    method_exchangeImplementations(setPlaceholder, setXMG_Placeholder);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{

    
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (void)setXMG_Placeholder:(NSString *)placeholder{

//    self.placeholder = placeholder;
    [self setXMG_Placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

- (UIColor *)placeholderColor{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

@end
