//
//  MCTools.h
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCTools : NSObject
+ (BOOL)checkEmail:(NSString *)email;
+ (void)doGetWithCity:(NSString *)city success:(void (^)(NSURLSessionDataTask *operation, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end
