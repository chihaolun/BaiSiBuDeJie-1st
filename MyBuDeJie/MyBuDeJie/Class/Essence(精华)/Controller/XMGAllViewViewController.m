//
//  XMGAllViewViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/3.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGAllViewViewController.h"
#import <AFNetworking.h>
#import "XMGTopic.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface XMGAllViewViewController ()

@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSMutableArray *topics;

@property (nonatomic, weak) UIView *footer;
@property (nonatomic, assign ,getter=isFooterRefreshing) BOOL footerRefreshing;
@property (nonatomic, assign ,getter=isHeaderRefreshing) BOOL headerRefreshing;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, weak) UIView *header;
@property (nonatomic, weak) UILabel *headerLabel;

@end

@implementation XMGAllViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = XMGRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(XMGNavMaxY + XMGTitlesViewH, 0, XMGTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeaatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeaatClick) name:XMGTitleButtonDidRepeatClickNotification object:nil];
    [self setUpfresh];
   
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBarButtonDidRepeaatClick{

    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    [self headerBeginRefreshing];

}

- (void)titleButtonDidRepeaatClick{

   [self tabBarButtonDidRepeaatClick];
    
    
}

- (void)setUpfresh{
    
    
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.xmg_width, 35);
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    self.footerLabel = footerLabel;
    [footer addSubview:footerLabel];
    self.footer = footer;
    self.tableView.tableFooterView = footer;
    
    //广告
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 0, 30);
    label.text = @"广告";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = label;
    
    
    //header
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -50, self.tableView.xmg_width, 50);
    self.header = header;
    [self.tableView addSubview:header];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = header.bounds;
    headerLabel.backgroundColor = [UIColor redColor];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel = headerLabel;
    [header addSubview:headerLabel];
    
    [self headerBeginRefreshing];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        }
    XMGTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
 
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self dealFooter];
    
    [self dealHeader];

}

- (void)dealHeader{

    
    if (self.isHeaderRefreshing) return;
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.xmg_height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        self.headerLabel.text = @"松开立即刷新";
        self.headerLabel.backgroundColor = [UIColor grayColor];
    }else{
        self.headerLabel.text = @"下拉可以刷新";
        self.headerLabel.backgroundColor = [UIColor redColor];
    
    }

}

- (void)dealFooter{
    
    if (self.tableView.contentSize.height == 0) return;
    
    
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.xmg_height;
    
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        [self footerBeginRefreshing];
        
    }

    
}

//手松开的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

   
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.xmg_height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        [self headerBeginRefreshing];
    }
}




-(void)loadNewTopics{

    //发请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    
    [mgr GET:XMGCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //XMGAFNWriteToPlist(@"all");
        self.maxtime = responseObject[@"info"][@"maxtime"];
       self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self headerEndRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        [self headerEndRefreshing];
    }];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.dataCount = 20;
//        [self.tableView reloadData];
//        [self headerEndRefreshing];
//    });
}

- (void)loadMoreTopics{

     //发请求
    //发请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    parameters[@"maxtime"] = self.maxtime;
    
    [mgr GET:XMGCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //XMGAFNWriteToPlist(@"all");
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        [self footerEndRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试"];
        [self footerEndRefreshing];
    }];
    
}

- (void)headerBeginRefreshing{
    
     if (self.isHeaderRefreshing) return;
    self.headerLabel.text = @"正在刷新数据...";
    self.headerLabel.backgroundColor = [UIColor blueColor];
    self.headerRefreshing = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.xmg_height;
        self.tableView.contentInset = inset;
        
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - inset.top);
    }];
    
    [self loadNewTopics];
    
    
    

}
- (void)headerEndRefreshing{
    
    self.headerRefreshing = NO;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.xmg_height;
        self.tableView.contentInset = inset;
        
    }];


}
- (void)footerBeginRefreshing{
    
    if (self.isFooterRefreshing) return;
    self.footerRefreshing = YES;
    self.footerLabel.text = @"正在加载更多数据";
    self.footerLabel.backgroundColor = [UIColor blueColor];
    
    [self loadMoreTopics];

    
}
- (void)footerEndRefreshing{
    
    
    self.footerRefreshing = NO;
    self.footerLabel.text = @"上拉可以加载更多";
    self.footerLabel.backgroundColor = [UIColor redColor];

    
}



@end
