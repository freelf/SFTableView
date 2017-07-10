//
//  SFBaseTableViewCell.h
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/7.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFTableViewBaseItem;
@interface SFBaseTableViewCell : UITableViewCell
@property (nonatomic, strong) id object;
+(CGFloat)tableView:(UITableView *)tableView rowHeightForItem:(SFTableViewBaseItem *)item;
@end
