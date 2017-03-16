//
//  JJBaseScrllView.h
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/24.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJBaseScrllView;
@protocol JJBaseScrllViewDelegate;


@interface JJBaseScrllView : UIView

@property (nonatomic,strong)UIScrollView *adScrollView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UILabel *numLabel;

@property (nonatomic,assign)id<JJBaseScrllViewDelegate>delegate;

- (void)openTimerFire;
- (void)invalidateTimer;


@end

@protocol JJBaseScrllViewDelegate <NSObject>

- (void)clickCurrentPage:(int)currentPage;


@end