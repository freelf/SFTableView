//
//  SFBaseModel.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/10.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFBaseModel.h"

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
-(NSDictionary *)paramsForApi:(QPAPIBaseManager *)manager
{
    return self.parameters;
}
-(void)managerCallAPIDidSuccess:(QPAPIBaseManager *)manager
{
    
}
-(void)managerCallAPIDidFailed:(QPAPIBaseManager *)manager
{
    
}
@end
