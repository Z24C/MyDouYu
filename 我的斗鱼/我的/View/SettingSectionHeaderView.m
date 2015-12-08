//
//  SettingSectionHeaderView.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/5.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SettingSectionHeaderView.h"
#import "Common.h"

@interface SettingSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SettingSectionHeaderView

- (void)awakeFromNib
{
    self.backgroundColor = SEPARATOR_COLOR;
}

+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SettingSectionHeaderView" owner:nil options:nil] lastObject];
}

@end
