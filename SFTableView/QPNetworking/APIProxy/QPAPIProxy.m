//
//  QPAPIProxy.m
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import "QPAPIProxy.h"
#import "QPRequestGenerator.h"
#import "AFNetworking.h"
@interface QPAPIProxy ()
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;

//AFNetworking stuff
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end
@implementation QPAPIProxy
#pragma mark - Setter and Getter
-(AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    return _sessionManager;
}
- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}
#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static QPAPIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
#pragma mark - Public Method
- (NSInteger)callPOSTWithParams:(NSDictionary *)params success:(QPCallback)success fail:(QPCallback)fail
{
    NSURLRequest *request = [[QPRequestGenerator sharedInstance]generatePOSTrequestParams:params];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callGETWithParams:(NSDictionary *)params  success:(QPCallback)success fail:(QPCallback)fail{
    NSURLRequest *request = [[QPRequestGenerator sharedInstance]generateGETrequestWithrequestParams:params];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - Private Method
/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(QPCallback)success fail:(QPCallback)fail
{
    __block NSURLSessionDataTask *dataTask = nil;
   dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       NSNumber *requestID = @([dataTask taskIdentifier]);
       [self.dispatchTable removeObjectForKey:requestID];
       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
       NSData *responseData = responseObject;
       NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
       if (error) {
           QPURLResponse *response = [[QPURLResponse alloc]initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
           fail?fail(response):nil;
       }else{
           QPURLResponse *response = [[QPURLResponse alloc]initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:QPURLResponseStatusSuccess];
           success?success(response):nil;
       }
   }];
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    return requestId;
}
@end
