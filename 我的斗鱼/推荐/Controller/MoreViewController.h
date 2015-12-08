//
//  MoreViewController.h
//  我的斗鱼
//
//  Created by 周驰 on 15/12/3.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DYData;

@interface MoreViewController : UIViewController
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) DYData *dyData;

@property (nonatomic, strong) NSMutableArray *rooms;
/** 记录下拉刷新从第几条数据开始*/
@property (nonatomic, assign) NSInteger roomCount;

- (void)loadMoreData;
- (void)loadNewData;
@end
