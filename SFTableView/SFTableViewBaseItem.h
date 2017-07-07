//
//  SFTableViewBaseItem.h
//  SFTableView
//
//  Created by 张东坡 on 2017/7/6.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import <Foundation/Foundation.h>
FOUNDATION_EXTERN CGFloat const cellInvalidHeiht;
@interface SFTableViewBaseItem : NSObject
@property (nonatomic, assign) CGFloat cellHeiht;

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) NSString *itemSubTitle;
@property (nonatomic, strong) UIImage *accessoryImage;

-(instancetype)initWithItemImage:(UIImage *)itemImage
                       itemTitle:(NSString *)itemTitle
                    itemSubtitle:(NSString *)subTitle
                  accessoryImage:(UIImage *)accessoryImage;
@end
