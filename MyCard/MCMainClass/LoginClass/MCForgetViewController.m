//
//  MCForgetViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCForgetViewController.h"

@interface MCForgetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation MCForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"忘记密码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)rightBarAction {
    if ([MCTools checkEmail:self.emailTextField.text]){
        [LCProgressHUD showSuccess:@"密码发送成功！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }else {
        [LCProgressHUD showFailure:@"邮箱不正确"];
    }
}



@end
