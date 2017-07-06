//
//  SFBaseTableView.h
//  SFTableView
//
//  Created by 张东坡 on 2017/6/29.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFBaseTableViewDelegate <UITableViewDelegate>
@optional
-(void)didSelectedItem:(id)item indexPath:(NSIndexPath *)indexPath;
-(void)headerViewForSectionObject:(id)sectionObject atSection:(NSInteger)section;
-(void)pullDownRefreshAction;
-(void)pullUpLoadMoreAction;
@end
@interface SFBaseTableView : UITableView

@end
