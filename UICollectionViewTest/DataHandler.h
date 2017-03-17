 //
//  DataHandler.h
//  ZMArchitecture
//
//  Created by ZM on 16/5/11.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface DataHandler : NSObject


// 返回数据
+ (NSMutableArray *)dataArrayOfPSModel:(Person *)personModel;


#pragma mark ======================="  数据处理  "=================================


// 创建数据库、表、存储数据
// NSLog(@"--> tableName = %@",tableName);

// 存入一个模型：Id= tableName  （ model ）
+ (void)setModel:(id)Model fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName;
// 取模型 （ model ）

+ (id)getModelByClass:(Class)className fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName;

// 存入数组：只用一个Id= tableName  ( NSArray )
+ (void)setArray:(NSArray *)array fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName;
// 取数组：( NSArray )
+ (NSMutableArray *)getArrayByClass:(Class)className fromTable:(NSString *)tableName forDBName:(NSString *)sqlitDBName;


@end
