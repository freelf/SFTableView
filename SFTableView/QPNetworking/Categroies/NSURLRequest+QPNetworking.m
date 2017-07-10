//
//  NSURLRequest+QPNetworking.m
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import "NSURLRequest+QPNetworking.h"
#import <objc/runtime.h>
static void *QPNetworkingRequestParameters;
@implementation NSURLRequest (QPNetworking)
-(void)setRequestParameters:(NSDictionary *)requestParameters
{
    objc_setAssociatedObject(self, &QPNetworkingRequestParameters, requestParameters, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSDictionary *)requestParameters
{
   return  objc_getAssociatedObject(self, &QPNetworkingRequestParameters);
}
@end
