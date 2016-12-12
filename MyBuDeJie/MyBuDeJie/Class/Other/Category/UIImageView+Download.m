//
//  UIImageView+Download.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/10.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "UIImageView+Download.h"
#import <UIImageView+WebCache.h>
#import <AFNetworkReachabilityManager.h>

@implementation UIImageView (Download)


- (void)xmg_setHeader:(NSString *)headerUrl{

    UIImage *placeholder = [UIImage xmg_circleImageNamed:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        
        self.image = [image xmg_circleImage];
        
    }];

}

- (void)xmg_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock{

    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    if (originImage) { // 原图已经被下载过
        self.image = originImage;
        completedBlock(originImage,nil,0,[NSURL URLWithString:originImageURL]);
    } else { // 原图并未下载过
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
        } else if (mgr.isReachableViaWWAN) {
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            }
        } else { // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { // 缩略图已经被下载过
                self.image = thumbnailImage;
                completedBlock(thumbnailImage,nil,0,[NSURL URLWithString:thumbnailImageURL]);
            } else { // 没有下载过任何图片
                // 占位图片;
                self.image = placeholder;
            }
        }
    }


}
@end
