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
@implementation SFBaseTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorInset = UIEdgeInsetsZero;
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
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
