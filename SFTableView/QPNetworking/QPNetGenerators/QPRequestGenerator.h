//
//  QPRequestGenerator.h
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPRequestGenerator : NSObject
+ (instancetype)sharedInstance;
-(instancetype)init NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;
- (NSURLRequest *)generateGETrequestWithrequestParams:(NSDictionary *)requestParams;
- (NSURLRequest *)generatePOSTrequestParams:(NSDictionary *)requestParams;
@end
