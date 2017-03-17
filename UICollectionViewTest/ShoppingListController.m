//
//  ShoppingListController.m
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/28.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import "ShoppingListController.h"
#import "JJBaseCell.h"
#import <MJExtension.h>

@interface ShoppingListController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    CGFloat _cellHeight;
    NSIndexPath *_longPressIndexPath;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *deleteArray;

@property (nonatomic,strong)NSMutableArray *sameNameLabel;


@property (nonatomic,strong)UIButton *seletcAllBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIView *baseView;



@end

@implementation ShoppingListController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.dataArray = [[NSMutableArray alloc]initWithArray:[[DBTool sharedDBTool]getAllModel]];
    });
  

                          
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, fNavBarHeigth+1, fDeviceWidth, fDeviceHeight-fNavBarHeigth-60-1) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.rowHeight  = _cellHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self initUI];
    [self setUpDeleteBtn];
    [self.view addSubview:[self navCustomView]];
    [self.tableView reloadData];
    NSLog(@"------%@",[NSThread currentThread]);
    

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)initUI{
    [self.nameLabel setHidden:YES];
    self.titleLabel.text = @"ShoppingList";
    [self.navCustomView addSubview:self.titleLabel];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backToLastItem)];
    swipeGesture.delegate = self;
    [self.view addGestureRecognizer:swipeGesture];
    
}

- (void)backToLastItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpDeleteBtn{
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    selectedBtn.frame = CGRectMake(10, 30, 60, 30);
    
    [selectedBtn setTitle:@"选择" forState:UIControlStateNormal];
    
    [selectedBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navCustomView addSubview:selectedBtn];
    
    //    UIBarButtonItem *selectItem = [[UIBarButtonItem alloc] initWithCustomView:selectedBtn];
    //
    //    self.navigationItem.rightBarButtonItem =selectItem;
    
    //   全选
    
    _seletcAllBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _seletcAllBtn.frame = CGRectMake(fDeviceWidth-15-40, 30, 60, 30);
    
    [_seletcAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    
    [_seletcAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navCustomView addSubview:_seletcAllBtn];
    
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_seletcAllBtn];
    //
    //    self.navigationItem.leftBarButtonItem = leftItem;
    
    _seletcAllBtn.hidden = YES;
    
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height- 60, self.view.frame.size.width, 60)];
    
    _baseView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_baseView];
    
    //删除按钮
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _deleteBtn.backgroundColor = [UIColor redColor];
    
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    _deleteBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    
    [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_baseView addSubview:_deleteBtn];
    
    self.deleteArray = [[NSMutableArray alloc]initWithCapacity:0];
    
}

- (void)selectedBtn:(UIButton *)sender{
    //1.首先是这样选择按钮的响应事件,在按钮事件里面要有self.tableView.allowsMutipleSelectionDuringEditing = YES;允许支持同时选择多行
    //2.然后再点击的时候让tableView.editing = !tablview.editing点击此按钮可切换tableView的编辑状态
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = !self.tableView.editing;
    if(self.tableView.editing){
        _seletcAllBtn.hidden = NO;
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        _seletcAllBtn.hidden = YES;
        [sender setTitle:@"选择" forState:UIControlStateNormal];
    }
    
}

//全选按钮
- (void)selectAllBtnClick:(UIButton *)sender{
    
    //点击全选按钮时,这里的是选中所有的cell而不是当前屏幕上的cell,先去self.dataArray里面遍历,然后找到对应的一共多少行,获取索引值indexPath,tableView有系统方法[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];选择全部的cell,然后在这个方法中将数据源self.dataArray的所有数据全部添加到self.deleteArray中即可
    for(int i=0;i<self.dataArray.count;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.deleteArray addObjectsFromArray:self.dataArray];
    }
    
    
}

//删除按钮
- (void)deleteClick:(UIButton *)sender{
    //无论是多行删除还是全部删除的数据对tableview的操作都是走这个delete方法的, 在方法中适当判断当前的tableView是否处于编辑状态,然后再执行删除操作,关键点就是将数据源的self.dataArray中要删除的数据移除,之前的多选或者全选已经将我们要删除的数据存储在self.deleteArray中
    if(self.tableView.editing) {
        for(JJBaseModel *model in self.deleteArray){
            [[DBTool sharedDBTool]deleteModel:model];
        }
        [self.dataArray removeObjectsInArray:self.deleteArray];
        [self.tableView reloadData];
    }else {
        return;
    }
}

#pragma mark dataSourece and Delegate ---------begin

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle==UITableViewCellEditingStyleDelete){//删除
        if(indexPath.row<self.dataArray.count){
            [self.deleteArray addObject:self.dataArray[indexPath.row]];
            [self.dataArray removeObjectsInArray:self.deleteArray];
            for(JJBaseModel *model in self.deleteArray) {
                [[DBTool sharedDBTool]deleteModel:model];
            }
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        //真正项目中做删除
        //1.将表中的cell删除
        //2.将本地的数组中数据删除
        //3.最后将服务器端的数据删除
    }
}

//选择你要对表进行处理的方式,默认是删除方式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete ;
    //    | UITableViewCellEditingStyleInsert
    //    注意:当这一行代码加上时滑动删除就不起作用了
    
}

//选中时将选中行的在self.dataArray中的数据添加到删除数组self.deleteArray中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.deleteArray addObject:[self.dataArray objectAtIndex:indexPath.row]];
}

//取消选中时 将存放在self.deleArray中的数据移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.deleteArray removeObject:[self.dataArray objectAtIndex:indexPath.row]];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJBaseCell *cell = [JJBaseCell cellWithTableView:self.tableView];
    cell.baseModel = self.dataArray[indexPath.row];
    NSArray *testArray = [NSArray arrayWithArray:[[DBTool sharedDBTool]newGetAllModelWithTableName:cell.baseModel.titleName]];
    NSLog(@"testArray:::::%@",testArray);
    _cellHeight = cell.contentHeight;
    [self addLongPressGestureRecognizerInView:cell.contentView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84.5;
}
#pragma mark dataSourece and Delegate-------------------end



#pragma mark --长按删除单元格的方法----------begin
- (void)addLongPressGestureRecognizerInView:(UIView *)superView{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAct:)];
    longPress.minimumPressDuration = 0.80f;
    [superView addGestureRecognizer:longPress];
    
}

- (void)longPressAct:(UILongPressGestureRecognizer *)recognizer{
    if(recognizer.state==UIGestureRecognizerStateBegan){
        CGPoint point = [recognizer locationInView:self.tableView];
        _longPressIndexPath = [self.tableView indexPathForRowAtPoint:point];
        if(_longPressIndexPath==nil){
            return;
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要删除当前的这一行数据" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是" , nil];
            alert.delegate = self;
            [alert show];
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==1){
        self.tableView.editing = YES;
        [self.deleteArray addObject:[self.dataArray objectAtIndex:_longPressIndexPath.row]];
        for(JJBaseModel *model in self.deleteArray){
            [[DBTool sharedDBTool]deleteModel:model];
        }
        [self.dataArray removeObjectsInArray:self.deleteArray];
        //长按删除后,其他行还是未编辑状态
        self.tableView.editing = NO;
        [self.tableView reloadData];
        
    }else{
        return;
    }
}
#pragma mark end------------------------
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
