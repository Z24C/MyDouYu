//
//  UIBarButtonItem+Extension.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/28.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;
@end
