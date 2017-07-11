//
//  SFRefreshTableViewController.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/11.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFRefreshTableViewController.h"

@interface SFRefreshTableViewController ()

@end

@implementation SFRefreshTableViewController
#pragma mark - Setter & Getter

#pragma mark - Lift Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.needPullUpLoadMoreAction = YES;
    self.tableView.needPullDownRefreshAction = YES;
}
-(void)requestDidSuccess
{
    
}
#pragma mark - SFBaseRefreshListModelProtocol
-(void)refreshRequestDidSuccess
{
    [self.dataSource clearAllItems];
    [self requestDidSuccess];
}
-(void)loadMoreRequestDidSuccess
{
    [self requestDidSuccess];
}
-(void)didLoadLastPage
{
    [self.tableView stopWithNoMoreData];
}
-(void)handleAfterRequestFinish
{
    [self.tableView stopRefreshAction];
    [self.tableView reloadData];
}
#pragma mark - SFTableViewDelegate
-(void)pullUpLoadMoreAction
{
    [self.refreshListModel loadMore];
}
-(void)pullDownRefreshAction
{
    [self.refreshListModel refresh];
}
#pragma mark - Intial Methods

#pragma mark - Private Method

#pragma mark - Target Methods

#pragma mark - QPAPIManagerParamSource

#pragma mark - QPAPIManagerCallBackDelegate

@end
