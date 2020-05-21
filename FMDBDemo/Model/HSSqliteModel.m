//
//  HSSqliteModel.m
//  FMDBDemo
//
//  Created by Hanser on 2020/5/1.
//  Copyright © 2020 Hanser. All rights reserved.
//

#import "HSSqliteModel.h"

@implementation HSSqliteModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
