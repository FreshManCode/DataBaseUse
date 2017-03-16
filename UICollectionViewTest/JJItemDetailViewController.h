//
//  JJItemDetailViewController.h
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/25.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJBaseModel.h"

@interface JJItemDetailViewController : UIViewController<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *picTure;
@property (nonatomic,strong)UIScrollView *bgScroll;
@property (nonatomic,strong)UIButton *shoppingList;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIView *navCustomView;
@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic,strong)JJBaseModel *model;

- (void)enableSwipeGesture;
- (void)popFromCurrentViewController;

@end
