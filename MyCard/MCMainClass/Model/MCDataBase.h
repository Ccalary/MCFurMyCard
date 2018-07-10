//
//  MCDataBase.h
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCModel;
@interface MCDataBase : NSObject
+ (instancetype)sharedDataBase;

- (void)addMCModel:(MCModel *)model;
- (NSMutableArray *)getAllModel;
- (void)deleteModel:(MCModel *)model;
- (void)deleteAllModel;
@end
