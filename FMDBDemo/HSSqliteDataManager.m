//
//  HSSqliteDataManager.m
//  FMDBDemo
//
//  Created by Hanser on 2020/5/1.
//  Copyright © 2020 Hanser. All rights reserved.
//

#import "HSSqliteModel.h"
#import "HSSqliteDataManager.h"
#import "QYGCLDataBaseHelper.h"

#define kBaseUUID 10000


@implementation HSSqliteDataManager

+ (NSArray *)createDatas {
    NSMutableArray *mArr = NSMutableArray.new;
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        for (NSInteger i = 0; i < 10; i++) {
            HSSqliteModel *model = HSSqliteModel.new;
            model.name = [NSString stringWithFormat:@"hanser_%ld", i];
            model.phone = [NSString stringWithFormat:@"phone_132333%ld", i];
            model.ID = [NSString stringWithFormat:@"%ld", i];
            model.score = [NSString stringWithFormat:@"%ld",i + 10];
            [mArr addObject:model];
        }
//    });
    return mArr.copy;
}



@end
