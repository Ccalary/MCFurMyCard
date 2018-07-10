//
//  MCBaseTabBaeController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCBaseTabBaeController.h"
#import "MCHomeViewController.h"
#import "MCMeViewController.h"
#import "MCShowViewController.h"
#import "MCBaseNavigationController.h"


@interface MCBaseTabBaeController ()

@end

@implementation MCBaseTabBaeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UITabBar appearance].tintColor = [UIColor mc_themeColor];
    [self mc_addChildVCs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)mc_addChildVCs{
    
    [self mc_addVC:[[MCHomeViewController alloc] init] title:@"首页" normalImageStr:@"t_home" selectImageStr:@"t_home"];
    [self mc_addVC:[[MCShowViewController alloc] init] title:@"列表" normalImageStr:@"t_show" selectImageStr:@"t_show"];
    [self mc_addVC:[[MCMeViewController alloc] init] title:@"我" normalImageStr:@"t_me" selectImageStr:@"t_me"];
}

- (void)mc_addVC:(UIViewController *)childVC title:(NSString *)title normalImageStr:(NSString *)imageName selectImageStr:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    MCBaseNavigationController *baseNav = [[MCBaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}


@end
