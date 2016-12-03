//
//  XMGLoginRegisterView.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/30.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGLoginRegisterView.h"

@interface XMGLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;


@end


@implementation XMGLoginRegisterView

+ (instancetype)loginView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
}

+ (instancetype)registerView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}

- (void)awakeFromNib{

    UIImage *image = self.loginRegisterButton.currentBackgroundImage;
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    [self.loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];

}
@end
