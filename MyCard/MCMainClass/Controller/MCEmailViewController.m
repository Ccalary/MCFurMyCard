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
@property (nonatomic, strong) UITextView *textView;
@end

@implementation MCEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"举报";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"举报" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [self mc_initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)mc_initView {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请输入举报内容";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.layer.borderWidth = 1;
    textView.layer.borderColor= [UIColor lightGrayColor].CGColor;
    textView.layer.cornerRadius = 5.0;
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    self.textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-15);
    }];
}

- (void)rightBarAction {
    if (self.textView.text.length == 0){
        [LCProgressHUD showFailure:@"请输入举报内容"];
        return;
    }
    [MCTools doGetWithCity:@"北京" success:^(NSURLSessionDataTask *operation, NSDictionary *responseDic) {
        [LCProgressHUD showSuccess:@"举报成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
