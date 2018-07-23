//
//  MCRigisterViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCRigisterViewController.h"
#import "SendCodeButton.h"
#import "MCProtocolViewController.h"
#import "BaseWebViewController.h"

@interface MCRigisterViewController ()<SendCodeButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *code;

@end

@implementation MCRigisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    SendCodeButton *button = [[SendCodeButton alloc] initWithTitle:@"发送验证码" seconds:60];
    [button setTitleColor:[UIColor mc_themeColor] forState:UIControlStateNormal];
    button.delegate = self;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.code.mas_right).offset(10);
        make.right.mas_equalTo(self.view).offset(-15);
        make.centerY.mas_equalTo(self.code);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)sendCodeButtonClick{
    if (self.name.text.length != 11){
        [LCProgressHUD showFailure:@"请输入正确的手机号"];
    }else {
        [MCTools doGetWithCity:@"无锡" success:^(NSURLSessionDataTask *operation, NSDictionary *responseDic) {
            [LCProgressHUD showSuccess:@"验证码发送成功"];
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }
}
- (IBAction)protocolAction:(UIButton *)sender {
    MCProtocolViewController *vc = [[MCProtocolViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)registerAction:(id)sender {
    [LCProgressHUD showFailure:@"验证码不正确"];
}

// 隐私政策
- (IBAction)secretAction:(UIButton *)sender {
    BaseWebViewController *vc = [[BaseWebViewController alloc] initWithTitle:@"隐私政策" andUrl:@"https://ccalary.github.io/MCWebsite/"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
