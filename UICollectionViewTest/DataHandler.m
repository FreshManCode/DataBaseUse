//
//  DataHandler.m
//  ZMArchitecture
//
//  Created by ZM on 16/5/11.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import "DataHandler.h"
#import "YTKKeyValueStore.h"
//#import "Finance.h"

@implementation DataHandler


#pragma mark ======================="  测试  "=================================

- (void)testYTKKeyValueStore {
    
//    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"SqlitDBName.db"];
//    if ([store isTableExists:@"tableName"]) {
//        [store deleteTable:@"tableName"];
//    }
    
//    // 创建数据库
//    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"Product.db"];
//    // 创建表格
//    NSString *tableName = @"Finance_table";
//    //	[store createTableWithName:tableName];
//    // 查询获取模型
//    Page *page1 = [store getModelObjectById:@"2" className:[Page class] fromTable:tableName];
//    NSLog(@"borrowTitle1 = %@", page1.borrowTitle);
    
    //	// 删除表库
    //		YTKKeyValueStore *store = [[YTKKeyValueStore alloc] init];
    //		[store deleteDatabseWithDBName:@"Product.db"];
    
    //	NSString* password = @"111111";
    //	password = [password md5Encrypt];
    //
    //	NSDictionary* params = @{@"custId":@"chenyangyang",
    //							 @"custPwd":password};
    //	// requestPostURl
    //	[NetworkManager requestGetURl:Login withParameters:params success:^(id data) {
    //
    //		NSLog(@"data = \n %@",data);
    //
    //	} failure:^(NSError *error) {
    //	}];
}
/**
 *  分业务模块：
 */
+ (NSMutableArray *)dataArrayOfPSModel:(Person *)personModel {

	NSMutableArray* dataArray = [[NSMutableArray alloc] initWithCapacity:100];
	return dataArray;
}


#pragma mark ======================="  数据处理  "=================================

// 创建数据库、表、存储数据
// NSLog(@"--> tableName = %@",tableName);

// 存入一个模型：Id= tableName  （ model ）
+ (void)setModel:(id)Model fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:sqlitDBName];
    [store createTableWithName:tableName];
    [store putModelObject:Model withId:tableName intoTable:tableName];
}
// 取模型 （ model ）
+ (id)getModelByClass:(Class)className fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:sqlitDBName];
    return [store getModelObjectById:tableName className:[className class] fromTable:tableName];
}


// 存入数组：只用一个Id= tableName  ( NSArray )
+ (void)setArray:(NSArray *)array fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:sqlitDBName];
    [store createTableWithName:tableName];
    [store putModelObjectArray:array intoTable:tableName];
}
// 取数组：( NSArray )
+ (NSMutableArray *)getArrayByClass:(Class)className fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName
{
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:sqlitDBName];
    if ([store isTableExists:tableName]) {
        return (NSMutableArray*)[store getModelArrayByclassName:[className class] fromTable:tableName];
    }
    return nil;
}








@end
