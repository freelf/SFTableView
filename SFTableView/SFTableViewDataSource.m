//
//  SFTableViewDataSource.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/6.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFTableViewDataSource.h"
#import "SFTableViewSectionObject.h"
@implementation SFTableViewDataSource
#pragma mark - SFTableViewDataSource
-(Class)tableView:(UITableView *)tableView cellClassForObject:(SFTableViewBaseItem *)object
{
    return object.cellClass;
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
@end
