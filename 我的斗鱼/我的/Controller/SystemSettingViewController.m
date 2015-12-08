//
//  SystemSettingViewController.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/4.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "Common.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingGroup.h"
#import "SettingCell.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"
#import "SettingWordCell.h"
#import "SettingSlideCell.h"
#import "SettingSectionHeaderView.h"
#import "SettingWordItem.h"
#import "SettingSliderItem.h"
#import "CacheTool.h"
#import "MBProgressHUD+MJ.h"

@interface SystemSettingViewController () <UITableViewDelegate, UITableViewDataSource, SettingSlideCellDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) SettingLabelItem *wordItem;
/** 记录下弹幕cell位置，便于刷新 */
@property (nonatomic, strong) NSIndexPath *wordCellIndexPath;
/** 记录下缓存cell位置，便于刷新 */
@property (nonatomic, strong) NSIndexPath *cacheCellIndexPath;
@end

@implementation SystemSettingViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self setupTableView];
    // 在子线程中获取缓存
    [self getCache];
}

- (void)setupData
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    SettingSwitchItem *load = [SettingSwitchItem itemWithTitle:@"列表自动加载"];
    SettingSwitchItem *category = [SettingSwitchItem itemWithTitle:@"展示全部分类"];
    
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[load, category];
    group.header = @"系统设置";
    [self.groups addObject:group];
}

- (void)setupGroup1
{
    SettingSwitchItem *gesture = [SettingSwitchItem itemWithTitle:@"播放器手势"];
    SettingItem *wordAlpha = [SettingItem itemWithTitle:@"弹幕透明度"];
    SettingSliderItem *slideAlpha = [SettingSliderItem itemWithTyple:SettingSlideCellTypeAlpha value:DANMU_ALPHA];
    SettingItem *wordSize = [SettingItem itemWithTitle:@"弹幕字号"];
    SettingSliderItem *slideSize = [SettingSliderItem itemWithTyple:SettingSlideCellTypeSize value:DANMU_FONT_SIZE];
    // 需在获取slider后设置
    SettingWordItem *word = [SettingWordItem itemWithFontSize:slideSize.value alpha:slideAlpha.value];
    SettingSwitchItem *sleep = [SettingSwitchItem itemWithTitle:@"休眠设置"];
    
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[gesture, word, wordAlpha, slideAlpha, wordSize, slideSize, sleep];
    group.header = @"直播设置";
    [self.groups addObject:group];
}

- (void)setupGroup2
{
    SettingSwitchItem *message = [SettingSwitchItem itemWithTitle:@"消息通知"];
    __weak typeof(self) weakSelf = self;
    SettingLabelItem *cache = [SettingLabelItem itemWithTitle:@"清除缓存" operation:^{
        [weakSelf showAlertView];
    }];
    SettingArrowItem *about = [SettingArrowItem itemWithTitle:@"关于我们"];
    SettingArrowItem *mark = [SettingArrowItem itemWithTitle:@"给我们评分"];
    
    SettingGroup *group = [[SettingGroup alloc] init];
    group.items = @[message, cache, about, mark];
    group.header = @"其他设置";
    [self.groups addObject:group];
    
    // 保存cache的indexPath
    NSInteger row = [group.items indexOfObject:cache];
    self.cacheCellIndexPath = [NSIndexPath indexPathForRow:row inSection:2];
}

- (void)showAlertView
{
    SettingLabelItem *item = [self.groups[self.cacheCellIndexPath.section] items][self.cacheCellIndexPath.row];
    if ([item.text isEqualToString:@"没有缓存"]) { // 没有缓存
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"没有缓存，无需清理" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    } else { // 有缓存
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"确定要清除缓存吗？" preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showMessage:@"清除缓存" toView:weakSelf.view];
            [CacheTool clearCache];
            dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
                [weakSelf getCache];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[weakSelf.cacheCellIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
                    [MBProgressHUD hideHUDForView:weakSelf.view];
                    [MBProgressHUD showSuccess:@"清除缓存成功" toView:weakSelf.view];
                });
            });
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:ok];
        [alert addAction:cancle];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)getCache
{
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        NSString *cacheStr = [NSString stringWithFormat:@"%.1fM", [CacheTool cacheSize]];
        if ([cacheStr isEqualToString:@"0.0M"]) {
            cacheStr = @"没有缓存";
        }
        SettingLabelItem *item = [self.groups[self.cacheCellIndexPath.section] items][self.cacheCellIndexPath.row];
        item.text = cacheStr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadRowsAtIndexPaths:@[self.cacheCellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
    });
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor whiteColor];
}

- (void)backBarButtonItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingGroup *group = self.groups[indexPath.section];
    id item = group.items[indexPath.row];
    
    if ([item isKindOfClass:[SettingWordItem class]]) {
        // SettingWordCell
        SettingWordCell *cell = [SettingWordCell cellWithTableView:tableView];
        cell.item = item;
        // 保存wordCellIndexPath便于调整刷新
        self.wordCellIndexPath = indexPath;
        return cell;
    } else if ([item isKindOfClass:[SettingSliderItem class]]) {
        // SettingSlideCell
        SettingSlideCell *cell = [SettingSlideCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.item = item;
        return cell;
    } else {
        // SettingCell
        SettingCell *cell = [SettingCell cellWithTableView:tableView];
        SettingGroup *group = self.groups[indexPath.section];
        cell.item = group.items[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SettingSectionHeaderView *headerView = [SettingSectionHeaderView headerView];
    
    SettingGroup *group = self.groups[section];
    headerView.titleLabel.text = group.header;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SETTING_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SETTING_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SettingGroup *group = self.groups[indexPath.section];
    id item = group.items[indexPath.row];
    
    if ([item isKindOfClass:[SettingItem class]]) {
        SettingItem *settingItem = (SettingItem *)item;
        if (settingItem.operation) {
            settingItem.operation();
            return;
        }
    }
    
    if ([item isKindOfClass:[SettingArrowItem class]]) {
        SettingArrowItem *arrowItem = (SettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *vc = [[arrowItem.destVcClass alloc] init];
            vc.title = arrowItem.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - settingSliderCellDelegate

- (void)settingSlideCell:(SettingSlideCell *)cell slideValue:(CGFloat)value
{
    SettingWordItem *item = [self.groups[1] items][1];
    
    switch (cell.item.type) {
        case SettingSlideCellTypeSize:
            item.fontSize = value;
            break;
            
        case SettingSlideCellTypeAlpha:
            item.alpha = value;
            
        default:
            break;
    }
    
    // 刷新展示行
    [self.tableView reloadRowsAtIndexPaths:@[self.wordCellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
