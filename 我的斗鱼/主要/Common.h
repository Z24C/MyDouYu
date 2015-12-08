//
//  Common.h
//  我的斗鱼
//
//  Created by 周驰 on 15/11/26.
//  Copyright © 2015年 周驰. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Common_h
#define Common_h

// 屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// 视频item宽度
#define RECOMMEND_ITEM_WIDTH ((SCREEN_WIDTH - 3 * ITEM_PADDING) * 0.5)
// 视频item高度
#define RECOMMEND_ITEM_HEIGHT (RECOMMEND_ITEM_WIDTH / 16 * 9 + 20)
// 栏目item宽度
#define COLUMN_ITEM_WIDTH ((SCREEN_WIDTH - ITEM_PADDING * 4) / 3)
// 栏目item高度
#define COLUMN_ITEM_HEIGHT (COLUMN_ITEM_WIDTH / 3 * 4 + 20)
// 推荐tableView行高
#define RECOMMEND_CELL_HEIGHT (RECOMMEND_ITEM_HEIGHT * 2 + ITEM_PADDING)
// 设置行高
#define SETTING_CELL_HEIGHT (SCREEN_WIDTH / 375 * 50)
// 登录行高
#define SETTING_LOGIN_HEIGHT (SCREEN_WIDTH / 375 * 85)

// tabbar橙色
#define TabBar_T_Color RGB(244, 89, 27)
// 分割线颜色
#define SEPARATOR_COLOR RGBA(230, 230, 230, 1.0);

//RGB
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)

#ifdef DEBUG
#define DYLog(...) NSLog(__VA_ARGS__)
#else
#define DYLog(...)
#endif

// 新人推荐tableView行高
extern const int ROOKIE_CELL_HEIGHT;
// 视频推荐cell间距
extern const int ITEM_PADDING;
// 导航条高度
extern const int NAVI_HEIGHT;
// 弹幕默认字体大小
extern const double DANMU_FONT_SIZE;
// 弹幕字体最小
extern const double DANMU_FONT_MAXSIZE;
// 弹幕字体最大
extern const double DANMU_FONT_MINISIZE;
// 弹幕默认透明度
extern const double DANMU_ALPHA;

extern NSString * const TOP_URl;
extern NSString * const NEW_URl;
extern NSString * const NEW_Image_URl;
extern NSString * const NEW_Time_URl;
extern NSString * const CHANEL_URl;
extern NSString * const COLLECTION_IDENTIFIER;

#endif /* Common_h */
