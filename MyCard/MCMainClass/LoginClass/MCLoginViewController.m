//
//  MCLoginViewController.m
//  MyCard
//
//  Created by caohouhong on 2018/7/9.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCLoginViewController.h"
#import "MCRigisterViewController.h"
#import "MCForgetViewController.h"
#import "MCModel.h"
#import "MCDataBase.h"

@interface MCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation MCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)rigisterAction:(id)sender {
    [self.navigationController pushViewController:[[MCRigisterViewController alloc] init] animated:YES];
}


- (IBAction)loginAction:(id)sender {
    
    
    
    if ([self.name.text isEqualToString:@"stone"] && [self.password.text isEqualToString:@"123456"]){
        [LCProgressHUD showSuccess:@"登录成功"];
        [MCUserHelper mc_setUserName:@"stone"];
        [MCUserHelper mc_setLoginWithString:@"1"];
        
        MCModel *vipModel = [[MCModel alloc] init];
        vipModel.name = @"饭卡";
        vipModel.type = @"会员卡";
        vipModel.numbers = @"771129";
        vipModel.remarks = @"海之家";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHMMss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        vipModel.addTime = dateStr;
        UIImage *imageFront = [UIImage imageNamed:@"vip_front"];
        NSData *data = UIImageJPEGRepresentation(imageFront, 0.1);
        [MCUserHelper mc_setImageData:data WithKey:[NSString stringWithFormat:@"front%@",dateStr]];
        UIImage *imageback = [UIImage imageNamed:@"vip_back"];
        NSData *dataBack = UIImageJPEGRepresentation(imageback, 0.1);
        [MCUserHelper mc_setImageData:dataBack WithKey:[NSString stringWithFormat:@"back%@",dateStr]];
        
        [[MCDataBase sharedDataBase] addMCModel:vipModel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
        });
    }
}

- (IBAction)forgotAction:(id)sender {
   [self.navigationController pushViewController:[[MCForgetViewController alloc] init] animated:YES];
}

@end
