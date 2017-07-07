//
//  SFTableViewController.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/7.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFTableViewController.h"

@interface SFTableViewController ()
@property(nonatomic,assign)UITableViewStyle style;
@end

@implementation SFTableViewController
#pragma mark - Setter & Getter
-(SFBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[SFBaseTableView alloc]initWithFrame:self.view.bounds style:self.style];
        _tableView.sfDelegate = self;
        _tableView.sfDataSource = self.dataSource;
    }
    return _tableView;
}
#pragma mark - Lift Cycle
-(instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        [self creatDataSource];
        self.style = style;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}
#pragma mark - Intial Methods

#pragma mark - Private Method

#pragma mark - Target Methods


#pragma mark - SFTableViewControllerDelegate
-(void)creatDataSource
{
    [[NSException exceptionWithName:@"Can't use this method" reason:@"This method must implement in subclass" userInfo:nil] raise];
}
@end
