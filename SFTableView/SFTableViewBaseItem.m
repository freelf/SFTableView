//
//  SFTableViewBaseItem.m
//  SFTableView
//
//  Created by 张东坡 on 2017/7/6.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFTableViewBaseItem.h"
CGFloat const cellInvalidHeight = -1;
@implementation SFTableViewBaseItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithItemImage:nil itemTitle:nil itemSubtitle:nil accessoryImage:nil];
    }
    return self;
}
-(instancetype)initWithItemImage:(UIImage *)itemImage
                       itemTitle:(NSString *)itemTitle
                    itemSubtitle:(NSString *)subTitle
                  accessoryImage:(UIImage *)accessoryImage
{
    self = [super init];
    if (self == nil) return nil;
    self.cellHeight = cellInvalidHeight;
    self.itemImage = itemImage;
    self.itemTitle = itemTitle;
    self.itemSubTitle = subTitle;
    self.accessoryImage = accessoryImage;
    return self;
}
@end
