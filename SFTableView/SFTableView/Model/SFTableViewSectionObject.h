//
//  SFTableViewSectionObject.h
//  SFTableView
//
//  Created by 张东坡 on 2017/7/6.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SFTableViewSectionObject : NSObject
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
/**具体的数据*/
@property (nonatomic, strong) NSArray *itemArray;

-(instancetype)initWithItemArray:(NSArray *)itemArray;

-(instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;
@end
