//
//  MCRigisterViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCRigisterViewController.h"

@interface MCRigisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation MCRigisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)registerAction:(id)sender {
    if ([MCTools checkEmail:self.name.text]){
        [LCProgressHUD showKeyWindowSuccess:@"信息已发送到邮箱"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }else {
         [LCProgressHUD showFailure:@"邮箱地址不正确"];
    }
}
@end
