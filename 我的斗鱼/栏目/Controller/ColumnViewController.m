//
//  ColumnViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/26.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "ColumnViewController.h"
#import "ColumnCollectionViewFlowLayout.h"
#import "ColumnCollectionViewCell.h"
#import "ColumnData.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "Common.h"

static NSString * const URL = @"http://www.douyutv.com/api/v1/game?aid=ios&auth=3f252c3294b31a61fbdd890a45609549&client_sys=ios&time=1446450360";

static NSString * const identifier = @"ColumnCollectionViewCell";

@interface ColumnViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *columnDatas;
@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    [self loadData];
}

- (void)loadData
{
    [HttpTool get:URL params:nil success:^(id responseObj) {
        self.columnDatas = [ColumnData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        DYLog(@"%s %@", __FUNCTION__, error);
    }];
}

- (void)setupCollectionView
{
    ColumnCollectionViewFlowLayout *layout = [[ColumnCollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ColumnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    collectionView.backgroundColor = SEPARATOR_COLOR;
}

#pragma mark - collectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.columnDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.columnData = self.columnDatas[indexPath.item];
    return cell;
}

#pragma mark - collectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DYLog(@"%s %ld", __FUNCTION__, indexPath.item);
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
