//
//  RookieIcon.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/1.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "RookieIcon.h"
#import "UIView+Extension.h"

@implementation RookieIcon

+ (instancetype)icon
{
    return [[[NSBundle mainBundle] loadNibNamed:@"RookieIcon" owner:nil options:nil] lastObject];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.layer.cornerRadius = self.iconView.width*0.5;
    self.iconView.layer.masksToBounds = YES;
}

@end
