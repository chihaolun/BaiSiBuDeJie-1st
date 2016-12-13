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
- (PHFetchResult<PHAsset *> *)createdAssets;
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
    
//先检查访问权限
//用户没做出选择时候 自动弹框  选择之后  才会调用block
    //之前做过选择 直接调用block
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    NSLog(@"提醒用户打开开关");
                }
            }else if (status == PHAuthorizationStatusAuthorized){
                [self saveImageInToAlbum];
            
            }else if (status == PHAuthorizationStatusRestricted){
            
                [SVProgressHUD showErrorWithStatus:@"由于系统原因，无法访问相册!"];
            }
            
        });
    }];
}
#pragma mark - 创建并获得App对应的相册
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
    
    if (error) return nil;
   

    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}
#pragma mark - 保存图片到相机胶卷并获得图片
- (PHFetchResult<PHAsset *> *)createdAssets{
    NSError *error = nil;
    __block NSString *assetID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
           assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        } error:&error];
    
    if (error) return nil;
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}

#pragma mark - 保存图片到自定义相册
- (void)saveImageInToAlbum{

    //获得相片
  PHFetchResult<PHAsset *> *createdAssests = self.createdAssets;
    if (createdAssests == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    //获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败"];
        return;
    }
    //添加图片到自定义相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //要对哪个相册进行操作 把相册保存起来
     PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        //把图片保存到定义相册的第一张
        [request insertAssets:createdAssests atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
    } error:&error];
    
    //最后判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }

}

@end
