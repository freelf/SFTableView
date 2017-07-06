//
//  SFTableViewDataSource.h
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/6.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFTableViewBaseItem.h"
@class SFTableViewSectionObject;
@protocol SFTableViewDataSource <UITableViewDataSource>
@optional
- (SFTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableView:(UITableView*)tableView cellClassForObject:(SFTableViewBaseItem *)object;

@end
@interface SFTableViewDataSource : NSObject<SFTableViewDataSource>
@property (nonatomic, strong) NSArray *sectionArray;
@end
