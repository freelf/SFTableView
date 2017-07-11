//
//  SFBaseModel.h
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/10.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPNetAPIManager.h"
@class SFBaseItem;
@class SFBaseModel;
typedef void(^SFModelBlock)(SFBaseModel *);
@protocol SFBaseModelDelegate <NSObject>
@required
-(void)requestDidSuccess;
-(void)requestDidFailed:(QPAPIManagerErrorType)errorType;

@end
@interface SFBaseModel : NSObject<QPAPIManagerParamSource,QPAPIManagerCallBackDelegate>
//自动解析数据，可能在不同线程中访问，所以设置为atomic
@property (assign,atomic) Class parseDataClassType;

@property (nonatomic, copy) SFModelBlock completionBlock;

@property (nonatomic, strong) QPNetAPIManager *serverApi;

@property (nonatomic, strong) NSDictionary *parameters;

-(instancetype)initWithType:(NSInteger)type commond:(NSInteger)commond;

-(void)handleParseData:(SFBaseItem *)item;

-(void)startRequest;

-(void)cancelRequest;
@end
