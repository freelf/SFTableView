//
//  QPNetworkingConfiguration.h
//  QuPaoApp
//
//  Created by zhangdongpo on 2017/4/11.
//  Copyright © 2017年 qupao. All rights reserved.
//

#ifndef QPNetworkingConfiguration_h
#define QPNetworkingConfiguration_h
typedef NS_ENUM(NSUInteger, QPURLResponseStatus)
{
    QPURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的QPAPIBaseManager来决定。
    QPURLResponseStatusErrorTimeout,
    QPURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};


static NSString *apiUrl = @"";
static BOOL kQPServiceIsOnline = NO;
static NSTimeInterval kQPNetworkingTimeoutSeconds = 20.0f;
static NSString *kQPNetworkingMsgDataKey = @"msg_data";
static NSString *kQPNetworkingMsgMd5Key = @"msg_md5";
/**小指令*/
static NSString *kQPNetworkingMsgCmdKey = @"msg_cmd";
/**大指令*/
static NSString *kQPNetworkingMsgTypeKey = @"msg_type";
static NSString *kQPNetworkingMsgUimKey = @"msg_uim";
static NSString *kQPNetworkingMsgUidKey = @"msg_uid";

static NSString *kQPNetworkingMsgVerKey = @"msg_ver";
static NSString *kQPNetworkingMsgPlatKey = @"msg_plat";





#endif /* QPNetworkingConfiguration_h */
