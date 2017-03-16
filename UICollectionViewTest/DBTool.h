//
//  DBTool.h
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/25.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FMDatabase.h>
#import "JJBaseModel.h"


@interface DBTool : NSObject

+ (instancetype)sharedDBTool;
- (void)insertAModel:(JJBaseModel *)model;
- (void)deleteModel:(JJBaseModel *)model;
- (NSArray *)getAllModel;




@end
