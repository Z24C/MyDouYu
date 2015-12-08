//
//  SettingLoginCell.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingArrowItem;

@interface SettingLoginCell : UITableViewCell
@property (nonatomic, strong) SettingArrowItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
