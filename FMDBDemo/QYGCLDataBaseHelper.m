//
//  QYGCLDataBaseHelper.m
//  grandlive
//
//  Created by Hanser on 2020/4/26.
//

#import "QYGCLDataBaseHelper.h"


static FMDatabase *kQYGCLDataBase = nil;

@implementation QYGCLDataBaseHelper

+ (void)createSqlite:(NSString *)sqliteName {
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingString:sqliteName];
    /// 判断是否存在地址，如果存在说明已经建过或者易经理存在该地址
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:dbPath];
    kQYGCLDataBase = [FMDatabase databaseWithPath:dbPath];
    if (result) {
        NSLog(@"已经创建过");
    } else {
        NSLog(@"新建成功");
    }
}

+ (void)createTableWithName:(NSString *)tableName {
    // 检查数据库是否打开，没打开要打卡数据库才能建表
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        #warning 根据表的内容此处要修改
        // 打开之后创建表，ID是搜索关键字
//        NSString *tableNameString = [NSString stringWithFormat:@"create table if not exists %@('ID' INTEGER PRIMARY KEY AUTOINCREMENT , 'name' TEXT NOT NULL, 'phone' TEXT NOT NULL, 'score' TEXT NOT NULL)",tableName];
        NSString *tableNameString = [NSString stringWithFormat:@"create table if not exists %@('ID' INTEGER PRIMARY KEY AUTOINCREMENT , 'name' TEXT NOT NULL, 'phone' TEXT NOT NULL, 'score' TEXT NOT NULL)",tableName];

        BOOL result = [kQYGCLDataBase executeUpdate:tableNameString];
        if (result) {
            NSLog(@"建表成功");
        } else {
            NSLog(@"建表失败");
        }
        [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
    } failure:^{
        NSLog(@"打开数据库失败");
    }];
}



+ (BOOL)openSqliteWithBlock:(QYGCLOpenSqliteSuccess)success failure:(QYGCLOpenSqliteFailure)failure {
    if ([kQYGCLDataBase open]){
        NSLog(@"游戏直播---打开数据库成功");
        success();
        return YES;;
    } else {
        NSLog(@"游戏直播---打开数据库失败");
        failure();
        return NO;
    }
}

+ (BOOL)closeSqliteWithBlock:(QYGCLOpenSqliteSuccess)success failure:(QYGCLOpenSqliteFailure)failure {
    if ([kQYGCLDataBase close]) {
        NSLog(@"游戏直播---关闭数据库成功");
        if (success) {
            success();
        }
        return YES;
    } else {
        NSLog(@"游戏直播---关闭数据库失败");
        if (failure) {
            failure();
        }
        return NO;;
    }
}



+ (void)createTableWithName:(NSString *)tableName elements:(NSArray<NSString *> *)elements {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        NSMutableString *tabNameString = [[NSMutableString alloc] initWithFormat:@"create table if not exists %@('ID' INTEGER PRIMARY KEY AUTOINCREMENT",tableName];
        [elements enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *tmp = [NSString stringWithFormat:@", '%@' TEXT NOT NULL", obj];
            [tabNameString appendString:tmp];
        }];
        [tabNameString appendString:@")"];
        
        BOOL result = [kQYGCLDataBase executeUpdate:tabNameString];
        if (result) {
            NSLog(@"建表成功");
        } else {
            NSLog(@"建表失败");
        }
    } failure:^{
        NSLog(@"打开数据库失败");
    }];
}


+ (void)addData:(NSString *)tableName model:(HSSqliteModel *)model success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
//    NSDictionary *dic =

    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
#pragma warning - 此处要解析Model然后拼接
//            BOOL result = [kQYGCLDataBase executeUpdate:[NSString stringWithFormat:@"insert into '%@'(ID,name,phone,score) values(?,?,?,?)", tableName] withArgumentsInArray:@[model.uuid, model.name, model.phone, model.score]];

