//
//  QPAPIBaseManager.h
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPURLResponse.h"

@class QPAPIBaseManager;
typedef NS_ENUM (NSUInteger, QPAPIManagerErrorType){
    QPAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    QPAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    QPAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    QPAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    QPAPIManagerErrorTypeTimeout,       //请求超时。QPAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看QPAPIProxy的相关代码。
    QPAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, QPRequestType){
    QPRequestTypeGET,
    QPRequestTypePOST,
} ;

//负责重新组装API数据的对象
@protocol QPAPIManagerDataReformer <NSObject>
- (id)manager:(QPAPIBaseManager *)manager reformData:(NSDictionary *)data;
@end

//让manager能够获取调用API所需要的数据
@protocol QPAPIManagerParamSource <NSObject>
@required
- (NSDictionary *)paramsForApi:(QPAPIBaseManager *)manager;
@end

/**
 * 限制协议，为的是统一处理通用数据封装，用户必须实现这个协议才能继续继承
 */
@protocol QPAPIManager <NSObject>

@optional
- (NSDictionary *)reformParams:(NSDictionary *)params;
// 获得请求的url
- (NSString *)requestUrl;
// 获得请求类型：get post
- (QPRequestType)RequestType;
@end

/*
 CTAPIBaseManager的派生类必须符合这些protocal
 */
@protocol QPAPIManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(QPAPIBaseManager *)manager beforePerformSuccessWithResponse:(QPURLResponse *)response;
- (void)manager:(QPAPIBaseManager *)manager afterPerformSuccessWithResponse:(QPURLResponse *)response;

- (BOOL)manager:(QPAPIBaseManager *)manager beforePerformFailWithResponse:(QPURLResponse *)response;
- (void)manager:(QPAPIBaseManager *)manager afterPerformFailWithResponse:(QPURLResponse *)response;

- (BOOL)manager:(QPAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(QPAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end


@protocol QPAPIManagerValidator <NSObject>
@required
/*
 callBack验证，如果不需要验证直接返回YES
 */
- (BOOL)manager:(QPAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

/*
 参数验证,如果不需要验证直接返回YES
 */
- (BOOL)manager:(QPAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
@end

//api回调
@protocol QPAPIManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(QPAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(QPAPIBaseManager *)manager;
@end

@interface QPAPIBaseManager : NSObject
@property (nonatomic, weak) NSObject<QPAPIManager>* child;
@property (nonatomic, weak) id<QPAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<QPAPIManagerParamSource> paramSource;
@property (nonatomic, strong) QPURLResponse *response;
@property (nonatomic, assign,readonly) QPAPIManagerErrorType errorType;

- (id)fetchDataWithReformer:(id<QPAPIManagerDataReformer>)reformer;
- (id)fetchData;
- (id)manager:(QPAPIBaseManager *)manager reformData:(NSDictionary *)data;
- (NSInteger)loadData;
- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (QPRequestType)requestType;




@end
