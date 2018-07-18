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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *card1;
@property (weak, nonatomic) IBOutlet UIButton *card2;
@property (weak, nonatomic) IBOutlet UIButton *card3;
@property (weak, nonatomic) IBOutlet UIButton *card4;
@property (weak, nonatomic) IBOutlet UIButton *card5;

@end

@implementation MCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mc_initView];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)initView {
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight - TopFullHeight - TabBarHeight);
    [self.view addSubview:self.scrollView];
    [self.view bringSubviewToFront:self.scrollView];
    [self.scrollView addSubview:_bannerView];
    [self.scrollView addSubview:_card1];
    [self.scrollView addSubview:_card2];
    [self.scrollView addSubview:_card3];
    [self.scrollView addSubview:_card4];
    [self.scrollView addSubview:_card5];
    CGFloat gapHeight = 15;
    CGFloat bigCardHeight = (ScreenHeight - TopFullHeight - TabBarHeight - 160 - 30 - gapHeight*2)/2.0;
    if (bigCardHeight > 170){
        bigCardHeight = 170;
    }
    CGFloat smallCardHeight = (bigCardHeight*2-gapHeight)/3.0;

    [_card1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth/2.0 - 10);
        make.height.mas_equalTo(bigCardHeight);
        make.top.mas_equalTo(self.bannerView.mas_bottom).offset(gapHeight);
        make.left.mas_equalTo(self.view);
    }];
    
    [_card2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.height.mas_equalTo(self.card1);
        make.top.mas_equalTo(self.card1.mas_bottom).offset(gapHeight);
    }];
    
    [_card3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth/2.0 - 10);
        make.height.mas_equalTo(smallCardHeight);
        make.top.mas_equalTo(self.card1);
        make.right.mas_equalTo(self.view);
    }];
    
    [_card4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.mas_equalTo(self.card3);
        make.top.mas_equalTo(self.card3.mas_bottom).offset(gapHeight);
    }];
    
    [_card5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.mas_equalTo(self.card3);
        make.top.mas_equalTo(self.card4.mas_bottom).offset(gapHeight);
    }];
}

- (void)mc_initView {
   SDCycleScrollView *_advScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 160)  delegate:self placeholderImage:[UIImage imageNamed:@""]];
    _advScrollView.backgroundColor = [UIColor whiteColor];
    
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
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(160);
        make.centerX.mas_equalTo(self.view);
        make.top.offset(0);
    }];
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
