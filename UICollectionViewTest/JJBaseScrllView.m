//
//  JJBaseScrllView.m
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/24.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import "JJBaseScrllView.h"

@interface JJBaseScrllView ()<UIScrollViewDelegate>
{
    int _pageNum;
    int _currentPage;
}

@end
@implementation JJBaseScrllView

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
       
//      初始化定义的数组
        [self imageArray];
//      添加头部滚动的滑动试图
        [self addSubview:[self adScrollView]];
//      添加圆点
        [self addSubview:[self pageControl]];
//      添加当前显示的分数
        [self numLabel];

    }
    return self;
}

- (UIScrollView *)adScrollView{
    if(!_adScrollView){
        _adScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 64*2)];
        _adScrollView.backgroundColor = [UIColor clearColor];
        _adScrollView.delegate = self;
//      是否显示竖向滚动条
        _adScrollView.showsVerticalScrollIndicator = NO;
//      是否显示横向滚动条
        _adScrollView.showsHorizontalScrollIndicator = NO;
//      设置是否分页
        _adScrollView.pagingEnabled = YES;
        _adScrollView.bounces = NO;
        _adScrollView.contentSize = CGSizeMake(fDeviceWidth*_imageArray.count, 64*2);
        
        
        for(int i=0;i<_imageArray.count;i++)
        {
//            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(fDeviceWidth*i, 0, fDeviceWidth, 64*2)];
//            view.backgroundColor = [UIColor clearColor];
//            [_adScrollView addSubview:view];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth*i, 0, fDeviceWidth, 64*2)];
            image.userInteractionEnabled = YES;
            image.image =[UIImage imageNamed:_imageArray[i]];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookAdInfo:)];
//            _currentPage =i;
             [_adScrollView addSubview:image];
             [image addGestureRecognizer:tapGesture];

        }
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_adScrollView.frame),fDeviceWidth-20, 20)];
//        _numLabel.backgroundColor = [UIColor redColor];
        _numLabel.font = [UIFont systemFontOfSize:15];
        _numLabel.textColor = [UIColor purpleColor];
        _numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel.text = [NSString stringWithFormat:@"%d/%d",(int)_pageControl.currentPage+1,(int)_imageArray.count];
        [self addSubview:_numLabel];
        
        /**
         *  配置定时器
         *
         *  @param timeAction: 在定时器的行为中滚动
         *
         *  @return 让广告栏在适当的时候滚动
         */
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
//       关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
        
    }
    return _adScrollView;
}


- (UIPageControl *)pageControl{
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_adScrollView.frame), fDeviceWidth, 20)];
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.currentPage = 0;
        //       没选中的颜色
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        //        选中的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    }
    return _pageControl;
}
- (NSArray*)imageArray{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    if(!_imageArray){
        for(int i=0;i<7;i++){
            NSString *title = [NSString stringWithFormat:@"%d.jpg",i];
            [array addObject:title];
        }
        _imageArray = [NSArray arrayWithArray:array];
    }
    return _imageArray;
}

-(void)timeAction:(NSTimer *)timer
{
    if(_imageArray.count >1){
        CGPoint newOffset = _adScrollView.contentOffset;
        newOffset.x = newOffset.x+CGRectGetWidth(_adScrollView.frame);
        if(newOffset.x>(CGRectGetWidth(_adScrollView.frame)*(_imageArray.count-1))){
            newOffset.x =0;
            
        }
//        当前是第几个视图
        int index = newOffset.x/CGRectGetWidth(_adScrollView.frame);
        newOffset.x =index*CGRectGetWidth(_adScrollView.frame);
        _numLabel.text = [NSString stringWithFormat:@"%d / %ld ",index+1,_imageArray.count];
        [_adScrollView setContentOffset:newOffset animated:YES];
    }else{//关闭定时器
        [_timer setFireDate:[NSDate distantPast]];
//        [self invalidateTimer];
    }
    
//    NSInteger page = self.pageControl.currentPage;
//    if(page==_imageArray.count-1)
//    {
//        page=0;
//    }else{
//        page++;
//    }
//    _adScrollView.contentOffset = CGPointMake(page*fDeviceWidth, 0);
//    _numLabel.text = [NSString stringWithFormat:@"%d/%d",(int)_pageControl.currentPage+1,(int)_imageArray.count];
    
}

//滚动就会执行(会多次)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if(self.imageArray.count>1)
//    {
//        [self invalidateTimer];
//    }
    
    if([scrollView isMemberOfClass:[UITableView class]]){
    }else{
        int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
        _pageControl.currentPage = index;
        for(UIView *view in scrollView.subviews){
            if(view.tag ==index){
                
            }else{
                
            }
        }
    }
}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    [self openTimerFire];
//}



- (void)openTimerFire{
//   开启定时器
    [_timer setFireDate:[NSDate distantPast]];
//    [_timer fire];
}
- (void)invalidateTimer{
//   关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
//    [_timer invalidate];
//    _timer =nil;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageNum = _adScrollView.contentOffset.x/fDeviceWidth;
    _pageControl.currentPage =_pageNum;
}

- (void)lookAdInfo:(UITapGestureRecognizer *)sender{
    [self invalidateTimer];
    
   if(_delegate &&[_delegate respondsToSelector:@selector(clickCurrentPage:)])
   {
       [_delegate clickCurrentPage:(int)_pageControl.currentPage];
   }
    
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
