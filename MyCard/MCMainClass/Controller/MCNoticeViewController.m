//
//  MCNoticeViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCNoticeViewController.h"
#import "RunLabelView.h"

@interface MCNoticeViewController ()

@end

@implementation MCNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"公告栏";
    [self runLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)runLabel {
    RunLabelView *runLabel = [[RunLabelView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    runLabel.speed = 0.5;
    runLabel.backgroundColor = [UIColor mc_colorWithHex:0xcccccc alpha:0.3];
    runLabel.text = @"公告：感谢您使用本产品，为了提供更好的服务，请及时绑定邮箱，谢谢您的支持";
    [self.view addSubview:runLabel];
}
@end
