//
//  SFBaseTableViewCell.m
//  SFTableView
//
//  Created by zhangdongpo on 2017/7/7.
//  Copyright © 2017年 张东坡. All rights reserved.
//

#import "SFBaseTableViewCell.h"
#import "SFTableViewBaseItem.h"
@implementation SFBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setObject:(SFTableViewBaseItem *)object
{
    self.imageView.image = object.itemImage;
    self.textLabel.text = object.itemTitle;
    self.detailTextLabel.text = object.itemSubTitle;
    self.accessoryView = [[UIImageView alloc]initWithImage:object.accessoryImage];
}
+(CGFloat)tableView:(UITableView *)tableView rowHeightForItem:(SFTableViewBaseItem *)item
{
    return 44;
}
@end
