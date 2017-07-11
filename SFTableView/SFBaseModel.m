//
//  SFBaseModel.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/10.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFBaseModel.h"
#import "SFBaseItem.h"
@interface SFBaseModel ()
@property(nonatomic,assign)NSInteger requestId;
@end
@implementation SFBaseModel
-(instancetype)initWithType:(NSInteger)type commond:(NSInteger)commond
{
    if (self = [super init]) {
        self.serverApi = [[QPNetAPIManager alloc]initWithType:type commond:commond];
        self.serverApi.delegate = self;
        self.serverApi.paramSource = self;
    }
    return self;
}
-(void)handleParseData:(SFBaseItem *)item
{
    
}
-(void)startRequest
{
   self.requestId = [self.serverApi loadData];
}
-(void)cancelRequest
{
    [self.serverApi cancelRequestWithRequestId:self.requestId];
}
-(NSDictionary *)paramsForApi:(QPAPIBaseManager *)manager
{
    return self.parameters;
}
-(void)managerCallAPIDidSuccess:(QPAPIBaseManager *)manager
{
    __weak SFBaseModel* wself = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        SFBaseModel *sself = wself;
       __block SFBaseItem *item = [manager fetchDataWithReformer:[[sself.parseDataClassType alloc]init]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [sself handleParseData:item];
            if (sself.completionBlock) {
                sself.completionBlock(wself);
            }
            
        });
    });
}
-(void)managerCallAPIDidFailed:(QPAPIBaseManager *)manager
{
    if (self.completionBlock) {
        self.completionBlock(self);
    }
}
@end
