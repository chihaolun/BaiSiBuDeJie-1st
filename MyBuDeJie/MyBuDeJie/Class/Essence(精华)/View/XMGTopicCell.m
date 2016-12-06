//
//  XMGTopicCell.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/6.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTopicCell.h"


@interface XMGTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *respostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;





@end

@implementation XMGTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(XMGTopic *)topic{

    _topic = topic;
}

@end
