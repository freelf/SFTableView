//
//  SFTableViewSectionObject.m
//  SFTableView
//
//  Created by 张东坡 on 2017/7/6.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFTableViewSectionObject.h"

@implementation SFTableViewSectionObject
-(instancetype)initWithItemArray:(NSArray *)itemArray
{
    self = [super init];
    if (self == nil) return nil;
    self.headerTitle = @"";
    self.footerTitle = @"";
    self.headerHeight = 0;
    self.footerHeight = 0;
    self.itemArray = itemArray;
    return self;
}
@end
