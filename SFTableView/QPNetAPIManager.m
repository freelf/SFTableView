//
//  QPNetAPIManager.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/10.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "QPNetAPIManager.h"

@interface QPNetAPIManager ()
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger commond;

@end
@implementation QPNetAPIManager
-(instancetype)initWithType:(NSInteger)type commond:(NSInteger)commond
{
    if (self = [super init]) {
        _type = type;
        _commond = commond;
    }
    return self;
}
-(NSDictionary *)reformParams:(NSDictionary *)params
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[kQPNetworkingMsgDataKey] = params;
    dic[kQPNetworkingMsgCmdKey] = [NSNumber numberWithInteger:_commond];
    dic[kQPNetworkingMsgTypeKey] = [NSNumber numberWithInteger:_type];
    return dic;
}
@end
