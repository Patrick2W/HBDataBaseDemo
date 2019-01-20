//
//  HBDao.m
//  HBDataBaseDemo
//
//  Created by Patrick W on 2019/1/17.
//  Copyright © 2019 P.W. All rights reserved.
//

#import "HBDao.h"

@implementation HBDao


- (NSUInteger)insert:(NSDictionary *)obj {
    
    return [self insert:obj error:nil];
}

- (NSUInteger)insert:(NSDictionary *)obj error:( NSString * _Nullable *_Nullable)error {
    
    __block NSInteger lastInsertRowId = 0;
    
    FMDB_DATABASE_START
    
    NSMutableDictionary *rowObj = [NSMutableDictionary dictionaryWithDictionary:obj];
    NSArray *keys = obj.allKeys;
    if ([keys containsObject:self.PKName]) {
        [rowObj removeObjectForKey:self.PKName];
    }
    NSString *keyStr = [keys componentsJoinedByString:@"],["];
    NSString *valueStr = [keys componentsJoinedByString:@",:"];
    NSString *sql = FMDB_SF(@"INSERT INFO [%@] ([%@]) VALUES (:%@)", self.TBName, keyStr, valueStr);
    BOOL ret = [db executeUpdate:sql withParameterDictionary:obj];
    if ([db hadError]) {
        if (error) {
            *error = [db lastErrorMessage];
        }
    }
    if (ret) lastInsertRowId = [db lastInsertRowId];
    
    FMDB_DATABASE_END
    
    return lastInsertRowId;
}



- (double)sum:(NSString *)field {
    
    return [self sum:field condition:@"1=1"];
}

- (double)sum:(NSString *)field condition:(NSString *)condition {
    if (!condition) condition = @"1=1";
    __block double sum = 0;
    FMDB_DATABASE_START
    // SQL
    NSString *sql = FMDB_SF(@"SELECT SUM([%@]) FROM ([%@]) WHERE ([%@])", field, self.TBName, condition);
    FMResultSet *rs = [db executeQuery:sql];
    if ([db hadError]) {
        // Error
    } else if ([rs next]) {
        sum = [rs doubleForColumnIndex:0];
    }
    [rs close];
    FMDB_DATABASE_END
    return sum;
}

- (NSUInteger)count {
    
    return [self countWithCondition:@"1=1"];
}

- (NSUInteger)countWithCondition:(NSString *)condition {
    if (!condition) condition = @"1=1";
    __block NSUInteger count = 0;
    FMDB_DATABASE_START
    NSString *sql = FMDB_SF(@"SELECT COUNT([%@]) FROM ([%@]) WHERE ([%@])", self.PKName, self.TBName, condition);
    FMResultSet *rs = [db executeQuery:sql];
    if ([db hadError]) {
        
    } else if ([rs next]) {
        count = [rs intForColumnIndex:0];
    }
    FMDB_DATABASE_END
    return count;
}

- (BOOL)isExistPrimaryKeyValue:(id)value {
    
    return [self isExistValue:value byKey:self.PKName];
}

- (BOOL)isExistValue:(id)value byKey:(NSString *)key {
    
    return [self isExistByConditions:@{key: value}];
}

- (BOOL)isExistByConditions:(NSDictionary *)conditions {
    __block BOOL isExist = NO;
    
    FMDB_DATABASE_START
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT COUNT(*) FROM ([%@])", self.TBName];
    NSArray *keys = conditions.allKeys;
    NSUInteger count = keys.count;
    if (count > 0) {
        [sql appendString:@" WHERE "];
        NSUInteger idx = 0;
        for (NSString *key in keys) {
            [sql appendString:@"["];
            [sql appendString:key];
            [sql appendString:@"]=:"];
            idx ++;
            if (count > idx + 1) {
                [sql appendString:@" AND "];
            }
        }
    }
    FMResultSet *rs = [db executeQuery:sql withParameterDictionary:conditions];
    if ([db hadError]) {
        
    } else if ([rs next]) {
        isExist = [rs intForColumnIndex:0] > 0;
    }
    FMDB_DATABASE_END
    return isExist;
}


@end
