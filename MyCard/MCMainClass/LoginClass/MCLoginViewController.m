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
    
    if ([self.name.text isEqualToString:@"13773047057"] && [self.password.text isEqualToString:@"123456"]){
        [LCProgressHUD showSuccess:@"登录成功"];
        [MCUserHelper mc_setUserName:@"13773047057"];
        [MCUserHelper mc_setLoginWithString:@"1"];
        
        MCModel *vipModel = [[MCModel alloc] init];
        vipModel.name = @"饭卡-海之家";
        vipModel.type = @"会员卡";
        vipModel.numbers = @"771129";
        vipModel.remarks = @"海之家8折饭卡，吃饭记得带着，充值有优惠";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd HH:MM:ss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        vipModel.addTime = dateStr;
        UIImage *imageFront = [UIImage imageNamed:@"vip_front"];
        NSData *data = UIImageJPEGRepresentation(imageFront, 0.1);
        [MCUserHelper mc_setImageData:data WithKey:[NSString stringWithFormat:@"front%@",dateStr]];
        UIImage *imageback = [UIImage imageNamed:@"vip_back"];
        NSData *dataBack = UIImageJPEGRepresentation(imageback, 0.1);
        [MCUserHelper mc_setImageData:dataBack WithKey:[NSString stringWithFormat:@"back%@",dateStr]];
        
        [[MCDataBase sharedDataBase] addMCModel:vipModel];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                MCModel *vipModel = [[MCModel alloc] init];
                vipModel.name = @"公交卡";
                vipModel.type = @"电子卡";
                vipModel.numbers = @"64401502407";
                vipModel.remarks = @"无锡公交出行8折卡";
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy.MM.dd HH:MM:ss"];
                NSString *dateStr = [formatter stringFromDate:[NSDate date]];
                vipModel.addTime = dateStr;
                UIImage *imageFront = [UIImage imageNamed:@"ecard_front"];
                NSData *data = UIImageJPEGRepresentation(imageFront, 0.1);
                [MCUserHelper mc_setImageData:data WithKey:[NSString stringWithFormat:@"front%@",dateStr]];
                UIImage *imageback = [UIImage imageNamed:@"ecard_back"];
                NSData *dataBack = UIImageJPEGRepresentation(imageback, 0.1);
                [MCUserHelper mc_setImageData:dataBack WithKey:[NSString stringWithFormat:@"back%@",dateStr]];
                
                [[MCDataBase sharedDataBase] addMCModel:vipModel];
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                MCModel *vipModel = [[MCModel alloc] init];
                vipModel.name = @"招商银行";
                vipModel.type = @"储蓄卡";
                vipModel.numbers = @"6214830151569869";
                vipModel.remarks = @"招商银行开户点北京天通苑分行";
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy.MM.dd HH:MM:ss"];
                NSString *dateStr = [formatter stringFromDate:[NSDate date]];
                vipModel.addTime = dateStr;
                UIImage *imageFront = [UIImage imageNamed:@"bank_front"];
                NSData *data = UIImageJPEGRepresentation(imageFront, 0.1);
                [MCUserHelper mc_setImageData:data WithKey:[NSString stringWithFormat:@"front%@",dateStr]];
                UIImage *imageback = [UIImage imageNamed:@"back_back"];
                NSData *dataBack = UIImageJPEGRepresentation(imageback, 0.1);
                [MCUserHelper mc_setImageData:dataBack WithKey:[NSString stringWithFormat:@"back%@",dateStr]];
                
                [[MCDataBase sharedDataBase] addMCModel:vipModel];
            });
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
        });
        
        [MCTools doGetWithCity:@"无锡" success:^(NSURLSessionDataTask *operation, NSDictionary *responseDic) {
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }
}

- (IBAction)forgotAction:(id)sender {
   [self.navigationController pushViewController:[[MCForgetViewController alloc] init] animated:YES];
}

@end
