//
//  SettingWordCell.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingWordCell.h"
#import "SettingWordItem.h"

@interface SettingWordCell ()
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@end

@implementation SettingWordCell

- (void)setItem:(SettingWordItem *)item
{
    _item = item;
    
    self.wordLabel.font = [UIFont systemFontOfSize:item.fontSize];
    self.wordLabel.alpha = item.alpha;
}

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const identifier = @"SettingWordCell";
    SettingWordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingWordCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
