//
//  QPRequestGenerator.m
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import "QPRequestGenerator.h"
#import "AFNetworking.h"
#import "QPNetworkingConfiguration.h"
#import "NSURLRequest+QPNetworking.h"
#import "QPCommonParametersGenerator.h"
#import "QPAppContext.h"
@interface QPRequestGenerator ()
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@end
@implementation QPRequestGenerator
#pragma mark - Public Methods
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static QPRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (NSURLRequest *)generateGETrequestWithrequestParams:(NSDictionary *)requestParams
{
    NSString *urlString = apiUrl;
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:requestParams error:NULL];
    return request;
}
- (NSURLRequest *)generatePOSTrequestParams:(NSDictionary *)requestParams
{
    NSString *urlString = apiUrl;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[QPCommonParametersGenerator commonParamsDictionary]];
    [dic addEntriesFromDictionary:requestParams];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:dic error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
    request.requestParameters = dic;
    return request;
}
#pragma mark - Getter and Setter
-(AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kQPNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}
@end
