//
//  MCHomeViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCHomeViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "MCAddCardVC.h"
#import "MCLoginViewController.h"

@interface MCHomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerView;

@end

@implementation MCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self mc_initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)mc_initView {
   SDCycleScrollView *_advScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 160)  delegate:self placeholderImage:[UIImage imageNamed:@""]];
    _advScrollView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof (self) weakSelf = self;
    _advScrollView.clickItemOperationBlock  = ^(NSInteger i){
        NSString *title;
        if (i == 0){
            title = @"信用卡";
        }else {
            title = @"储蓄卡";
        }
        [self pushWithTitle:title];
        
    };
    _advScrollView.autoScrollTimeInterval = 3.0f;
    _advScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _advScrollView.localizationImageNamesGroup = @[[UIImage imageNamed:@"banner1"],[UIImage imageNamed:@"banner2"]];
    [self.bannerView addSubview:_advScrollView];
}

- (IBAction)cardBtnAction:(UIButton *)sender {
    
    [self pushWithTitle:[sender currentTitle]];
}

- (void)pushWithTitle:(NSString *)title {
    
    if ([MCUserHelper mc_isLogin]){
        MCAddCardVC *vc = [[MCAddCardVC alloc] init];
        vc.navigationItem.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
         [self.navigationController pushViewController:[[MCLoginViewController alloc] init] animated:YES];
    }
}
@end
