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
@property (nonatomic, weak) UILabel *footerLabel;
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
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBarButtonDidRepeaatClick{

    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    NSLog(@"刷新数据");

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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
