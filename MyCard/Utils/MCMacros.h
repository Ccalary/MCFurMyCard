
//
//  MCMacros.h
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#ifndef MCMacros_h
#define MCMacros_h

//大小尺寸（宽、高）
#define ScreenWidth                     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                    [[UIScreen mainScreen] bounds].size.height
//statusBar高度
#define StatusBarHeight                 [UIApplication sharedApplication].statusBarFrame.size.height
//navBar高度
#define NavigationBarHeight             [[UINavigationController alloc] init].navigationBar.frame.size.height
//TabBar高度  iPhoneX 高度为83
#define TabBarHeight                    ((StatusBarHeight > 20.0f) ? 83.0f : 49.0f)
//nav顶部高度
#define TopFullHeight                   (StatusBarHeight + NavigationBarHeight)

#endif /* MCMacros_h */
