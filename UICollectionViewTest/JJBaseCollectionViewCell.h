//
//  JJBaseCollectionViewCell.h
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/24.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJBaseModel.h"

@protocol JJBaseCollectionViewCellDelegate <NSObject>

- (void)addGoodsToShoopingList:(JJBaseModel *)model;

@end


@interface JJBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *bgPicture;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIButton *numBtn;
@property (nonatomic,assign)id<JJBaseCollectionViewCellDelegate>delegate;

@property (nonatomic,strong)JJBaseModel *baseModel;




@end
