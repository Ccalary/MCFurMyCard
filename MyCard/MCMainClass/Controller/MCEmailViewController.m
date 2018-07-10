//
//  MCEmailViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCEmailViewController.h"
#import "MCEmailSurViewController.h"
#import "MCTools.h"

@interface MCEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation MCEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定邮箱";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)sendAction:(id)sender {
    if ([MCTools checkEmail:self.email.text]){
        MCEmailSurViewController *vc = [[MCEmailSurViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [LCProgressHUD showFailure:@"邮箱地址不正确"];
    }
}


@end
