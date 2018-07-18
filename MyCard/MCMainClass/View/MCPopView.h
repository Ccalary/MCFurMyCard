//
//  MCPopView.h
//  MyCard
//
//  Created by caohouhong on 2018/7/13.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cellBlock)(NSString *name);
@interface MCPopView : UIView
@property (nonatomic, copy) cellBlock block;
- (void)pop;
@end
