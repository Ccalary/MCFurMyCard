//
//  UIColor+MCColor.h
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MCColor)
/** 主题颜色 fd8100 橘黄色*/
+ (UIColor *)mc_themeColor;


#pragma mark - 方法
+ (UIColor *)mc_colorWithHex:(NSInteger)hexValue;
+ (UIColor *)mc_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)mc_randomColor;
@end
