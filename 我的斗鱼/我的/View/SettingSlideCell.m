//
//  SettingSlideCell.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingSlideCell.h"
#import "Common.h"
#import "SettingSliderItem.h"
#import "SaveTool.h"

@interface SettingSlideCell ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *smallImgView;
@property (weak, nonatomic) IBOutlet UIImageView *bigImgView;
@end

@implementation SettingSlideCell

- (void)awakeFromNib
{
    [self.slider addTarget:self action:@selector(sliderStatusChanged:) forControlEvents:UIControlEventValueChanged];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)sliderStatusChanged:(UISlider *)slider
{
    // 改变自己的值
    self.item.value = slider.value;
    
    // 保存value
    [SaveTool setFloat:slider.value forKey:[NSString stringWithFormat:@"%d", self.item.type]];
    
    if ([self.delegate respondsToSelector:@selector(settingSlideCell:slideValue:)]) {
        [self.delegate settingSlideCell:self slideValue:slider.value];
    }
}

- (void)setItem:(SettingSliderItem *)item
{
    _item = item;
    
    switch (item.type) {
        case SettingSlideCellTypeSize:
            [self setupSizeCell];
            break;
            
        case SettingSlideCellTypeAlpha:
            [self setupAlphaCell];
            break;
            
        default:
            break;
    }
    
    // 设置slider初始值，需在设置slider范围后设置
    self.slider.value = item.value;
}

- (void)setupSizeCell
{
    self.smallImgView.image = [UIImage imageNamed:@"Image_font_small"];
    self.bigImgView.image = [UIImage imageNamed:@"Image_font_big"];
    // 设置slider范围
    self.slider.minimumValue = DANMU_FONT_MINISIZE;
    self.slider.maximumValue = DANMU_FONT_MAXSIZE;
}

- (void)setupAlphaCell
{
    self.smallImgView.image = [UIImage imageNamed:@"Image_alpha_small"];
    self.bigImgView.image = [UIImage imageNamed:@"Image_alpha_big"];
    // 设置slider范围
    self.slider.minimumValue = 0.2;
    self.slider.maximumValue = 1.0;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const identifier = @"SettingSlideCell";
    SettingSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingSlideCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
