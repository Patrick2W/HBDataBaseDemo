//
//  HBDao.h
//  HBDataBaseDemo
//
//  Created by Patrick W on 2019/1/17.
//  Copyright © 2019 P.W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>





@protocol HBDaoConfig <NSObject>

- (FMDatabaseQueue *_Nullable)dbQueue;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HBDao : NSObject

@property (weak, nonatomic) id<HBDaoConfig> config;

@property (nonatomic,copy) NSString* PKName;
@property (nonatomic,copy) NSString* TBName;


- (NSUInteger)insert:(NSDictionary *)obj;
- (NSUInteger)insert:(NSDictionary *)obj error:(NSError **)error;

- (NSInteger)remove:(NSDictionary *)obj;
- (NSInteger)update:(NSDictionary *)obj conditions:(NSDictionary *)conditions;

- (double)sum:(NSString *)field;
- (double)sum:(NSString *)field condition:(NSString *)condition;

- (NSUInteger)count;
- (NSUInteger)countWithCondition:(NSString *)condition;

- (BOOL)isExistPrimaryKeyValue:(id)value;
- (BOOL)isExistValue:(id)value byKey:(NSString *)key;
- (BOOL)isExistByConditions:(NSDictionary *)conditions;

//- (NSDictionary *)fetchByPrimaryKeyValue:(id)value;
//- (NSDictionary *)fetch:(id)value byKey:(NSString *)key;
//- (NSDictionary *)fecthByConditions:(NSDictionary *)conditions;

@end

NS_ASSUME_NONNULL_END


#define FMDB_SF(...)            [NSString stringWithFormat:__VA_ARGS__]
#define FMDB_DATABASE_START     [self.config.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
#define FMDB_DATABASE_END       }];
#define FMDB_TRANSACTION_START  [self.config.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
#define FMDB_TRANSACTION_END    }];
