//
//  JJBaseCell.h
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/25.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJBaseModel.h"

@interface JJBaseCell : UITableViewCell

@property (nonatomic,strong)UIImageView *picture;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,assign)CGFloat contentHeight;
@property (nonatomic,strong)JJBaseModel *baseModel;

@property (nonatomic,strong)UIImageView *numIcon;
@property (nonatomic,strong)UILabel *numAmount;
@property (nonatomic,strong)UIView *topSepratorLine;
@property (nonatomic,strong)UIView *bottomSepratorLine;


@property (nonatomic,strong)UIView *resoveResuableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
