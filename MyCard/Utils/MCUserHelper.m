//
//  MCUserHelper.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCUserHelper.h"

@implementation MCUserHelper
+ (BOOL)mc_isLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *login = [defaults objectForKey:@"isLogin"];
    return [@"1" isEqualToString:login];
}

/* 1-登录 其他-未登录*/
+ (void)mc_setLoginWithString:(NSString *)login {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:login forKey:@"isLogin"];
    [defaults synchronize];
}

+ (NSString *)mc_getUsername {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"username"];
    return name;
}

/* 用户*/
+ (void)mc_setUserName:(NSString *)name {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:name forKey:@"username"];
    [defaults synchronize];
}

+ (void)mc_setHeaderData:(NSData *)data{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:data forKey:@"headerData"];
    [defaults synchronize];
}

+ (NSData *)mc_getHeaderData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *image = [defaults objectForKey:@"headerData"];
    return image;
}

+ (void)mc_setImageData:(NSData *)data WithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:data forKey:key];
    [defaults synchronize];
}

+ (NSData *)mc_getImagedataWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *image = [defaults objectForKey:key];
    return image;
}

@end
