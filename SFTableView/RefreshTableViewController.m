//
//  RefreshTableViewController.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/11.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "ViewControllerDataSource.h"
@interface RefreshTableViewController ()

@end

@implementation RefreshTableViewController
#pragma mark - Setter & Getter

#pragma mark - Lift Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshListModel = [[SFBaseRefreshListModel alloc]initWithType:1 commond:1];
    self.refreshListModel.delegate = self;
}
-(void)creatDataSource
{
    self.dataSource = [[ViewControllerDataSource alloc]init];
}
-(void)requestDidSuccess
{
    NSLog(@"requestDidSuccess");
}
#pragma mark - Intial Methods

#pragma mark - Private Method

#pragma mark - Target Methods

#pragma mark - QPAPIManagerParamSource

#pragma mark - QPAPIManagerCallBackDelegate

@end
