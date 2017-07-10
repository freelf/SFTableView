//
//  QPAPIBaseManager.m
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import "QPAPIBaseManager.h"
#import "QPUserData.h"
#import "QPAPIProxy.h"

#define QPCallAPI(REQUEST_METHOD, REQUEST_ID)                                                   \
{                                                                                               \
__weak typeof(self) weakSelf = self;                                                        \
REQUEST_ID = [[QPAPIProxy sharedInstance] call##REQUEST_METHOD##WithParams:apiParameters success:^(QPURLResponse *response) { \
__strong typeof(weakSelf) strongSelf = weakSelf;                                        \
[strongSelf successedOnCallingAPI:response];                                            \
} fail:^(QPURLResponse *response) {                                                        \
__strong typeof(weakSelf) strongSelf = weakSelf;                                        \
[strongSelf failedOnCallingAPI:response withErrorType:QPAPIManagerErrorTypeDefault];    \
}];                                                                                         \
[self.requestIdArray addObject:@(REQUEST_ID)];                                               \
}

@interface QPAPIBaseManager()
@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, strong) NSMutableArray *requestIdArray;
@property (nonatomic, readwrite) QPAPIManagerErrorType errorType;
@end
@implementation QPAPIBaseManager
#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _paramSource = nil;
        if ([self conformsToProtocol:@protocol(QPAPIManager)]) {
            self.child = (id<QPAPIManager>)self;
        }else{
            NSAssert(NO, @"子类必须要实现Manager的QPManagerDelegate。");
        }
    }
    return self;
}
#pragma mark - Public Method
- (void)cancelAllRequests
{
    [[QPAPIProxy sharedInstance]cancelRequestWithRequestIDList:self.requestIdArray];
}
- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [[QPAPIProxy sharedInstance]cancelRequestWithRequestID:@(requestID)];
}
- (id)fetchDataWithReformer:(id<QPAPIManagerDataReformer>)reformer
{
    id resultData = nil;
    if (reformer && [reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

- (id)fetchData
{
	return [self manager:self reformData:self.fetchedRawData];
}

- (id)manager:(QPAPIBaseManager *)manager reformData:(NSDictionary *)data
{
	// 这里做空实现
	return [self.fetchedRawData mutableCopy];
}

#pragma mark - Call API
- (NSInteger)loadData
{
	NSDictionary *parameters = [self.paramSource paramsForApi:self];
	NSDictionary* apiParam = [self reformParams:parameters];
	// 如果是数据debug状态的话，直接返回成功回调
	if (DataDebug && [apiParam[kQPNetworkingMsgTypeKey] intValue] >= MESSAGE_TYPE_RACE) {
		// 模拟网络请求，延迟一会再回调
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self.delegate managerCallAPIDidSuccess:self];
		});
		return -9527;
	} else {
		NSInteger requestId = [self loadDataWithParameters:parameters];
		return requestId;
	}
}
-(NSInteger)loadDataWithParameters:(NSDictionary *)parameters
{
    NSInteger requestId = 0;
    NSDictionary *apiParameters = [self reformParams:parameters];
    switch (self.requestType) {
        case QPRequestTypeGET:
            QPCallAPI(GET, requestId);
            break;
        case QPRequestTypePOST:
            QPCallAPI(POST, requestId);
            break;
        default:
            break;
    }
    
    return requestId;
}
#pragma mark - Private Method
-(BOOL)beforePerfomSuccessCallBack:(QPURLResponse *)response
{
    BOOL result = YES;
	// 处理消息通知
	NSDictionary* alertDic = response.content[@"msg_next"][@"msg_data"];
	if (alertDic) {
		if (alertDic[@"alert"]) {
			[QPUserData sharedInstance].alertnum = [alertDic[@"alert"] intValue];
			[QPUserData sharedInstance].badgenum = [alertDic[@"badge"] intValue];
			[QPUserData sharedInstance].interactionnum = [alertDic[@"interaction"] intValue];
			[QPUserData sharedInstance].allnum = [QPUserData sharedInstance].alertnum + [QPUserData sharedInstance].badgenum + [QPUserData sharedInstance].interactionnum;
		}
	}
	// 拦截错误信息
    NSInteger responseCmd = [response.content[@"msg_cmd"]integerValue];
    if (responseCmd == 512 && responseCmd == 513 && responseCmd == 514 && responseCmd == 0 && responseCmd == 511) {
        result = NO;
    }
    return result;
}
#pragma mark - API CallBack 
- (void)successedOnCallingAPI:(QPURLResponse *)response
{

    self.response = response;
    if (response.content) {
        self.fetchedRawData = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    if ([self beforePerfomSuccessCallBack:response]) {
        self.errorType = QPAPIManagerErrorTypeSuccess;
        if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
            [self.delegate managerCallAPIDidSuccess:self];
        }
        
    }else{
        [self failedOnCallingAPI:response withErrorType:QPAPIManagerErrorTypeDefault];
    }

}
- (void)failedOnCallingAPI:(QPURLResponse *)response withErrorType:(QPAPIManagerErrorType)errorType
{
    self.response = response;
    if ([self.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
        [self.delegate managerCallAPIDidFailed:self];
    }
	
}
#pragma mark - Method For Child
-(QPRequestType)requestType
{
    IMP childIMP = [self.child methodForSelector:@selector(requestType)];
    IMP selfIMP = [self methodForSelector:@selector(requestType)];
    if (childIMP == selfIMP) {
        return QPRequestTypePOST;
    }else{
        return [self.child RequestType];
    }
}
-(NSDictionary *)reformParams:(NSDictionary *)params
{
    // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
    // 如果child是另一个对象，就会跑到这里
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    if (childIMP == selfIMP) {
        return params;
    } else {
        
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

@end
