//
//  MCModel.h
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCModel : NSObject
@property (nonatomic, strong) NSNumber *r_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *numbers;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, strong) NSData *frontData;
@property (nonatomic, strong) NSData *backData;
@end
