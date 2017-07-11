//
//  SFBaseTableView.h
//  SFTableView
//
//  Created by 张东坡 on 2017/6/29.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFTableViewDataSource.h"
@protocol SFBaseTableViewDelegate <UITableViewDelegate>
@optional
-(void)didSelectedItem:(id)item indexPath:(NSIndexPath *)indexPath;
-(UIView *)headerViewForSectionObject:(id)sectionObject atSection:(NSInteger)section;
-(void)pullDownRefreshAction;
-(void)pullUpLoadMoreAction;
@end
@interface SFBaseTableView : UITableView<UITableViewDelegate>
@property (nonatomic, weak) id <SFTableViewDataSource> sfDataSource;
@property (nonatomic, weak) id <SFBaseTableViewDelegate> sfDelegate;
@property (nonatomic, assign,getter = isNeedPullDownRefreshAction) BOOL needPullDownRefreshAction;
@property (nonatomic, assign,getter = isNeedPullUpLoadMoreAction) BOOL needPullUpLoadMoreAction;
-(void)stopWithNoMoreData;
-(void)stopRefreshAction;
-(void)triggerRefreshing;
@end
