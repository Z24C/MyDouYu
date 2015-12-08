//
//  UIBarButtonItem+Extension.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建图片按钮的UIBarButtonItem
 *
 *  @param icon          normal图片
 *  @param highlightIcon 压下图片
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    UIButton *Btn = [[UIButton alloc] init];
    [Btn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    Btn.bounds = (CGRect){CGPointZero, Btn.currentBackgroundImage.size};
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:Btn];
}
@end
