//
//  UIColor+MCColor.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "UIColor+MCColor.h"

@implementation UIColor (MCColor)
//MARK:- Theme
+ (UIColor *)mc_themeColor{
    return [UIColor mc_colorWithHex:0xfa7f00];
}

//MARK:- Method
+ (UIColor *)mc_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor *)mc_colorWithHex:(NSInteger)hexValue
{
    return [UIColor mc_colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*)mc_randomColor
{
    return [UIColor colorWithRed:(arc4random()%255)*1.0f/255.0
                           green:(arc4random()%255)*1.0f/255.0
                            blue:(arc4random()%255)*1.0f/255.0 alpha:1.0];
}
@end
