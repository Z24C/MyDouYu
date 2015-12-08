//
//  RookieTableViewCell.m
//  我的斗鱼
//
//  Created by 周驰 on 15/11/30.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "RookieTableViewCell.h"
#import "Common.h"
#import "RookieIcon.h"
#import "DYRookieData.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "NSString+NowTime.h"

@interface RookieTableViewCell ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imgURLs;
@end

@implementation RookieTableViewCell

- (NSArray *)imgURLs
{
    if (_imgURLs == nil) {
        _imgURLs = [NSMutableArray array];
    }
    return _imgURLs;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView
{
    // 添加背景scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:scrollView];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ROOKIE_CELL_HEIGHT);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, ROOKIE_CELL_HEIGHT);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    
    // 添加分隔线
    UIView *separatorLine = [[UIView alloc] init];
    [self.contentView addSubview:separatorLine];
    separatorLine.frame = CGRectMake(0, ROOKIE_CELL_HEIGHT-1, SCREEN_WIDTH, 1);
    separatorLine.backgroundColor = SEPARATOR_COLOR;
}

- (void)setRookieDatas:(NSArray *)rookieDatas
{
    if (_rookieDatas != rookieDatas) {
        _rookieDatas = rookieDatas;
        // 删除旧imgURL缓存
        [self.imgURLs removeAllObjects];
    }
    
    CGFloat rookieViewW = SCREEN_WIDTH / 4;
    self.scrollView.contentSize = CGSizeMake(rookieViewW * rookieDatas.count, ROOKIE_CELL_HEIGHT);
    for (int i = 0; i < rookieDatas.count; ++i) {
        DYRookieData *rookieData = rookieDatas[i];
        RookieIcon *rookieView = [RookieIcon icon];
        rookieView.width = rookieViewW;
        rookieView.x = i * rookieViewW;
        [_scrollView addSubview:rookieView];
        rookieView.nameLabel.text = rookieData.nickname;
        rookieView.gameLabel.text = rookieData.game_name;
        
        // 设置头像图片
        if (self.imgURLs.count < rookieDatas.count) {
            // 保存url，防止因url改变重新开启下载
            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",NEW_Image_URl,[self countNumAndChangeformat:rookieData.owner_uid],NEW_Time_URl,[NSString nowTime]]];
            [self.imgURLs addObject:imageURL];
        }
        [rookieView.iconView sd_setImageWithURL:self.imgURLs[i] placeholderImage:[UIImage imageNamed:@"Img_default"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
        
        //  添加手势
        rookieView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rookieViewTapped:)];
        [rookieView addGestureRecognizer:tap];
    };
}

- (void)rookieViewTapped:(UIGestureRecognizer *)tap
{
    DYLog(@"%s %ld", __FUNCTION__, tap.view.tag);
}

-(NSString *)countNumAndChangeformat:(NSString *)str
{
    
    NSMutableString *num=[NSMutableString stringWithString:str];
    int temp=9-(int)num.length;
    
    if (temp) {
        for (int i=0; i<temp; i++) {
            [num insertString:@"0" atIndex:0];
        }
    }
    
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 2) {
        count -= 2;
        NSRange rang = NSMakeRange(string.length - 2, 2);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"/" atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    
    [newstring insertString:string atIndex:0];
    [newstring insertString:@"/" atIndex:3];
    [newstring insertString:@"/" atIndex:0];
    [newstring stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    return newstring;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"rookie";
    RookieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RookieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
