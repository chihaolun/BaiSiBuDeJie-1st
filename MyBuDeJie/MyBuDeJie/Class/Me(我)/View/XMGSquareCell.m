//
//  XMGSquareCell.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/30.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGSquareCell.h"
#import "XMGSquareItem.h"
#import <UIImageView+WebCache.h>

@interface XMGSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation XMGSquareCell


- (void)setItem:(XMGSquareItem *)item{

    _item = item;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    
    self.nameLabel.text = item.name;
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
