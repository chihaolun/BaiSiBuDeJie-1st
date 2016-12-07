//
//  XMGTopicCell.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/6.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Image.h"

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
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}





- (void)setTopic:(XMGTopic *)topic{

    _topic = topic;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        
        self.profileImageView.image = [image xmg_circleImage];
       
    }];

    
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.respostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    
}

- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{

    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }


}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= XMGMarin;
    [super setFrame:frame];
}

@end
