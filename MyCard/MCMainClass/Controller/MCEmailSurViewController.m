//
//  MCEmailSurViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCEmailSurViewController.h"

@interface MCEmailSurViewController ()
@property (weak, nonatomic) IBOutlet UITextField *code;

@end

@implementation MCEmailSurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)sureAction:(id)sender {
    if (self.code.text.length < 4){
        [LCProgressHUD showFailure:@"验证码不能少于4位"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [LCProgressHUD showFailure:@"验证码不正确"];
         self.code.text = @"";
    });
}

@end
