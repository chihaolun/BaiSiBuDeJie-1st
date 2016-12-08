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

@interface XMGTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end


@implementation XMGTopicVoiceView

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(XMGTopic *)topic{

    _topic = topic;
    
    UIImage *placeholder = nil;
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //从内存和沙盒中获得原图
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
    
    if (originImage) {//图片被下载过
        self.imageView.image = originImage;
    }else{//图片没被下载过
        if (mgr.isReachableViaWiFi) {//如果是wifi就下载高清大图
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
        }else if (mgr.isReachableViaWWAN){//如果是移动网络
        
            BOOL downloadOriginImageWhen3Gor4G = YES;//“3G/4G下下载高清大图”
            if (downloadOriginImageWhen3Gor4G) {//开启“3G/4G下下载高清大图”功能
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
            }else{//关闭“3G/4G下下载高清大图”功能
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholder];
            
            }
            
        }else{//没有网络,先看看沙盒中下没下载过小图
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
            
            if (thumbnailImage) {//沙盒中下载过小图
                self.imageView.image = thumbnailImage;
            }else{//没下载过小图
                self.imageView.image = placeholder;
            
            }
        }
    }
    
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放",topic.playcount / 10000.0];
    }else{
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    }
    
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.voicetime / 60,topic.voicetime % 60];
}

@end
