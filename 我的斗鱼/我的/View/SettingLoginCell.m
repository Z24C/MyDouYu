//
//  SettingLoginCell.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingLoginCell.h"
#import "SettingArrowItem.h"

@interface SettingLoginCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation SettingLoginCell

- (void)awakeFromNib
{
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width *0.5;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setItem:(SettingArrowItem *)item
{
    _item = item;
    
    self.iconView.image = [UIImage imageNamed:item.icon];
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image_arrow_right"]];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const identifier = @"SettingLoginCell";
    SettingLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingLoginCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
