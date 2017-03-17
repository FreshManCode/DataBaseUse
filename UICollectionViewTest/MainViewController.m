//
//  MainViewController.m
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/24.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import "MainViewController.h"
#import "JJBaseCollectionViewCell.h"
#import "JJBaseModel.h"
#import "JJBaseScrllView.h"
#import "JJItemDetailViewController.h"
#import <MJExtension.h>

@interface MainViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,JJBaseScrllViewDelegate,UIAlertViewDelegate,JJBaseCollectionViewCellDelegate>
{
    NSArray *_contentArray;
    NSMutableArray *_pictureArray;
    NSArray *_nameArray;
    
}

@property (nonatomic,strong)JJBaseScrllView *adScrollView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


- (void)initUI{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.title = @"A simple CollectionView";
    
    
    float AD_height = 64*2+20;
    
    
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
    [flowLayOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayOut.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayOut];
                                                                            
    self.collectionView.delegate  =self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[JJBaseCollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadIdentifier];
     _contentArray = [NSArray arrayWithObjects:@"NoContent.png",@"NoNetwork.png",@"NoContent.png",@"NoContent.png",@"NoContent.png",@"NoContent.png",@"NoContent.png", @"NoNetwork.png",@"NoNetwork.png",@"NoNetwork.png",@"NoNetwork.png",@"NoNetwork.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",@"cat.png",nil];
    _nameArray = [NSArray arrayWithObjects:@"NoContent",@"NoNetWork",@"NoContent",@"NoContent",@"NoContent",@"NoContent",@"NoContent",@"NoNetWork",@"NoNetWork",@"NoNetWork",@"NoNetWork",@"NoNetWork",@"cat",@"cat",@"cat",@"cat",@"cat",nil];
    
    _pictureArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    for(int i=0;i<_contentArray.count;i++)
    {
        JJBaseModel *baseModel = [[JJBaseModel alloc]init];
        baseModel.imageName = _contentArray[i];
        baseModel.titleName = _nameArray[i];
        [_pictureArray addObject:baseModel];
    }
    
    _adScrollView = [[JJBaseScrllView alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-5, AD_height)];
    _adScrollView.delegate = self;
    _adScrollView.backgroundColor = [UIColor clearColor ];
                     
    
}

- (void)clickCurrentPage:(int)currentPage{
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg",currentPage ];
    NSString *title = [NSString stringWithFormat:@"这个图片的名称是%@",imageName ] ;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"明白" otherButtonTitles:nil, nil];
    [alert show];
}
//当点击任意的提示框按钮时,解除定时器的关闭
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [_adScrollView openTimerFire];
}





#pragma mark --定时滚动ScrollView
- (void)viewDidAppear:(BOOL)animated{
//    显示窗口
    [super viewDidAppear:animated];
//    [NSThread sleepForTimeInterval:2.0f] 睡眠,所有操作都不起作用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//       开启定时器
        [_adScrollView openTimerFire];
        
    });
}
- (void)viewWillDisappear:(BOOL)animated{
//    将要隐藏窗口
//    setModelTransitionStyle = UIModalTransitionStyleCrossDissolve 时是不隐藏的,故不执行
    [super viewWillDisappear:animated];
    if(_adScrollView.imageArray.count>1){
//        关闭定时器
        [_adScrollView invalidateTimer];
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =NO;
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_adScrollView openTimerFire];
}


#pragma mark ----scrollView也是适用于tableview的cell的滚动 将要开始和将要结束时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    关闭定时器
    [_adScrollView invalidateTimer];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(_adScrollView.imageArray.count>1){
//     开启定时器
        [_adScrollView openTimerFire];
    }
}

- (void)addGoodsToShoopingList:(JJBaseModel *)model {
    [[DBTool sharedDBTool]insertAModel:model];
    
    [[DBTool sharedDBTool]newInsertAModel:model];

}
#pragma mark --UICollectionViewDataSourcde
//定义展示的UIConllectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pictureArray.count;
}

//定义展示的section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.delegate = self;
    JJBaseModel *model = _pictureArray[indexPath.item];
    cell.baseModel = model;
    return cell;
    
}

//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //边距占5*4 =20,2个
    //图片为长方形,边长:(fDeviceWidth -20)/2  所以总高(fDeviceWidth-20)/2 ,label高25 btn高25 边
    return CGSizeMake((fDeviceWidth -20)/2.0, (fDeviceWidth -20)/2.0);
//    return CGSizeMake(50, 50);
    
}

//定义每个UICollectionView的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 0);
}

//定义每个UICollectionView纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JJBaseModel *model = _pictureArray[indexPath.row];
    JJItemDetailViewController *vc = [[JJItemDetailViewController alloc]init];
    vc.model = model;
//    vc.titleLabel.text = model.titleName;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"选择%ld",indexPath.row);
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *headView = [collectionView dequeueReusableCellWithReuseIdentifier:HeadIdentifier forIndexPath:indexPath];
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadIdentifier forIndexPath:indexPath];
//    头部广告栏
    [headView addSubview:_adScrollView];
    return headView;
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
