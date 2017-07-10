//
//  QPNetAPIManager.h
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/10.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "QPAPIBaseManager.h"

@interface QPNetAPIManager : QPAPIBaseManager<QPAPIManager>
-(instancetype)initWithType:(NSInteger)type commond:(NSInteger)commond;
@end
