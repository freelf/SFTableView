//
//  QPCommonParametersGenerator.m
//  QuPaoApp
//
//  Created by 张东坡 on 2017/4/16.
//  Copyright © 2017年 qupao. All rights reserved.
//

#import "QPCommonParametersGenerator.h"
#import "QPNetworkingConfiguration.h"
#import "QPUserData.h"
@implementation QPCommonParametersGenerator
+ (NSDictionary *)commonParamsDictionary
{
    return @{
             kQPNetworkingMsgUidKey : [NSNumber numberWithInteger:[QPUserData sharedInstance].userId],
             kQPNetworkingMsgUimKey : [NSNumber numberWithInt:1],
             kQPNetworkingMsgMd5Key : [NSNumber numberWithInt:5],
             kQPNetworkingMsgVerKey : [NSNumber numberWithInt:10000],
             kQPNetworkingMsgPlatKey:[NSNumber numberWithInt:0]   //0ios  1安卓
             };
}
@end
