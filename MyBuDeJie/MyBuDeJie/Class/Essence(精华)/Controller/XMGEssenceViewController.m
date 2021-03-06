//
//  XMGEssenceViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/24.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGTitleButton.h"


#import "XMGAllViewViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"


@interface XMGEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) XMGTitleButton *previousClickedTitleButton;
@property (nonatomic, weak) UIView *titleUnderLine;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildVcs];
   
    [self setupNavBar];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    [self addChildVcViewInToScrollView:0];
    
}

- (void)setupAllChildVcs{

    [self addChildViewController:[[XMGAllViewViewController alloc] init]];
    [self addChildViewController:[[XMGVideoViewController alloc] init]];
    [self addChildViewController:[[XMGVoiceViewController alloc] init]];
    [self addChildViewController:[[XMGPictureViewController alloc] init]];
    [self addChildViewController:[[XMGWordViewController alloc] init]];

}

- (void)setupScrollView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *scrollView = [[UIScrollView alloc] init];
   
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
     self.scrollView = scrollView;
    
    NSUInteger count = self.childViewControllers.count;
   CGFloat scrollViewW = scrollView.xmg_width;
//    CGFloat scrollViewH= scrollView.xmg_height;
//    
//    for (NSUInteger i = 0; i < count; i++) {
//       UIView *childVcView = self.childViewControllers[i].view;
//        childVcView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
//        [scrollView addSubview:childVcView];
//       
//    }
   scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    
}

- (void)setupTitlesView{

    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    //加按钮
    [self setupTitleButtons];
    //加下划线
    [self setupTitleUnderLine];

}

- (void)setupTitleButtons{

    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
  
    NSInteger count = titles.count;
    
    CGFloat titleButtonW = self.titlesView.xmg_width / count;
    CGFloat titleButtonH = self.titlesView.xmg_height;
    
    for (NSInteger i = 0; i < count; i++) {
        XMGTitleButton *titleButton = [[XMGTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        
        
        
    }

}

- (void)setupTitleUnderLine{

    XMGTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderLine = [[UIView alloc] init];
    titleUnderLine.xmg_height = 2;
    
    titleUnderLine.xmg_y = self.titlesView.xmg_height - titleUnderLine.xmg_height;
    titleUnderLine.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderLine];
    self.titleUnderLine = titleUnderLine;
    
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    [firstTitleButton.titleLabel sizeToFit];
    titleUnderLine.xmg_width = firstTitleButton.titleLabel.xmg_width + 10;
    titleUnderLine.xmg_centerX = firstTitleButton.xmg_centerX;
    
}


//点击标题按钮时候调用
- (void)titleButtonClick:(XMGTitleButton *)button{

    if (self.previousClickedTitleButton == button) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XMGTitleButtonDidRepeatClickNotification object:nil];
    }
    [self dealTitleButtonClick:button];
   
}

- (void)dealTitleButtonClick:(XMGTitleButton *)button{

    self.previousClickedTitleButton.selected = NO;
    button.selected = YES;
    self.previousClickedTitleButton = button;
    
    NSUInteger index = button.tag;
    [UIView animateWithDuration:0.15 animations:^{
        self.titleUnderLine.xmg_width = button.titleLabel.xmg_width + 10;
        self.titleUnderLine.xmg_centerX = button.xmg_centerX;
        
        CGFloat offsetX = self.scrollView.xmg_width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVcViewInToScrollView:index];
    }];
    
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
    }

    
}

- (void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)game{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    XMGTitleButton *titleButton = self.titlesView.subviews[index];
    [self dealTitleButtonClick:titleButton];

}

- (void)addChildVcViewInToScrollView:(NSUInteger)index{

   UIViewController *childVc = self.childViewControllers[index];
    if (childVc.isViewLoaded) return;
    UIView *childVcView = childVc.view;
    
    //if (childVc.isViewLoaded) return;
    CGFloat scrollViewW = self.scrollView.xmg_width;
    CGFloat scrollViewH= self.scrollView.xmg_height;
    childVcView.frame = CGRectMake(index * scrollViewW , 0, scrollViewW, scrollViewH);
    [self.scrollView addSubview:childVcView];

}

@end
