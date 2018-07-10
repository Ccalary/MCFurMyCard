//
//  MCUserHelper.h
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUserHelper : NSObject
+ (BOOL)mc_isLogin;
/* 1-登录 其他-未登录*/
+ (void)mc_setLoginWithString:(NSString *)login;

+ (NSString *)mc_getUsername;
+ (void)mc_setUserName:(NSString *)name;

+ (void)mc_setHeaderData:(NSData *)data;
+ (NSData *)mc_getHeaderData;

+ (void)mc_setImageData:(NSData *)data WithKey:(NSString *)key;
+ (NSData *)mc_getImagedataWithKey:(NSString *)key;
@end
