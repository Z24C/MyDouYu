//
//  SettingCell.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingArrowLabelItem.h"
#import "SettingLabelItem.h"
#import "SettingSwitchItem.h"
#import "Common.h"
#import "SaveTool.h"

@interface SettingCell ()
@property (nonatomic, strong) UISwitch *switchBtn;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *arrowView;
@end

@implementation SettingCell

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image_arrow_right"]];
    }
    return _arrowView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, 100, SETTING_CELL_HEIGHT);
        _label.textAlignment = NSTextAlignmentRight;
        _label.textColor = [UIColor grayColor];
        _label.font = [UIFont systemFontOfSize:14];
    }
    return _label;
}

- (UISwitch *)switchBtn
{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
        _switchBtn.onTintColor = TabBar_T_Color;
        [_switchBtn addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;
    
    [self setupData];
    
    [self setupAccessoryView];
}

- (void)setupData
{
    if (self.item.title) {
        self.textLabel.text = self.item.title;
    }
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
}

- (void)setupAccessoryView
{
     if ([self.item isKindOfClass:[SettingArrowLabelItem class]]) {
         self.accessoryView = self.arrowView;
         SettingArrowLabelItem *item = (SettingArrowLabelItem *)self.item;
         self.detailTextLabel.text = item.text;
         self.detailTextLabel.font = [UIFont systemFontOfSize:14];
         self.selectionStyle = UITableViewCellSelectionStyleDefault;
     } else if ([self.item isKindOfClass:[SettingArrowItem class]]) {
         self.accessoryView = self.arrowView;
         self.detailTextLabel.text = nil;
         self.selectionStyle = UITableViewCellSelectionStyleDefault;
     } else if ([self.item isKindOfClass:[SettingSwitchItem class]]) {
         self.accessoryView = self.switchBtn;
         // 获取开关状态
         self.switchBtn.on = [SaveTool boolForKey:self.item.title];
         self.detailTextLabel.text = nil;
         self.selectionStyle = UITableViewCellSelectionStyleNone;
     } else if ([self.item isKindOfClass:[SettingLabelItem class]]) {
         self.accessoryView = nil;
         SettingArrowLabelItem *item = (SettingArrowLabelItem *)self.item;
         self.label.text = item.text;
         self.accessoryView = self.label;
         self.detailTextLabel.text = nil;
         self.selectionStyle = UITableViewCellSelectionStyleDefault;
     } else if ([self.item isKindOfClass:[SettingItem class]]) {
         self.accessoryView = nil;
         self.detailTextLabel.text = nil;
         self.selectionStyle = UITableViewCellSelectionStyleNone;
     }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const identifier = @"SettingCell";
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)switchStatusChanged:(UISwitch *)switchBtn
{
    // do sth
    
    // 保存开关状态
    [SaveTool setBool:switchBtn.on forKey:self.item.title];
}

@end
