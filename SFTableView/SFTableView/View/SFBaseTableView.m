//
//  SFBaseTableView.m
//  SFTableView
//
//  Created by 张东坡 on 2017/6/29.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFBaseTableView.h"
#import "SFBaseTableViewCell.h"
#import "SFTableViewSectionObject.h"
#import <MJRefresh/MJRefresh.h>
@implementation SFBaseTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorInset = UIEdgeInsetsZero;
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.needPullUpLoadMoreAction = NO;
        self.needPullDownRefreshAction = NO;
    }
    return self;
}
-(void)setSfDataSource:(id<SFTableViewDataSource>)sfDataSource
{
    if (_sfDataSource != sfDataSource) {
        _sfDataSource = sfDataSource;
        self.dataSource = sfDataSource;
    }
}
-(void)setNeedPullDownRefreshAction:(BOOL)needPullDownRefreshAction
{
    if (_needPullDownRefreshAction == needPullDownRefreshAction) {
        return;
    }
    _needPullDownRefreshAction = needPullDownRefreshAction;
    __block typeof(self) weakSelf = self;
    if (_needPullDownRefreshAction) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if ([weakSelf.sfDelegate respondsToSelector:@selector(pullDownRefreshAction)]) {
                [weakSelf.sfDelegate pullDownRefreshAction];
            }
        }];
    }
}
-(void)setNeedPullUpLoadMoreAction:(BOOL)needPullUpLoadMoreAction
{
    if (_needPullUpLoadMoreAction == needPullUpLoadMoreAction) {
        return;
    }
    _needPullUpLoadMoreAction = needPullUpLoadMoreAction;
    __block typeof(self) weakSelf = self;
    if (_needPullUpLoadMoreAction) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if ([weakSelf.sfDelegate respondsToSelector:@selector(pullUpLoadMoreAction)]) {
                [weakSelf.sfDelegate pullUpLoadMoreAction];
            }
        }];
    }
}
#pragma mark - Public Method
-(void)stopWithNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}
-(void)stopRefreshAction
{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}
-(void)triggerRefreshing
{
    [self.mj_header beginRefreshing];
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<SFTableViewDataSource> dataSource = (id<SFTableViewDataSource>)tableView.dataSource;
    SFTableViewBaseItem *item = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [dataSource tableView:tableView cellClassForObject:item];
    if (item.cellHeight == cellInvalidHeight) {
        item.cellHeight = [cellClass tableView:tableView rowHeightForItem:item];
    }
    return item.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.sfDelegate respondsToSelector:@selector(didSelectedItem:indexPath:)]) {
        id<SFTableViewDataSource> dataSource = (id<SFTableViewDataSource>)tableView.dataSource;
        SFTableViewBaseItem *item = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.sfDelegate didSelectedItem:item indexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if([self.sfDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.sfDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.sfDelegate respondsToSelector:@selector(headerViewForSectionObject:atSection:)]) {
        id<SFTableViewDataSource> dataSource = (id<SFTableViewDataSource>)tableView.dataSource;
        
        SFTableViewSectionObject *object = ((SFTableViewDataSource *)dataSource).sectionArray[section];
        return [self.sfDelegate headerViewForSectionObject:object atSection:section];
    }else if ([self.sfDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]){
        return [self.sfDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
@end
