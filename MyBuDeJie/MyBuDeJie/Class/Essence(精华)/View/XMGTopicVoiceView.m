//
//  XMGTopicVoiceView.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/8.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTopicVoiceView.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "XMGTopic.h"
#import "XMGSeeBigPictureViewController.h"

@interface XMGTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end


@implementation XMGTopicVoiceView

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

- (void)seeBigPicture{
    
    XMGSeeBigPictureViewController *vc = [[XMGSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(XMGTopic *)topic{

    _topic = topic;
    self.placeholderView.hidden = NO;
//    UIImage *placeholder = nil;
    [self.imageView xmg_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image)  return ;
        self.placeholderView.hidden = YES;
    }];
    
        
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放",topic.playcount / 10000.0];
    }else{
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    }
    
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.voicetime / 60,topic.voicetime % 60];
}

@end
