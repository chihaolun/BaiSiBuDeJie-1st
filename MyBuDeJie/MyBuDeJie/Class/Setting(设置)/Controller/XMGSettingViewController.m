//
//  XMGSettingViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/11/28.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGSettingViewController.h"
#import <SDImageCache.h>
#import "XMGFileTool.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface XMGSettingViewController ()
@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation XMGSettingViewController
static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:0 target:self action:@selector(jump)];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存..."];
    
    [XMGFileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        self.totalSize = totalSize;
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];
    
}

- (void)jump{

    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor blueColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    NSUInteger size = [SDImageCache sharedImageCache].getSize;
//
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    
//    [self getFileSize:cachePath];

    //cell.textLabel.text = @"清除缓存";
    
    cell.textLabel.text = [self sizeStr];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [XMGFileTool removeDirectoryPath:CachePath];
    
    self.totalSize = 0;
    
    [self.tableView reloadData];
}

- (NSString *)sizeStr{

   

    NSString *sizeStr = @"清除缓存";
    // MB KB B
    NSInteger totalSize = self.totalSize;
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;

}


@end
