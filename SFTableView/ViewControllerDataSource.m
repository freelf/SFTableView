//
//  ViewControllerDataSource.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/7.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "ViewControllerDataSource.h"
#import "SFTableViewSectionObject.h"
#import "SFTableViewBaseItem.h"
@implementation ViewControllerDataSource
- (instancetype)init
{
    self = [super init];
    if (self) {
        SFTableViewSectionObject *sectionObject = [[SFTableViewSectionObject alloc]initWithItemArray:@[
                                                                                                       [[SFTableViewBaseItem alloc]initWithItemImage:nil itemTitle:@"1" itemSubtitle:nil accessoryImage:nil],
                                                                                                       [[SFTableViewBaseItem alloc]initWithItemImage:nil itemTitle:@"2" itemSubtitle:nil accessoryImage:nil],
                                                                                                       [[SFTableViewBaseItem alloc]initWithItemImage:nil itemTitle:@"3" itemSubtitle:nil accessoryImage:nil],
                                                                                                       [[SFTableViewBaseItem alloc]initWithItemImage:nil itemTitle:@"4" itemSubtitle:nil accessoryImage:nil],
                                                                                                       [[SFTableViewBaseItem alloc]initWithItemImage:nil itemTitle:@"5" itemSubtitle:nil accessoryImage:nil]
                                                                                                       
                                                                                                       ]];
        NSMutableArray *array = @[].mutableCopy;
        [array addObject:sectionObject];
        self.sectionArray = array;
        
    }
    return self;
}
@end
