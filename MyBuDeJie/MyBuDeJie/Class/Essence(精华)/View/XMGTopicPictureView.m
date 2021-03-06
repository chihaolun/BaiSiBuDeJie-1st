//
//  XMGTopicPictureView.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/8.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "XMGTopic.h"

#import "UIImage+GIF.h"
#import "XMGSeeBigPictureViewController.h"

@interface XMGTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation XMGTopicPictureView

- (void)awakeFromNib
{
        self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

- (void)seeBigPicture{

    XMGSeeBigPictureViewController *vc = [[XMGSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
   //NSLog(@"%@ %@", topic.text, topic.image1);
    
    // 设置图片
    self.placeholderView.hidden = NO;
    
   
    [self.imageView xmg_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        
        if (topic.isBigPicture) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
        }
        
        self.placeholderView.hidden = YES;
    }];
    
    self.gifView.hidden = !topic.is_gif;
    
    if (topic.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
        
        
    }else{
    
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    
    
    }
    
    }


@end
