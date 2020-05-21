//
//  HSDataSourceManager.h
//  FMDBDemo
//
//  Created by Hanser on 2020/5/1.
//  Copyright © 2020 Hanser. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *kCellId = @"cellId";


@class HSSqliteModel;
@interface HSDataSourceManager : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <HSSqliteModel *>*dataArr;

- (void)updateSourceData:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
