//
//  MoreViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/3.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "MoreViewController.h"
#import "Common.h"
#import "MoreCollectionFlowLayout.h"
#import "MJRefresh.h"
#import "HttpTool.h"
#import "NSString+NowTime.h"
#import "DYData.h"
#import "DYRoom.h"
#import "MJExtension.h"
#import "RecommendCollectionCell.h"
#import "PlayerController.h"

#define URL @"http://www.douyutv.com/api/v1/live/"
#define URL2 @"?aid=ios&auth=9e3802f36db0fd94e29839ee3a92834a&client_sys=ios&limit=20&offset=0&time="
#define URL3 @"?aid=ios&auth=9e3802f36db0fd94e29839ee3a92834a&client_sys=ios&limit=20&offset="
#define URL4 @"&time="
#define URL_a @"0"

@interface MoreViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation MoreViewController

- (void)setDyData:(DYData *)dyData
{
    _dyData = dyData;
    self.title = dyData.title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCollectionView];
    [self setupRefreshView];
}

- (NSMutableArray *)rooms
{
    if (_rooms == nil) {
        _rooms = [NSMutableArray array];
    }
    return _rooms;
}

- (void)setupRefreshView
{
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData
{
    self.roomCount = self.roomCount + 20;
    NSString *roomCount = [NSString stringWithFormat:@"%ld", self.roomCount];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",URL,self.dyData.cate_id,URL3,roomCount,URL4,[NSString nowTime]];
    
    [HttpTool get:urlStr params:nil success:^(id responseObj) {
        NSArray *rooms = [DYRoom mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        [self.rooms addObjectsFromArray:rooms];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        DYLog(@"%s %@", __FUNCTION__, error);
    }];
}

- (void)loadNewData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@",URL,self.dyData.cate_id,URL2,[NSString nowTime]];
    
    [HttpTool get:urlStr params:nil success:^(id responseObj) {
        NSArray *rooms = [DYRoom mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        if (self.rooms.count == 0) {
            self.rooms = [rooms mutableCopy];
        } else {
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:rooms];
            [tempArray addObjectsFromArray:self.rooms];
            self.rooms = tempArray;
        }
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
    } failure:^(NSError *error) {
        DYLog(@"%s %@", __FUNCTION__, error);
    }];
}

- (void)setupCollectionView
{
    MoreCollectionFlowLayout *layout = [[MoreCollectionFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVI_HEIGHT) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = SEPARATOR_COLOR;
    [collectionView registerNib:[UINib nibWithNibName:@"RecommendCollectionCell" bundle:nil] forCellWithReuseIdentifier:COLLECTION_IDENTIFIER];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - collectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rooms.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_IDENTIFIER forIndexPath:indexPath];
    // 设置cell显示内容
    DYRoom *room = self.rooms[indexPath.item];
    cell.room = room;
    
    return cell;
}

#pragma mark - collectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerController *playerVc = [[PlayerController alloc] init];
    playerVc.room = self.rooms[indexPath.item];
    [self presentViewController:playerVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
