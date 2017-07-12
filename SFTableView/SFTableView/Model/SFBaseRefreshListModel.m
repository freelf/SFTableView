//
//  SFBaseRefreshListModel.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/11.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFBaseRefreshListModel.h"

@implementation SFBaseRefreshListModel
-(void)setDelegate:(id<SFBaseRefreshListModelProtocol>)delegate
{
    _delegate = delegate;
    __weak typeof(self) wself = self;
    self.completionBlock = ^(SFBaseModel *model) {
        typeof(self) sself = wself;
        if (sself.serverApi.errorType == QPAPIManagerErrorTypeSuccess) {
            if (sself.isRefresh && [sself.delegate respondsToSelector:@selector(refreshRequestDidSuccess)]) {
                [sself.delegate refreshRequestDidSuccess];
            }else if (!sself.isRefresh && [sself.delegate respondsToSelector:@selector(loadMoreRequestDidSuccess)]){
                [sself.delegate loadMoreRequestDidSuccess];
            }
            [sself.delegate handleAfterRequestFinish];
        }else{
            [sself.delegate handleAfterRequestFinish];
        }
        sself.isRefresh = NO;
    };
}
-(void)refresh
{
    self.isRefresh = YES;
    [self startRequest];
}
-(void)loadMore
{
    self.isRefresh = NO;
    [self startRequest];
}
@end
