//
//  JJItemDetailViewController.m
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/25.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import "JJItemDetailViewController.h"
#import "ShoppingListController.h"

@interface JJItemDetailViewController ()



@end

@implementation JJItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI{
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets  =NO;
    [self.view addSubview:[self navCustomView]];
    [self.navCustomView addSubview:[self backBtn]];
    [self.view addSubview:[self titleLabel]];
    [self.view addSubview:[self nameLabel]];
    [self.view addSubview:[self picTure]];
    [self.view addSubview:[self shoppingList]];
    
}

- (UIView *)navCustomView{
    if(!_navCustomView){
        _navCustomView = [[UIView alloc]initWithFrame:CGRectMake(0, StatusBarHeight, fDeviceWidth, 64-StatusBarHeight)];
        _navCustomView.backgroundColor = [UIColor orangeColor];
    }
    return _navCustomView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(10, 17+5, 60, 30);
        [_backBtn addTarget:self action:@selector(backToLastViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
    
}

- (void)backToLastViewController:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UILabel*)titleLabel{
    if( !_titleLabel){
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBarHeight+30, fDeviceWidth, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor purpleColor];
        _titleLabel.text = [NSString stringWithFormat:@"%@详情",_model.titleName];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}



- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, fNavBarHeigth, fDeviceWidth, 30)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor blueColor];
        _nameLabel.text = [NSString stringWithFormat:@"标题为:%@",_model.titleName];
    }
    return _nameLabel;
}

- (UIImageView *)picTure{
    if(!_picTure){
        _picTure = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_model.imageName]];
        _picTure.frame =CGRectMake(10,CGRectGetMaxY( _nameLabel.frame)+15, fDeviceWidth-20, fDeviceHeight-CGRectGetMaxY(_nameLabel.frame)-15-30);
    }
    
    return _picTure;
}
- (UIScrollView *)bgScroll{
    if(!_bgScroll){
        _bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, fNavBarHeigth, fDeviceWidth, CGRectGetMaxY(_picTure.frame))];
        _bgScroll.backgroundColor = [UIColor redColor];
        _bgScroll.contentSize = CGSizeMake(fDeviceWidth, CGRectGetMaxY(_picTure.frame));
        _bgScroll.showsHorizontalScrollIndicator = NO;
        _bgScroll.showsVerticalScrollIndicator = NO;
        _bgScroll.pagingEnabled = YES;
        [self.view addSubview:_bgScroll];
        
    }
    return _bgScroll;
}

- (UIButton *)shoppingList{
    if(!_shoppingList){
        _shoppingList = [[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-70, _nameLabel.frame.origin.y+20, 50, 50)];
//        [_shoppingList setTitle:@"购物车" forState:UIControlStateNormal];
        [_shoppingList setBackgroundImage:[UIImage imageNamed:@"sp_icon"] forState:UIControlStateNormal];
        [_shoppingList addTarget:self action:@selector(openShoppingList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoppingList;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.view addSubview:[self navCustomView]];
    if([[UIDevice currentDevice].systemVersion floatValue]>=7.0){
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
         [self enableSwipeGesture];
        
    }
}

- (void)openShoppingList:(UIButton *)sender{
    ShoppingListController *vc = [[ShoppingListController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
//    [self.view addSubview:[self navCustomView]];
   
//    if([_model.titleName length]>0){
//        [self.nameLabel setHidden:NO];
//        if([_model.imageName length]>0){
//            [self.picTure setHidden:NO];
//        }else{
//            [self.nameLabel setHidden:YES];
//            [self.picTure setHidden:YES];
//        }
//    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if([[UIDevice currentDevice].systemVersion floatValue]>=0){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}



- (void)enableSwipeGesture{
    UISwipeGestureRecognizer *swipeGesture= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    swipeGesture.delegate = self;
    [self.view addGestureRecognizer:swipeGesture];
    
}

- (void)backGesture:(UISwipeGestureRecognizer *)recognizer{
    [self popFromCurrentViewController];
}

- (void)popFromCurrentViewController{
    [self.navigationController popViewControllerAnimated:YES];
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
