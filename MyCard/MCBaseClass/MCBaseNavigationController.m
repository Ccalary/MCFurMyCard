//
//  MCBaseNavigationController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCBaseNavigationController.h"

@interface MCBaseNavigationController ()
@property (nonatomic, assign) CGRect tabRect;
@end

@implementation MCBaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO; //设置了之后自动下沉64
    
    self.navigationBar.barTintColor = [UIColor mc_themeColor];
    // 中间title颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor]; // 左右颜色
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"n_back22"] style:UIBarButtonItemStylePlain target:self action:@selector(mc_back)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)mc_back{
    [self popViewControllerAnimated:YES];
}

@end
