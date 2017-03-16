//
//  DBTool.m
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/25.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import "DBTool.h"
#import <FMResultSet.h>

@interface DBTool ()
{
    FMDatabase *_db;
}

@end
@implementation DBTool

//如果有数据库文件
//1.如果沙盒中没有,把文件拷贝到沙盒中再打开
//2.如果沙河中有,就直接打开

+ (instancetype)sharedDBTool{
    static DBTool *manager;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        manager = [[DBTool alloc]init];
    });
    return manager;
}

- (id)init{
    if(self = [super init]){
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/a.sqlite"];
        _db = [[FMDatabase alloc]initWithPath:path];
        if([_db open]){
            NSString *sqlite = @"CREATE TABLE IF NOT EXISTS JJBaseModel (ID integer  primary key autoincrement, titleName text,imageName text,menuNum int )";
            [_db executeUpdate:sqlite];
        }
        [_db close];
    }
    return self;
}
- (void)insertAModel:(JJBaseModel *)model {
    if([_db open])
    {
        FMResultSet *set = [_db executeQuery:@"select * from JJBaseModel where titleName = ?",model.titleName];
        NSLog(@"插入的数据名字为:%@",model.titleName);
        if ([set next]) {
            BOOL isUpdate = [_db executeUpdate:@"update JJBaseModel set menuNum = menuNum +1 where titleName =?",model.titleName];
            NSLog(@"12%@",isUpdate? @"成功":@"失败");
        }else {
         BOOL isUpdate = [_db executeUpdate:@"insert into JJBaseModel (menuNum,titleName,imageName) values (?,?,?)",[NSNumber numberWithInt:model.menuNum], model.titleName,model.imageName];
            NSLog(@"首次插入数据%@",isUpdate? @"成功":@"失败");
            
        }
    }
    [_db close];
}

- (void)deleteModel:(JJBaseModel *)model{
    if([_db open]){
        [_db executeUpdate:@"delete from JJBaseModel where titleName =?",model.titleName];
    }
    [_db close];
}
- (NSArray *)getAllModel{
    if([_db open]){
        FMResultSet *set = [_db executeQuery:@"select * from JJBaseModel"];
        NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
        while ([set next]) {
            JJBaseModel *model = [[JJBaseModel alloc]init];
            model.titleName = [set stringForColumnIndex:1];
            model.imageName = [set stringForColumnIndex:2];
            model.menuNum   = [set intForColumnIndex:3];
            [array addObject:model];
        }
        [set close];
        [_db close];
        NSLog(@"------***%d",(int)array.count);
        return array;
    }else
    {
        [_db close];
        return nil;
    }
}








@end
