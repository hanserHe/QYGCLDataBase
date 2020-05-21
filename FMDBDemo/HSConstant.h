//
//  HSConstant.h
//  FMDBDemo
//
//  Created by Hanser on 2020/5/1.
//  Copyright © 2020 Hanser. All rights reserved.
//

#ifndef HSConstant_h
#define HSConstant_h


typedef NS_OPTIONS (NSUInteger, HSSqliteClickType) {
    HSSqliteCreateTableType             = 0,
    HSSqliteInsertDataType              = 1 << 0,
    HSSqliteUpdateDataType              = 1 << 1,
    HSSqliteLookoverDataType            = 1 << 2,
    HSSqliteInsertDatasType             = 1 << 3,
    HSSqliteDeleteDataType              = 1 << 4,
    HSSqliteLookoverAllDatasType        = 1 << 5,
    HSSqliteDeleteAllDatasType          = 1 << 6,
    HSSqliteRemovalDatasType            = 1 << 7,
};


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kLScreenHeight [UIScreen mainScreen].bounds.size.height

#define kIsPhone6Plus (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 414)
#define kIsPhone5OrLess   (([UIScreen mainScreen].bounds.size.width <= 320) || ([UIScreen mainScreen].bounds.size.height <= 320))
#define kMainScreenScale [UIScreen mainScreen].scale

#define UIColorFromRGB(v) UIColorFromRGBA(v,1)
#define UIColorFromRGBA(rgbValue, alphav)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(alphav)]

#endif /* HSConstant_h */