//            BOOL result = [kQYGCLDataBase executeUpdate:[NSString stringWithFormat:@"insert into '%@'(ID,name,phone,score) values(?,?,?,?)", tableName] withArgumentsInArray:@[model.uuid, model.name, model.phone, model.score]];
            
            BOOL result = [kQYGCLDataBase executeUpdate:[NSString stringWithFormat:@"insert into '%@'(ID,name,phone,score) values(?,?,?,?)", tableName] withArgumentsInArray:@[model.ID, model.name, model.phone, model.score]];

            
            if (result) {
                NSLog(@"插入数据成功");
                success(nil);
            } else {
                NSLog(@"插入数据失败");
                failure(nil);
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }
    } failure:^{
        
    }];
    
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
}

+ (void)addData:(NSString *)tableName models:(NSArray <HSSqliteModel *>*)models success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        // 遍历添加
        BOOL isRollBack = NO;
        @try {
            NSMutableArray *mArr = NSMutableArray.new;
            [models enumerateObjectsUsingBlock:^(HSSqliteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BOOL result = [kQYGCLDataBase executeUpdate:[NSString stringWithFormat:@"insert into '%@'(ID,name, phone, score) values(?,?,?,?)", tableName] withArgumentsInArray:@[obj.ID, obj.name, obj.phone, obj.score]];
                if (result) {
                    [mArr addObject:obj];
                    NSLog(@"插入成功");
                } else {
                    NSLog(@"插入失败");
                }
            }];
            success(mArr);
        } @catch (NSException *exception) {
            isRollBack = YES;
            [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }
        
    } failure:^{
        failure(nil);
    }];
    
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
}

+ (void)selectSqliteWithTable:(NSString *)tableName sqliteId:(NSString *)sqliteId success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            NSString *selectString = [NSString stringWithFormat:@"select * from %@ where ID = ?", tableName];
            FMResultSet *result = [kQYGCLDataBase executeQuery:selectString withArgumentsInArray:@[sqliteId]];
            if ([result next]) {
                success(result);
            } else {
                failure(result);
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }
    } failure:nil];
    
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
}


+ (void)selectSqliteWithTable:(NSString *)tableName sqliteIdArray:(NSArray *)sqliteIdArray success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            NSMutableArray *dataArr = NSMutableArray.new;
            [sqliteIdArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * string = [NSString stringWithFormat:@"select * from %@ where ID = ?", tableName];
            FMResultSet * result = [kQYGCLDataBase executeQuery:string withArgumentsInArray:@[obj]];
                if ([result next]) {
                    
                }else{
                    
                }
            }];
            success(dataArr);
        } @catch (NSException *exception) {
            isRollBack = YES;
            [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }

    } failure:^{
        
    }];
    
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
}


+ (void)selectSqliteAllDataWithTable:(NSString *)tableName success:(QYGCLSqliteBlock)success fail:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            NSMutableArray *dataArr = NSMutableArray.new;
            FMResultSet *set = [kQYGCLDataBase executeQuery:[NSString stringWithFormat:@"select * from %@", tableName]];
            while ([set next]) {
                // 解析模型
                NSMutableDictionary *dic = NSMutableDictionary.new;
                [dic setValue:[set stringForColumn:@"ID"] forKey:@"ID"];
                [dic setValue:[set stringForColumn:@"name"] forKey:@"name"];
                [dic setValue:[set stringForColumn:@"phone"] forKey:@"phone"];
                [dic setValue:[set stringForColumn:@"score"] forKey:@"score"];
                [dataArr addObject:dic];
            }
            success(dataArr);
        } @catch (NSException *exception) {
               isRollBack = YES;
               [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }
        
        [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
    } failure:^{
           
    }];
       
//    [QYGCLDataBaseHelper closeSqliteWithBlock:^{
//
//    } failure:^{
//
//    }];
}

+ (void)deleteSqliteWithTable:(NSString *)tableName sqliteId:(NSString *)sqliteId success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            NSString * string = [NSString stringWithFormat:@"delete  from %@ where ID = ?", tableName];
            BOOL result = [kQYGCLDataBase executeUpdate:string withArgumentsInArray:@[(sqliteId)]];
            if (result) {
                success(nil);
            }else{
                failure(nil);
            }
        } @catch (NSException *exception) {
               isRollBack = YES;
               [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }

    } failure:^{
           
    }];
       
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
}

