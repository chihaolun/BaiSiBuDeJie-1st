//
//  XMGSeeBigPictureViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/12.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGSeeBigPictureViewController.h"
#import "XMGTopic.h"
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface XMGSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, weak)  UIImageView *imageView;
- (PHAssetCollection *)createdCollection;
@end

@implementation XMGSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick:)]];
    
    [self.view insertSubview:scrollView atIndex:0];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.saveButton.enabled = YES;
    }];
    
    imageView.xmg_width = scrollView.xmg_width;
    imageView.xmg_height = imageView.xmg_width * self.topic.height / self.topic.width;
    imageView.xmg_x = 0;
    
    if (imageView.xmg_height > XMGScreenH) {
        imageView.xmg_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.xmg_height);
    }else{
        imageView.xmg_centerY = scrollView.xmg_height * 0.5;
    }
    self.imageView = imageView;
    [scrollView addSubview:imageView];
    
    CGFloat maxScale = self.topic.width / imageView.xmg_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveBtnClick:(id)sender {
    
    self.createdCollection;
//    NSError *error = nil;
//    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
//    } error:&error];
}

- (PHAssetCollection *)createdCollection{
//获取App名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    //抓取所有自定义相册
   PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    
    //查找App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
   __block NSString *createdCollectionID = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
       createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
        return nil;
    }

    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}


@end
