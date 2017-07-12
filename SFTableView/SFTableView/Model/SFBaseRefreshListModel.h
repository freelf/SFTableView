//
//  SFBaseRefreshListModel.h
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/11.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFBaseModel.h"
#import "SFTableViewDataSource.h"
@protocol SFBaseRefreshListModelProtocol <NSObject>
@required
-(void)refreshRequestDidSuccess;
-(void)loadMoreRequestDidSuccess;
-(void)didLoadLastPage;
-(void)handleAfterRequestFinish;

@end
@interface SFBaseRefreshListModel : SFBaseModel
@property (nonatomic, strong) SFTableViewDataSource *dataSource;
@property (nonatomic, weak) id<SFBaseRefreshListModelProtocol> delegate;
@property (nonatomic, assign) BOOL isRefresh;

-(void)loadMore;
-(void)refresh;
@end