+ (void)deleteSqliteArrayWithTable:(NSString *)tableName sqliteArray:(NSArray *)sqliteArray success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            NSString *strings = [NSString stringWithFormat:@"delete from %@ where ID = ?", tableName];
            NSMutableArray * deletes = NSMutableArray.new;
            [sqliteArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BOOL result = [kQYGCLDataBase executeUpdate:strings withArgumentsInArray:obj];
                if (result) {
                    NSLog(@"删除成功");
                }else{
                    NSLog(@"删除失败");
                    [deletes addObject:obj];
                }
            }];
            
            if (deletes.count == 0) {
                success(nil);
            } else {
                failure(nil);
            }
     
        } @catch (NSException *exception) {
               isRollBack = YES;
               [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }

    } failure:^{
           
    }];
       
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];

}


+ (void)deleteSquliteAllDataWithTable:(NSString *)tableName success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            BOOL result = [kQYGCLDataBase executeUpdate:[NSString stringWithFormat:@"delete from %@", tableName]];
            if (result) {
                NSLog(@"删除成功");
                success(nil);
            }else{
                NSLog(@"删除失败");
                failure(nil);
            }
          
        } @catch (NSException *exception) {
             isRollBack = YES;
             [kQYGCLDataBase rollback];
        } @finally {
          if (!isRollBack) {
              [kQYGCLDataBase commit];
          }
        }

    } failure:^{
         
    }];
     
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
}


+ (void)updateSqliteWithTable:(NSString *)tableName sqliteId:(NSString *)sqliteId model:(id)model success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            // 根据Model更新
            BOOL result = [kQYGCLDataBase executeUpdate:@"update persionTable set phone = ? , name = ? , score = ?  where ID = ?",@"" ,@"", @"",@"" ];
            if (result) {
                success(nil);
            }else{
                failure(nil);
            }
        } @catch (NSException *exception) {
             isRollBack = YES;
             [kQYGCLDataBase rollback];
        } @finally {
          if (!isRollBack) {
              [kQYGCLDataBase commit];
          }
        }

    } failure:^{
         
    }];
     
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];

}

+ (void)updateSqliteWithTable:(NSString *)tableName models:(NSArray *)models success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            NSMutableArray *deleteArr = NSMutableArray.new;
            [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                // 根据Model更新
                  BOOL result = [kQYGCLDataBase executeUpdate:@"update persionTable set phone = ? , name = ? , score = ?  where ID = ?",@"" ,@"", @"",@"" ];
                  if (result) {
                      success(nil);
                  }else{
                      failure(nil);
                  }
            }];
      
        } @catch (NSException *exception) {
            isRollBack = YES;
            [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }

    } failure:^{
         
    }];
     
    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];
}


+ (void)addPropertyWithTable:(NSString *)tableName property:(NSString *)property success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            if (![kQYGCLDataBase columnExists:property inTableWithName:tableName]) {
                NSString *alterString = [NSString stringWithFormat:@"ALTER TABLE 表%@ ADD %@ varchar", tableName, property];
                if ([kQYGCLDataBase executeUpdate:alterString]) {
                    NSLog(@"添加属性成功");
                }
            }

        } @catch (NSException *exception) {
            isRollBack = YES;
            [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }

    } failure:^{
       
    }];

    [QYGCLDataBaseHelper closeSqliteWithBlock:nil failure:nil];

}


+ (BOOL)removalDataToTable:(NSString *)targetTable sourceTable:(NSString *)sourceTable {
    [QYGCLDataBaseHelper openSqliteWithBlock:^{
        [kQYGCLDataBase beginTransaction];
        BOOL isRollBack = NO;
        @try {
            NSString *command = [NSString stringWithFormat:@"insert into %@ select * from %@", targetTable, sourceTable];
            if ([kQYGCLDataBase executeUpdate:command]) {
                NSLog(@"迁移成功");
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [kQYGCLDataBase rollback];
        } @finally {
            if (!isRollBack) {
                [kQYGCLDataBase commit];
            }
        }
    } failure:^{
        
    }];
    
    return NO;
}



@end
