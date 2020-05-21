//
//  QYGCLDataBaseHelper.h
//  grandlive
//
//  Created by Hanser on 2020/4/26.
//

#import <Foundation/Foundation.h>
//#import "FMDB.h"


#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "HSSqliteModel.h"

#define kSqliteName @"SqliteName"
#define kSqliteTabName @"TabName"


NS_ASSUME_NONNULL_BEGIN


typedef void(^QYGCLOpenSqliteSuccess)(void);
typedef void(^QYGCLOpenSqliteFailure)(void);
typedef void(^QYGCLSqliteBlock)(id __nullable data);


@interface QYGCLDataBaseHelper : NSObject

/// 创建
/** 创建数据库 */
+ (void)createSqlite:(NSString *)sqliteName;
/** 创建表 */
+ (void)createTableWithName:(NSString *)tableName;
+ (void)createTableWithName:(NSString *)tableName elements:(NSArray<NSString *> *)elements;


/// 打开、关闭
/** 打开数据库 */
+ (BOOL)openSqliteWithBlock:(QYGCLOpenSqliteSuccess __nullable)success failure:(QYGCLOpenSqliteFailure __nullable)failure;
/** 关闭数据库 */
+ (BOOL)closeSqliteWithBlock:(QYGCLOpenSqliteSuccess __nullable)success failure:(QYGCLOpenSqliteFailure __nullable)failure;

/// 增删改查
/** 添加单条数据 */
+ (void)addData:(NSString *)tableName model:(HSSqliteModel *)model success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 添加多条数据 */
+ (void)addData:(NSString *)tableName models:(NSArray <HSSqliteModel *>*)models success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 查询单条数据 */
+ (void)selectSqliteWithTable:(NSString *)tableName sqliteId:(NSString *)sqliteId success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 查询多条数据 */
+ (void)selectSqliteWithTable:(NSString *)tableName sqliteIdArray:(NSArray *)sqliteIdArray success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 查询数据库中所有数据 */
+ (void)selectSqliteAllDataWithTable:(NSString *)tableName success:(QYGCLSqliteBlock)success fail:(QYGCLSqliteBlock)failure;
/** 删除中举苦中某一条数据 */
+ (void)deleteSqliteWithTable:(NSString *)tableName sqliteId:(NSString *)sqliteId success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 删除数据库中多条数据 */
+ (void)deleteSqliteArrayWithTable:(NSString *)tableName sqliteArray:(NSArray *)sqliteArray success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 删除数据库中所有数据 */
+ (void)deleteSquliteAllDataWithTable:(NSString *)tableName success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 修改数据库中单条数据 */
+ (void)updateSqliteWithTable:(NSString *)tableName sqliteId:(NSString *)sqliteId model:(id)model success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 修改数据库中多条数据 */
+ (void)updateSqliteWithTable:(NSString *)tableName models:(NSArray *)models success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;
/** 指定表添加属性 */
+ (void)addPropertyWithTable:(NSString *)tableName property:(NSString *)property success:(QYGCLSqliteBlock)success failure:(QYGCLSqliteBlock)failure;

/// 数据迁移
/** 迁移表的数据到一张新表 */
+ (BOOL)removalDataToTable:(NSString *)targetTable sourceTable:(NSString *)sourceTable;


@end

NS_ASSUME_NONNULL_END
