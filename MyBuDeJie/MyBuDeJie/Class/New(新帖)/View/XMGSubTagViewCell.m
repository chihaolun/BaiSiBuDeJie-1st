//
//  XMGSubTagViewCell.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/30.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGSubTagViewCell.h"
#import "XMGSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface XMGSubTagViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconVIew;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UILabel *numView;

@end

@implementation XMGSubTagViewCell

- (void)setFrame:(CGRect)frame{

    frame.size.height -= 1;
    [super setFrame:frame];

}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.iconVIew.layer.cornerRadius = 30;
//    self.iconVIew.layer.masksToBounds = YES;
//    self.layoutMargins = UIEdgeInsetsZero;
    
     //self.nameView.text = self.item.theme_name;
}

- (void)setItem:(XMGSubTagItem *)item{

    _item = item;
    
    self.nameView.text = item.theme_name;
    // 判断下有没有>10000
    
    [self resolveNum];
    
    
    [self.iconVIew sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 1.开启图形上下文
        // 比例因素:当前点与像素比例
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        // 2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        // 3.设置裁剪区域;
        [path addClip];
        // 4.画图片
        [image drawAtPoint:CGPointZero];
        // 5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        // 6.关闭上下文
        UIGraphicsEndImageContext();
        
        self.iconVIew.image = image;
    }];
}

- (void)resolveNum{
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",self.item.sub_number] ;
    NSInteger num = self.item.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    self.numView.text = numStr;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
