//
//  HBDataBaseHelper.m
//  HBDataBaseDemo
//
//  Created by Patrick W on 2019/1/14.
//  Copyright © 2019 P.W. All rights reserved.
//

#import "HBDataBaseHelper.h"

@implementation HBDataBaseHelper

+ (HBDataBaseHelper *)shared {
    static HBDataBaseHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[HBDataBaseHelper alloc] init];
    });
    return helper;
}


- (void)openWithDataBasePath:(NSString *)path {
    /*  path路径是否存在 ？
        存在 --> 初始化DBQueue
        不存在 --> 初始化DBQueue，创建表
    */
}

- (void)closeDataBase {
    
}

@end
