//
//  HBDataBaseHelper.h
//  HBDataBaseDemo
//
//  Created by Patrick W on 2019/1/14.
//  Copyright © 2019 P.W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBDataBaseHelper : NSObject

@property (class, nonatomic, readonly) HBDataBaseHelper *shared;

- (void)openWithDataBasePath:(NSString *)path;

- (void)closeDataBase;

@end

NS_ASSUME_NONNULL_END
