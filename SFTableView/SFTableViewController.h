//
//  SFTableViewController.h
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/7.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFBaseTableView.h"

@protocol SFTableViewControllerDelegate <NSObject>
@required
-(void)creatDataSource;

@end
@interface SFTableViewController : UIViewController<SFTableViewControllerDelegate,SFBaseTableViewDelegate>
@property (nonatomic, strong) SFTableViewDataSource *dataSource;
@property (nonatomic, strong) SFBaseTableView *tableView;
-(instancetype)initWithStyle:(UITableViewStyle)style;
@end
