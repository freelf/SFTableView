//
//  SFTableViewDataSource.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/6.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFTableViewDataSource.h"
#import "SFTableViewSectionObject.h"
#import "SFBaseTableViewCell.h"
@implementation SFTableViewDataSource
#pragma mark - SFTableViewDataSource
-(Class)tableView:(UITableView *)tableView cellClassForObject:(SFTableViewBaseItem *)object
{
    return [SFBaseTableViewCell class];
}
-(SFTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sectionArray.count > indexPath.section) {
        SFTableViewSectionObject *sectionObject = self.sectionArray[indexPath.section];
        if (sectionObject.itemArray.count > indexPath.row) {
            return sectionObject.itemArray[indexPath.row];
        }
    }
    return nil;
}
-(void)appendItem:(SFTableViewBaseItem *)item
{
    NSLog(@"appendItem");
}
-(void)clearAllItems
{
    NSLog(@"clearAllItems");
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return  self.sectionArray ? self.sectionArray.count : 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sectionArray.count > section) {
        SFTableViewSectionObject *sectionObject = self.sectionArray[section];
        return sectionObject.itemArray.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFTableViewBaseItem *item = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:item];
    NSString *className = NSStringFromClass(cellClass);
    SFBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    cell.object = item;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.sectionArray.count > section) {
        SFTableViewSectionObject *object = self.sectionArray[section];
        if (object != nil && object.headerTitle != nil && ![object.headerTitle isEqualToString:@""]) {
            return object.headerTitle;
        }
    }
    return @"";
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.sectionArray.count > section) {
        SFTableViewSectionObject *object = self.sectionArray[section];
        if (object != nil && object.footerTitle != nil && ![object.footerTitle isEqualToString:@""]) {
            return object.footerTitle;
        }
    }
    return @"";
}
@end
