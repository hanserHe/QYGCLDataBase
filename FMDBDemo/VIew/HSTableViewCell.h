//
//  HSTableViewCell.h
//  FMDBDemo
//
//  Created by Hanser on 2020/5/1.
//  Copyright © 2020 Hanser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HSSqliteModel;
@interface HSTableViewCell : UITableViewCell

- (void)update:(HSSqliteModel *)model;

@end

NS_ASSUME_NONNULL_END
