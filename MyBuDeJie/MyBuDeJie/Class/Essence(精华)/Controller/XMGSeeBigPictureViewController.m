//
//  XMGSeeBigPictureViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/12.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGSeeBigPictureViewController.h"
#import "XMGTopic.h"
@interface XMGSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, weak)  UIImageView *imageView;
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
