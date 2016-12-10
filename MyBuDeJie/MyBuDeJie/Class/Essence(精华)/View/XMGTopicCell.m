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

#import "XMGTopicVideoView.h"
#import "XMGTopicPictureView.h"
#import "XMGTopicVoiceView.h"

@interface XMGTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *respostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;


@end

@implementation XMGTopicCell


#pragma mark - 懒加载
- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView xmg_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView xmg_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView xmg_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}





- (void)setTopic:(XMGTopic *)topic{

    _topic = topic;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.profileImageView xmg_setHeader:topic.profile_image];
    
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.respostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    
    if (topic.top_cmt.count) {
        self.topCmtView.hidden = NO;
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        NSString *username = cmt[@"user"][@"username"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else{
    
        self.topCmtView.hidden = YES;
    
    }
    
    
    if (topic.type == XMGTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == XMGTopicTypeVoice){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.topic = topic;
    }else if (topic.type == XMGTopicTypeVideo){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
    }else if (topic.type == XMGTopicTypeWord){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    if (self.topic.type == XMGTopicTypePicture) {
        self.pictureView.frame = self.topic.middleFrame;
    }else if (self.topic.type == XMGTopicTypeVoice){
        self.voiceView.frame = self.topic.middleFrame;
    }else if (self.topic.type == XMGTopicTypeVideo){
        self.videoView.frame = self.topic.middleFrame;
    }

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
