//
//  JJHeaders.h
//  UICollectionViewTest
//
//  Created by zhangjj on 15/12/24.
//  Copyright © 2015年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define fNavBarHeigth (IOS7==YES ? 64 : 44)

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)
#define Identifier @"collectionCellIdentifier"
#define HeadIdentifier @"collectionViewHead"
#define CustomCellIdentifier @"cellTypeTwo"
#import "DBTool.h"

@interface JJHeaders : NSObject

@end
