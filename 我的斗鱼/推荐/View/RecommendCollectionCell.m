//
//  RecommendCollectionCell.m
//  我的斗鱼
//
//  Created by 周驰 on 15/12/1.
//  Copyright © 2015年 周驰. All rights reserved.
//

#import "RecommendCollectionCell.h"
#import "DYRoom.h"
#import "UIImageView+WebCache.h"
#import "NSString+onlineNumber.h"

@interface RecommendCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *recommendImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineNumberLabel;
@end

@implementation RecommendCollectionCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setRoom:(DYRoom *)room
{
    _room = room;
    
    NSURL *imgURL = [NSURL URLWithString:[room.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.recommendImageView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Img_default.png"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.nameLabel.text = room.nickname;
    self.onlineNumberLabel.text = [room.online onlinePeople];
    self.detailLabel.text = room.room_name;
}

@end
