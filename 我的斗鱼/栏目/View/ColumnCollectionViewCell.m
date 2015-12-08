//
//  ColumnCollectionViewCell.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/3.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "ColumnCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ColumnData.h"

@interface ColumnCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation ColumnCollectionViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setColumnData:(ColumnData *)columnData
{
    _columnData = columnData;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.columnData.game_icon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Image_no_data.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.nameLabel.text = self.columnData.game_name;
}

@end
