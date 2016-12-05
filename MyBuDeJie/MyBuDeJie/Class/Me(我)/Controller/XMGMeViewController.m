//
//  XMGMeViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/24.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGSquareItem.h"
#import <MJExtension/MJExtension.h>
#import "XMGSquareCell.h"
#import <SafariServices/SafariServices.h>
#import "XMGWebViewController.h"

static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (XMGScreenW - (cols - 1)) / cols

static NSString * const ID = @"cell";
@interface XMGMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SFSafariViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupFootView];
    [self loadData];
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@", NSStringFromCGRect(cell.frame));
//
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//
//    [super viewDidAppear:animated];
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
//}
#pragma mark - 加载数据

- (void)loadData{

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:XMGCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
       NSArray *dictArr = responseObject[@"square_list"];
        
       self.squareItems = [XMGSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        [self resloveData];
        [self.collectionView reloadData];
        
        //NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/chihaolun/Desktop/mmm.plist" atomically:YES];
        
        NSInteger count = self.squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        self.collectionView.xmg_height = rows * itemWH;
        self.tableView.tableFooterView = self.collectionView;
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"%@",error);
    }];
     }

#pragma mark - 添加额外item
- (void)resloveData{

    NSInteger count = self.squareItems.count;
    
    NSInteger exter = count % cols;
    
    if (exter) {
        for (int i = 0; i < exter; i++) {
            XMGSquareItem *item = [[XMGSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
}
#pragma mark - 设置collectionView
- (void)setupFootView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    
    self.tableView.tableFooterView = collectionView;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"XMGSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}
#pragma mark - UICollectionView代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    XMGSquareItem *item = self.squareItems[indexPath.row];
    
    if (![item.url containsString:@"http"]) return;
    
    XMGWebViewController *webVc = [[XMGWebViewController alloc] init];
    webVc.url = [NSURL URLWithString:item.url];
    
       //NSURL *url = [NSURL URLWithString:item.url];
    
    [self.navigationController pushViewController:webVc animated:YES];
//    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
//    
//    [self presentViewController:safariVc animated:YES completion:nil];

}
#pragma mark - SFSafariViewController代理方法

//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//
//    [self.navigationController popViewControllerAnimated:YES];
//}


#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XMGSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareItems[indexPath.row];
    
    return cell;

}
#pragma mark - 设置导航栏  跳转
- (void)setupNavBar{

    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];

    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    self.navigationItem.title = @"我的";
}

- (void)setting{
    
    XMGSettingViewController *settingVc = [[XMGSettingViewController alloc] init];
    //必须在跳转之前设置
//    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];

}
- (void)night:(UIButton *)btn{

    btn.selected = !btn.selected;
}



@end
