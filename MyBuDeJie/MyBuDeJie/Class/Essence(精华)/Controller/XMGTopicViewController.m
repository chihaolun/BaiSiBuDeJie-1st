//
//  XMGTopicViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/3.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGTopicViewController.h"
#import <AFNetworking.h>
#import "XMGTopic.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "XMGTopicCell.h"
#import <SDImageCache.h>
#import <MJRefresh.h>

@interface XMGTopicViewController ()

@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSMutableArray *topics;

@property (nonatomic, strong)AFHTTPSessionManager *manager;
- (XMGTopicType)type;

@end

@implementation XMGTopicViewController

- (XMGTopicType)type {return 0;}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}



static NSString * const XMGTopicCellID = @"XMGTopicCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = XMGGrayColor(206);
    //self.tableView.estimatedRowHeight = 100;
    self.tableView.contentInset = UIEdgeInsetsMake(XMGNavMaxY + XMGTitlesViewH, 0, XMGTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeaatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeaatClick) name:XMGTitleButtonDidRepeatClickNotification object:nil];
    [self setUpfresh];
    
    //self.tableView.rowHeight = 200;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGTopicCell" bundle:nil] forCellReuseIdentifier:XMGTopicCellID];
    
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBarButtonDidRepeaatClick{
    
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)titleButtonDidRepeaatClick{
    
    [self tabBarButtonDidRepeaatClick];
    
    
}

- (void)setUpfresh{
    
    //广告
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 0, 30);
    label.text = @"广告";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = label;
    //header
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
   //footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XMGTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellID];
    
    
    cell.topic = self.topics[indexPath.row];
    
    
    
    return cell;
}




//- (XMGTopicType)type{
//    return XMGTopicTypeAll;
//}


-(void)loadNewTopics{
   //取消之前请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //发请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    //NSLog(@"%@",self);
    
    [mgr GET:XMGCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //XMGAFNWriteToPlist(@"all");
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        [self.tableView.mj_header endRefreshing];
    }];
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        self.dataCount = 20;
    //        [self.tableView reloadData];
    //        [self headerEndRefreshing];
    //    });
}

- (void)loadMoreTopics{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //发请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    [mgr GET:XMGCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //XMGAFNWriteToPlist(@"all");
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}




@end
