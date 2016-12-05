//
//  XMGAllViewViewController.m
//  MyBuDeJie
//
//  Created by 迟浩伦 on 2016/12/3.
//  Copyright © 2016年 迟浩伦. All rights reserved.
//

#import "XMGAllViewViewController.h"

@interface XMGAllViewViewController ()
@property (nonatomic, assign) NSInteger dataCount;
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
    
    self.dataCount = 30;
    
    self.view.backgroundColor = XMGRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(XMGNavMaxY + XMGTitlesViewH, 0, XMGTabBarH, 0);
    
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
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.footer.hidden = (self.dataCount == 0);
    return self.dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%ld",self.class,indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
 
    
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
    
    if (self.isFooterRefreshing) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.xmg_height;
    
    if (self.tableView.contentOffset.y >= offsetY) {
        self.footerRefreshing = YES;
        self.footerLabel.text = @"正在加载更多数据";
        self.footerLabel.backgroundColor = [UIColor blueColor];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataCount += 5;
            [self.tableView reloadData];
            
            self.footerRefreshing = NO;
            self.footerLabel.text = @"上拉可以加载更多";
            self.footerLabel.backgroundColor = [UIColor redColor];
            
        });
        
    }

    
}

//手松开的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (self.isHeaderRefreshing) return;
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.xmg_height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        self.headerLabel.text = @"正在刷新数据...";
        self.headerLabel.backgroundColor = [UIColor blueColor];
        self.headerRefreshing = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top += self.header.xmg_height;
            self.tableView.contentInset = inset;
        }];
        NSLog(@"正在请求数据");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataCount = 20;
            [self.tableView reloadData];
            self.headerRefreshing = NO;
            NSLog(@"请求完成");
            
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets inset = self.tableView.contentInset;
                inset.top -= self.header.xmg_height;
                self.tableView.contentInset = inset;
            }];
        });
        
        
    }
}



@end
