//
//  HSDataSourceManager.m
//  FMDBDemo
//
//  Created by Hanser on 2020/5/1.
//  Copyright © 2020 Hanser. All rights reserved.
//

#import "HSDataSourceManager.h"
#import "HSTableViewCell.h"
#import "HSSqliteDataManager.h"
#import "QYGCLDataBaseHelper.h"

@interface HSDataSourceManager ()


@end

@implementation HSDataSourceManager


- (instancetype)init {
    self = [super init];
    if (self) {
        _dataArr = NSMutableArray.new;
    }
    return self;
}


- (void)updateSourceData:(NSArray *)data
{
    [self.dataArr removeAllObjects];
    for (NSDictionary *dic in data) {
        HSSqliteModel *model = [[HSSqliteModel alloc] initWithDic:dic];
        [self.dataArr addObject:model];
    }
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    HSSqliteModel *model = [self.dataArr objectAtIndex:indexPath.row];
    [cell update:model];
    return cell;
}




@end
