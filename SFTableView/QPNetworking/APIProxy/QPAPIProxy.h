//
//  QPAPIProxy.h
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPURLResponse.h"

typedef void(^QPCallback)(QPURLResponse *response);
@interface QPAPIProxy : NSObject
+ (instancetype)sharedInstance;
- (NSInteger)callGETWithParams:(NSDictionary *)params  success:(QPCallback)success fail:(QPCallback)fail;
- (NSInteger)callPOSTWithParams:(NSDictionary *)params success:(QPCallback)success fail:(QPCallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;
@end
